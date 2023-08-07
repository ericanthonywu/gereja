const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");

exports.getBible = async (req, res, next) => {
    try {
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

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.createBible = async (req, res, next) => {
    try {
        const {title, description} = req.body
        await db("bible").insert({title, description})

        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.updateBible = async (req, res, next) => {
    try {
        const {title, description, id} = req.body
        await db("bible").update({title, description}).where({id})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.deleteBible = async (req, res, next) => {
    try {
        const {id} = req.params
        await db("bible").where({id}).del()

        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}