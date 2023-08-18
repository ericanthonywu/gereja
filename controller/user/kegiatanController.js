const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");
const {checkExistTable} = require("../../util");

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
                "quota",
                "event_date",
                "day_repeat_of_week",
                "time_after",
                "time_before",
                "canceled_at",
                "created_at",
                db.raw(`(select exists(select 1 from kegiatan_user_registration where user_id = 1 and kegiatan_id = kegiatan.id)) as user_is_registered`)
            )
            .where(db.raw("IFNULL(event_date,CURRENT_DATE)"), ">=", db.raw("CURRENT_DATE"))
            // .where("time_after", ">=", db.raw("CURRENT_TIME"))
            .whereRaw("(IF(day_repeat_of_week is null, 7, day_repeat_of_week)) >= (IF(day_repeat_of_week is null, 7, DAYOFWEEK(current_date) - 1))")
            .orderBy("created_at","desc")
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getHistoryKegiatan = async (req, res, next) => {
    try {
        const {pagination} = req.query
        const limit = 10
        const offset = (pagination - 1) * limit

        const data = await db("kegiatan_user_registration")
            .select(
                "kegiatan_id",
                "title",
                "image",
                "description_thumbnail",
                "event_date",
                "time_after",
                "time_before",
            )
            .where({
                user_id: res.locals.jwtData.id
            })
            .join("kegiatan","kegiatan.id", "kegiata_user_registration.kegiatan_id")
            .orderBy("registered_at","desc")
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getKegiatanDetail = async (req, res, next) => {
    try {
        const {id} = req.params

        const data = await db("kegiatan")
            .first(
                "title",
                "image",
                "description",
                "event_date",
                "quota",
                "day_repeat_of_week",
                "time_after",
                "time_before",
                "canceled_at",
            )
            .where({id})

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.registerKegiatan = async (req, res, next) => {
    try {
        const {kegiatan_id} = req.body

        if (await checkExistTable(db("kegiatan_user_registration").where({
            user_id: res.locals.jwtData.id,
            kegiatan_id
        }))) {
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