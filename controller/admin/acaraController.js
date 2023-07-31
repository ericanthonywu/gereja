const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");
const moment = require("moment");

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
                "description",
                "description_thumbnail",
                "quota",
                "event_date",
                "time_after",
                "time_before",
                "canceled_at",
            )
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getAcaraUser = async (req, res, next) => {
    try {
        const {acara_id} = req.params

        const data = await db("acara_user_registration")
            .select(
                "user.id as user_id",
                "user.nama",
                "user.email",
                "user.phone",
            )
            .join("user", "user.id", "acara_user_registration.user_id")
            .where({acara_id})

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.createAcara = async (req, res, next) => {
    try {
        const {title, image, description_thumbnail, description, quota, time_before, time_after, event_date} = req.body

        await db("acara").insert({
            title,
            image,
            description_thumbnail,
            description,
            quota,
            time_before,
            time_after,
            event_date
        })

        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.editAcara = async (req, res, next) => {
    try {
        const {
            id,
            title,
            image,
            description_thumbnail,
            description,
            quota,
            time_before,
            time_after,
            event_date
        } = req.body

        await db("acara")
            .where({id})
            .update({title, image, description_thumbnail, description, quota, time_before, time_after, event_date})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.deleteAcara = async (req, res, next) => {
    try {
        const {id} = req.params

        await db("acara")
            .where({id})
            .del()

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.cancelAcara = async (req, res, next) => {
    try {
        const {id} = req.params

        await db("acara")
            .where({id})
            .update({canceled_at: moment().format("YYYY-MM-DD")})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}