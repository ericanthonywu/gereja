const db = require("../config/database/connection")
const {errorHandlerSyntax} = require("../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../middleware/errorHandler/errorType");

exports.getEvents = async (req, res, next) => {
    try {
        const {pagination} = req.query
        const limit = 10
        const offset = (pagination - 1) * limit

        const data = await db("acara")
            .first(
                "id",
                "title",
                "image",
                "description_thumbnail",
                "event_date",
                "time_after",
                "time_before",
            )
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.registerEvent = async (req, res, next) => {
    try {
        const {user_id, event_id} = req.body
        await db("event_user_registration")
            .insert({
                user_id, event_id
            })
        res.status(201).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}