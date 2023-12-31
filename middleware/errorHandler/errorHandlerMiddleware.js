const {
    MYSQL_ERROR,
    BCRYPT_ERROR,
    JWT_ERROR,
} = require("./errorType");
const fs = require('fs')
const path = require('path')

/**
 * 404 error handler
 *
 * @param {Error} err
 * @param {e.Request} req
 * @param {e.Response} res
 */
exports.render404Error = (err, req, res) => {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    res.render('error');
    // res.status(err.status || 500).json({
    //     message: err.message,
    //     error: req.app.get('env') === 'development' ? err : {}
    // })
}

/**
 * global default error handler
 *
 * @param {Error} err
 * @param {e.Request} req
 * @param {e.Response} res
 * @param {e.NextFunction} next
 */
exports.defaultErrorhandler = async (err, req, res, next) => {
    const {
        type,
        error
    } = err

    if (process.env.NODE_ENV === 'production') {
        return res.status(500).json({
            message: 'Internal server error',
        });
    }

    if (req.dest) {
        if (req.file) {
            try {
                fs.unlinkSync(path.join(__dirname, `../../uploads/${req.dest}/${req.file.filename}`))
            } catch (e) {
                console.log("failed remove file", e)
            }
        }

        if (req.files) {
            if (Array.isArray(req.dest)) {
                req.dest.forEach(({
                                      name,
                                      dest
                                  }) => {
                    req.files[name].forEach(({
                                                 filename
                                             }) => {
                        try {
                            fs.unlinkSync(path.join(__dirname, `../../uploads/${dest}/${filename}`))
                        } catch (e) {
                            console.log("failed remove file", e)
                        }
                    })
                })
            } else {
                try {
                    req.files[req.field].forEach(({filename}) => {
                        fs.unlinkSync(path.join(__dirname, `../../uploads/${req.dest}/${filename}`))
                    })
                } catch (e) {
                    console.log("failed remove file", e)
                }
            }
        }
    }

    console.log(err)

    switch (type) {
        case MYSQL_ERROR:
            switch (error.code) {
                case "ER_DUP_ENTRY":
                    console.log(error.sqlMessage)

                    res.status(403).json({
                        message: `some field is already exist`,
                        sqlMessage: process.env.NODE_ENV !== 'production' ? error.sqlMessage : undefined,
                    })
                    break;
                default:
                    res.status(500).json({
                        message: "Failed to execute query",
                        error,
                    })
            }
            break;
        case BCRYPT_ERROR:
            res.status(500).json({
                message: "Failed to encrypt/decrypt",
                error,
            })
            break;
        case JWT_ERROR:
            res.status(401).json({
                message: "Failed to sign/decode jwt",
                error,
            })
            break;
        default:
            if (process.env.NODE_ENV !== 'production') {
                console.log("error unknown", err)
            }

            res.status(500).json({
                message: "unknown error",
                error: err.message
            });
    }
}

/**
 * function for error handler syntax
 *
 * @param {string} type
 * @param {any} error
 * @return Object
 */
exports.errorHandlerSyntax = (type, error) => ({
    type,
    error
})
