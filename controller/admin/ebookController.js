const db = require("../../config/database/connection")
const {errorHandlerSyntax} = require("../../middleware/errorHandler/errorHandlerMiddleware");
const {MYSQL_ERROR} = require("../../middleware/errorHandler/errorType");

exports.getEbook = async (req, res, next) => {
    try {
        const data = await db("ebook")
            .select(
                "ebook.id",
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
            .orderBy("ebook.id")

        for (const datum of data) {
            datum.tags = await db("ebook_tags")
                .where({ebook_id: datum.id})
                .join("master_ebook_tags", "master_ebook_tags.id", "ebook_tags.tags_id")
                .select("master_ebook_tags.name", "master_ebook_tags.id")
        }

        res.status(200).json({message: "OK", data})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.createEbook = async (req, res, next) => {
    const trx = await db.transaction()
    try {
        const {
            title,
            author,
            total_halaman,
            description,
            publisher,
            isbn,
            whatsapp_number,
            bahasa,
            tags_id_list
        } = req.body

        const [ebook_id] = await trx("ebook")
            .insert({
                title,
                author,
                total_halaman,
                description,
                publisher,
                isbn,
                whatsapp_number,
                bahasa,
            }, 'id')

        for (const tags_id of tags_id_list) {
            await trx("ebook_tags")
                .insert({
                    tags_id,
                    ebook_id
                })
        }

        await trx.commit()
        res.status(201).json({message: "OK"})
    } catch (e) {
        await trx.rollback()
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.updateEbook = async (req, res, next) => {
    const trx = await db.transaction()
    try {
        const {
            id,
            title,
            author,
            total_halaman,
            description,
            publisher,
            isbn,
            whatsapp_number,
            ebook_bahasa_id,
            tags_id_list
        } = req.body

        await trx("ebook")
            .update({
                title,
                author,
                total_halaman,
                description,
                publisher,
                isbn,
                whatsapp_number,
                ebook_bahasa_id,
            }).where({id})

        await trx("ebook_tags").where({ebook_id: id}).del()

        for (const tags_id of tags_id_list) {
            await trx("ebook_tags")
                .insert({
                    tags_id,
                    ebook_id: id
                })
        }

        await trx.commit()
        res.status(200).json({message: "OK"})
    } catch (e) {
        await trx.rollback()
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}

exports.deleteEbook = async (req, res, next) => {
    try {
        const {id} = req.params

        await db("ebook").where({id}).del()

        res.status(200).json({message: "OK"})
    } catch (e) {
        next(errorHandlerSyntax(MYSQL_ERROR, e))
    }
}