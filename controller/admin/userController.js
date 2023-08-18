const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");

exports.getUser = async (req, res, next) => {
    try {
        const data = await db("user")
            .select("user.id",
                "nama",
                "email",
                "phone",
                "joined_at"
            )

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getUserDetailFamily = async (req, res, next) => {
    try {
        const {user_id} = req.params

        const data = await db("family")
            .select("family.id","user.id as user_id", "nama", "email", "phone","approve_status", "joined_at")
            .join("user", "user.id", "family.family_id")
            .where({user_id})

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.familyApproval = async (req, res, next) => {
    try {
        const {id, approve_status} = req.body

        await db("family")
            .where({id})
            .update({approve_status})

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}