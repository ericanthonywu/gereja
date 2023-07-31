const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");

exports.getBibleDetailRead = async (req, res, next) => {
    try {
        const {bible_detail_id} = req.params

        const data = await db("bible_detail_read")
            .where({bible_detail_id})
            .select("bible_detail_read.id", "pasal","ayat", "isi", 'bible_detail.bab')
            .join("bible_detail","bible_detail.id","bible_detail_read.bible_detail_id")

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.createBibleDetailRead = async (req, res, next) => {
    try {
        const {bible_detail_id, pasal,ayat, isi} = req.body
        await db("bible_detail_read").insert({bible_detail_id, pasal,ayat, isi})

        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.updateBibleDetailRead = async (req, res, next) => {
    try {
        const {bible_detail_id, pasal,ayat, isi, id} = req.body
        await db("bible_detail_read").update({bible_detail_id, pasal,ayat, isi}).where({id})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.deleteBibleDetailRead = async (req, res, next) => {
    try {
        const {id} = req.params
        await db("bible_detail_read").where({id}).del()

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}