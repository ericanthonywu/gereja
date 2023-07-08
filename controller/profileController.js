const db = require("../config/database/connection")
const {errorHandlerSyntax} = require("../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../middleware/errorHandler/errorType");

exports.getProfile = async (req, res, next) => {
    try {
        const data = await db("user")
            .where({id: res.locals.jwtData.id})
            .first("nama", "email", "phone")

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.updateProfile = async (req, res, next) => {
    try {
        const {nama, email, phone} = req.body

        await db("user")
            .where({id: res.locals.jwtData.id})
            .update({nama, email, phone})

        res.status(202).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getFamily = async (req, res, next) => {
    try {
        const data = await db("family")
            .where({user_id: res.locals.jwtData.id})
            .join("user", "use.id", "family.family_id")
            .select("id", "nama", "email", "phone")

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.addFamily = async (req, res, next) => {
    try {
        const {family_id} = req.body

        const data = await db("family")
            .insert({user_id: res.locals.jwtData.id, family_id})

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}
