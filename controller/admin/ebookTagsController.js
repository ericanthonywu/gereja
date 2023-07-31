const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");

exports.getMasterTagsEbook = async (req, res, next) => {
    try {
        const data = await db("master_ebook_tags")

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.createMasterTagsEbook = async (req, res, next) => {
    try {
        const {name} = req.body
        await db("master_ebook_tags").insert({name})

        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.updateMasterTagsEbook = async (req, res, next) => {
    try {
        const {name, id} = req.body
        await db("master_ebook_tags").update({name}).where({id})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.deleteMasterTagsEbook = async (req, res, next) => {
    try {
        const {id} = req.params
        await db("master_ebook_tags").where({id}).del()

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}