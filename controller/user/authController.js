const bcrypt = require('bcrypt')
const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR, JWT_ERROR} = require("../../middleware/errorHandler/errorType");
const jwt = require("jsonwebtoken");

exports.login = async (req, res, next) => {
    try {
        const {emailOrPhone, password} = req.body;

        const userData = await db("user")
            .where({email: emailOrPhone})
            .orWhere({phone: emailOrPhone})
            .first("id", "password")

        if (!userData) {
            return res.status(404).json({message: "user not found"});
        }

        const {id, password: dbPassword} = userData

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

exports.register = async (req, res, next) => {
    try {
        const {nama, email, phone, password} = req.body;

        await db("user").insert({
            nama,
            email,
            phone,
            password: await bcrypt.hash(password, await bcrypt.genSalt())
        })

        res.status(201).json({message: "user registered"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}