const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");

exports.getBibleDetail = async (req, res, next) => {
    try {
        const {bible_id} = req.params

        const data = await db("bible_detail")
            .where({bible_id})
            .select("id", "date", "bab")

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.createBibleDetail = async (req, res, next) => {
    try {
        const {bible_id, date, bab, pasal} = req.body
        await db("bible_detail").insert({bible_id, date, bab, pasal})

        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.updateBibleDetail = async (req, res, next) => {
    try {
        const {bible_id, date, bab,pasal, id} = req.body
        await db("bible_detail").update({bible_id, date, bab,pasal}).where({id})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.deleteBibleDetail = async (req, res, next) => {
    try {
        const {id} = req.params
        await db("bible_detail").where({id}).del()

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}