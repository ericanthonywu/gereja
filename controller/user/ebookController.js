const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");

exports.getEbook = async (req, res, next) => {
    try {
        const {pagination} = req.query
        const limit = 10
        const offset = (pagination - 1) * limit

        const data = await db("ebook")
            .select(
                "id",
                "title",
                "author",
                "total_halaman",
            )
            .limit(limit)
            .offset(offset)

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.getEbookDetail = async (req, res, next) => {
    try {
        const {id} = req.params

        const data = await db("ebook")
            .first(
                "title",
                "author",
                "total_halaman",
                "description",
                "publisher",
                "isbn",
                "whatsapp_number",
                "master_ebook_bahasa.name as bahasa"
            )
            .join("master_ebook_bahasa", "master_ebook_bahasa.id", "ebook.bahasa")
            .where({"ebook.id": id})

        data.tags = await db("ebook_tags")
            .where({ebook_id: id})
            .join("master_ebook_tags", "master_ebook_tags.id", "ebook_tags.tags_id")
            .pluck("master_ebook_tags.name")

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}