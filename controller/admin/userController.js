const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");

exports.getUser = async (req, res, next) => {
    try {
        const {pagination} = req.query
        const limit = 10
        const offset = (pagination - 1) * limit

        const data = await db("user")
            .select("user.id", "nama", "email", "phone", "joined_at")
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getUserDetailFamily = async (req, res, next) => {
    try {
        const {user_id} = req.params

        const data = await db("family")
            .select("user.id", "nama", "email", "phone", "joined_at")
            .join("user", "user.id", "family.family_id")
            .where({user_id})

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}