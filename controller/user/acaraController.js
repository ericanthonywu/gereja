const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");
const {checkExistTable} = require("../../util");

exports.getAcara = async (req, res, next) => {
    try {
        const {pagination} = req.query
        const limit = 10
        const offset = (pagination - 1) * limit

        const data = await db("acara")
            .select(
                "id",
                "title",
                "image",
                "description_thumbnail",
                "event_date",
                "time_after",
                "time_before",
                db.raw(`(select exists(select 1 from acara_user_registration where user_id = ${res.locals.jwtData.id} and acara_id = acara.id)) as user_is_registered`),
                "created_at",
            )
            .where("event_date", ">=", db.raw("CURRENT_DATE"))
            .whereNull("canceled_at")
            .orderBy("created_at","desc")
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getHistoryAcara = async (req, res, next) => {
    try {
        const {pagination} = req.query
        const limit = 10
        const offset = (pagination - 1) * limit

        const data = await db("acara_user_registration")
            .select(
                "acara_id",
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
            .join("acara","acara.id", "acara_user_registration.acara_id")
            .orderBy("registered_at","desc")
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getAcaraDetail = async (req, res, next) => {
    try {
        const {id} = req.params

        const data = await db("acara")
            .first(
                "title",
                "image",
                "description",
                "event_date",
                "quota",
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

exports.registerAcara = async (req, res, next) => {
    try {
        const {acara_id} = req.body

        if (await checkExistTable(db("acara_user_registration").where({user_id: res.locals.jwtData.id, acara_id}))) {
            return res.status(400).json({message: 'user sudah mendaftar'})
        }

        const {quota} = await db("acara")
            .where({id: acara_id})
            .first("quota")

        const {total} = await db("acara_user_registration").where({id: acara_id}).count("user_id as total").first()

        if (total > quota) {
            return res.status(400).json({message: 'quota sudah penuh'})
        }

        await db("acara_user_registration")
            .insert({
                user_id: res.locals.jwtData.id,
                acara_id
            })

        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}