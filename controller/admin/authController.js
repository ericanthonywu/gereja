const bcrypt = require('bcrypt')
const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR, JWT_ERROR} = require("../../middleware/errorHandler/errorType");
const jwt = require("jsonwebtoken");

exports.login = async (req, res, next) => {
    try {
        const {username, password} = req.body;

        const adminData = await db("admin")
            .where({username})
            .first("id", "password")

        if (!adminData) {
            return res.status(404).json({message: "admin not found"});
        }

        const {id, password: dbPassword} = adminData

        if (!await bcrypt.compare(password, dbPassword)) {
            return res.status(401).json({message: "password do not match"});
        }

        await jwt.sign({
            id
        }, process.env.JWTSECRETTOKEN, (err, token) => {
            if (err) {
                return next(errorHandlerSyntax(JWT_ERROR, err))
            }

            return res.status(200).json({
                message: "login successful",
                data: {
                    token
                }
            })
        })

    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.migrate = async (req, res, next) => {
    try {
        await db("admin").insert({
            username: "admin",
            password: await bcrypt.hash("admin", await bcrypt.genSalt()),
        })

        res.status(201).json({message: "admin migrated"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}