const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR, AXIOS_ERROR} = require("../../middleware/errorHandler/errorType");
const {checkExistTable} = require("../../util");
const axios = require("axios");

exports.getBible = async (req, res, next) => {
    try {
        const {pagination} = req.query
        const limit = 10
        const offset = (pagination - 1) * limit

        const data = await db("bible")
            .select(
                "id",
                "title",
                "description",
                db("bible_detail")
                    .min("date")
                    .whereRaw("bible.id = bible_detail.bible_id")
                    .first()
                    .as("min_date"),
                db("bible_detail")
                    .max("date")
                    .whereRaw("bible.id = bible_detail.bible_id")
                    .first()
                    .as("max_date"),
                "created_at"
            )
            .orderBy("created_at","desc")
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getBibleDetail = async (req, res, next) => {
    try {
        const {bible_id} = req.params
        const {date} = req.query

        const data = await db("bible_detail")
            .where({bible_id})
            .select(
                "id",
                "date",
                "bab",
                "pasal",
                "abbr",
                db.raw("(select exists(select 1 from `bible_detail_read_status_user` where bible_detail_read_status_user.bible_detail_id = bible_detail.id and `user_id` = ?)) as read_status", [res.locals.jwtData.id])
            )
            .where({date})

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getBibleDetailRead = async (req, res, next) => {
    try {
        const {bible_detail_id} = req.params

        const data = await db("bible_detail_read")
            .where({bible_detail_id})
            .select("bible_detail_read.id", "pasal", "ayat", "isi", 'bible_detail.bab')
            .join("bible_detail", "bible_detail.id", "bible_detail_read.bible_detail_id")

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getBibleSelfReflection = async (req, res, next) => {
    try {
        const {bible_id} = req.params
        const {date} = req.query

        const data = await db("bible_self_reflection")
            .where({
                bible_id,
                date,
                user_id: res.locals.jwtData.id,
            })
            .first("reflection")

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.updateBibleSelfReflection = async (req, res, next) => {
    try {
        const {bible_id, reflection, date} = req.body

        if (await checkExistTable(db("bible_self_reflection").where({
            bible_id,
            date,
            user_id: res.locals.jwtData.id
        }))) {
            await db("bible_self_reflection")
                .update({
                    reflection
                })
                .where({bible_id, date, user_id: res.locals.jwtData.id})
        } else {
            await db("bible_self_reflection")
                .insert({bible_id, date, user_id: res.locals.jwtData.id, reflection})
        }
        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.updateBibleDetailStatus = async (req, res, next) => {
    try {
        const {bible_detail_id, status} = req.body

        if (status) {
            await db("bible_detail_read_status_user").insert({bible_detail_id, user_id: res.locals.jwtData.id})
        } else {
            await db("bible_detail_read_status_user").where({bible_detail_id, user_id: res.locals.jwtData.id}).del()
        }

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}


exports.getBibleList = async (req, res, next) => {
    try {
        const {data: {data}} = await axios.get("https://beeble.vercel.app/api/v1/passage/list")
        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(AXIOS_ERROR, e))
    }
}

exports.getBibleListDetail = async (req, res, next) => {
    try {
        const {abbr, chapter} = req.params
        const {data: {data}} = await axios.get(`https://beeble.vercel.app/api/v1/passage/${abbr}/${chapter}?ver=tb`)
        res.status(200).json({message: "OK", data: data.verses})
    } catch (e) {
        next(errorHandlerSyntax(AXIOS_ERROR, e))
    }
}