const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");
const moment = require("moment");

exports.getKegiatan = async (req, res, next) => {
    try {
        const data = await db("kegiatan")
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
                "day_repeat_of_week",
                "canceled_at",
            )

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getKegiatanUser = async (req, res, next) => {
    try {
        const {kegiatan_id} = req.params

        const data = await db("kegiatan_user_registration")
            .select(
                "user.id as user_id",
                "user.nama",
                "user.email",
                "user.phone",
            )
            .join("user", "user.id", "kegiatan_user_registration.user_id")
            .where({kegiatan_id})

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.createKegiatan = async (req, res, next) => {
    try {
        const {title, image, description_thumbnail, description, quota, time_before, time_after, event_date} = req.body

        await db("kegiatan").insert({
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

exports.editKegiatan = async (req, res, next) => {
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

        await db("kegiatan")
            .where({id})
            .update({title, image, description_thumbnail, description, quota, time_before, time_after, event_date})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.deleteKegiatan = async (req, res, next) => {
    try {
        const {id} = req.params

        await db("kegiatan")
            .where({id})
            .del()

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.cancelKegiatan = async (req, res, next) => {
    try {
        const {id} = req.params

        await db("kegiatan")
            .where({id})
            .update({canceled_at: moment().format("YYYY-MM-DD")})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}