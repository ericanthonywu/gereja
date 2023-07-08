const db = require("../config/database/connection")
const {errorHandlerSyntax} = require("../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../middleware/errorHandler/errorType");
const {checkExistTable} = require("../util");

exports.getKegiatan = async (req, res, next) => {
    try {
        const {pagination = 1} = req.query
        const limit = 10
        const offset = (pagination - 1) * limit

        const data = await db("kegiatan")
            .select(
                "id",
                "title",
                "image",
                "description_thumbnail",
                "event_date",
                "day_repeat_of_week",
                "time_after",
                "time_before",
                "canceled_at",
                db.raw(`(select exists(select 1 from kegiatan_user_registration where user_id = ${res.locals.jwtData.id})) as user_is_registered`)
            )
            .where("event_date", ">=", db.raw("CURRENT_DATE"))
            .where("time_after", ">=", db.raw("CURRENT_TIME"))
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.registerKegiatan = async (req, res, next) => {
    try {
        const {kegiatan_id} = req.body

        if (await checkExistTable(db("kegiatan_user_registration").where({user_id: res.locals.jwtData.id, kegiatan_id}))){
            return res.status(400).json({message: 'user sudah mendaftar'})
        }

        const {quota} = await db("kegiatan")
            .where({id: kegiatan_id})
            .first("quota")

        const {total} = await db("kegiatan_user_registration").where({id: kegiatan_id}).count("user_id as total").first()

        if (total > quota) {
            return res.status(400).json({message: 'quota sudah penuh'})
        }

        await db("kegiatan_user_registration")
            .insert({
                user_id: res.locals.jwtData.id, kegiatan_id
            })

        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}