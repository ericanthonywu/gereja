const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");

exports.getMasterBahasaEbook = async (req, res, next) => {
    try {
        const data = await db("master_ebook_bahasa")

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.createMasterBahasaEbook = async (req, res, next) => {
    try {
        const {name} = req.body
        await db("master_ebook_bahasa").insert({name})

        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.updateMasterBahasaEbook = async (req, res, next) => {
    try {
        const {name, id} = req.body
        await db("master_ebook_bahasa").update({name}).where({id})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.deleteMasterBahasaEbook = async (req, res, next) => {
    try {
        const {id} = req.params
        await db("master_ebook_bahasa").where({id}).del()

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}