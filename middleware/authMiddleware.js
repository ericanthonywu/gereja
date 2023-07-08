const jwt = require("jsonwebtoken")

/**
 * User jwt middleware
 *
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 */
exports.jwtMiddleware = (req, res, next) => {
    const {
        token
    } = req.headers

    jwt.verify(token, process.env.JWTSECRETTOKEN, (err, jwtData) => {
        if (err) {
            console.log('jwt error', err)

            return res.status(401).json({
                message: "Failed to verify token",
                error: err,
            })
        }

        res.locals.jwtData = jwtData

        next()
    })
}