const express = require('express');
const {login, migrate} = require("../controller/admin/authController");
const {
    getAcaraUser,
    getAcara,
    editAcara,
    deleteAcara,
    createAcara,
    cancelAcara
} = require("../controller/admin/acaraController");
const {
    getKegiatan,
    getKegiatanUser,
    createKegiatan,
    cancelKegiatan,
    editKegiatan,
    deleteKegiatan
} = require("../controller/admin/kegiatanController");
const {getEbook, createEbook, updateEbook, deleteEbook} = require("../controller/admin/ebookController");
const {
    getMasterBahasaEbook,
    createMasterBahasaEbook,
    updateMasterBahasaEbook,
    deleteMasterBahasaEbook
} = require("../controller/admin/ebookBahasaController");
const {
    getMasterTagsEbook,
    createMasterTagsEbook,
    updateMasterTagsEbook,
    deleteMasterTagsEbook
} = require("../controller/admin/ebookTagsController");
const {jwtMiddleware} = require("../middleware/authMiddleware");
const {getUser, getUserDetailFamily, familyApproval} = require("../controller/admin/userController");
const {getBible, createBible, updateBible, deleteBible} = require("../controller/admin/bibleController");
const {getBibleDetail, createBibleDetail, updateBibleDetail, deleteBibleDetail} = require("../controller/admin/bibleDetailController");
const {getBibleDetailRead, createBibleDetailRead, updateBibleDetailRead, deleteBibleDetailRead} = require("../controller/admin/bibleDetailReadController");
const router = express.Router();

router.post("/login", login)
router.get("/migrate", migrate)

router.get("/user", jwtMiddleware, getUser)
router.get("/user/:user_id", jwtMiddleware, getUserDetailFamily)
router.put("/user/approval", jwtMiddleware, familyApproval)

router.get("/acara", jwtMiddleware, getAcara)
router.get("/acara/:acara_id", jwtMiddleware, getAcaraUser)
router.post("/acara", jwtMiddleware, createAcara)
router.put("/acara/:id", jwtMiddleware, cancelAcara)
router.put("/acara", jwtMiddleware, editAcara)
router.delete("/acara/:id", jwtMiddleware, deleteAcara)

router.get("/kegiatan", jwtMiddleware, getKegiatan)
router.get("/kegiatan/:kegiatan_id", jwtMiddleware, getKegiatanUser)
router.post("/kegiatan", jwtMiddleware, createKegiatan)
router.put("/kegiatan/:id", jwtMiddleware, cancelKegiatan)
router.put("/kegiatan", jwtMiddleware, editKegiatan)
router.delete("/kegiatan/:id", jwtMiddleware, deleteKegiatan)

router.get("/ebook", jwtMiddleware, getEbook)
router.post("/ebook", jwtMiddleware, createEbook)
router.put("/ebook", jwtMiddleware, updateEbook)
router.delete("/ebook/:id", jwtMiddleware, deleteEbook)

router.get("/master/ebook/bahasa", jwtMiddleware, getMasterBahasaEbook)
router.post("/master/ebook/bahasa", jwtMiddleware, createMasterBahasaEbook)
router.put("/master/ebook/bahasa", jwtMiddleware, updateMasterBahasaEbook)
router.delete("/master/ebook/bahasa/:id", jwtMiddleware, deleteMasterBahasaEbook)

router.get("/master/ebook/tags", jwtMiddleware, getMasterTagsEbook)
router.post("/master/ebook/tags", jwtMiddleware, createMasterTagsEbook)
router.put("/master/ebook/tags", jwtMiddleware, updateMasterTagsEbook)
router.delete("/master/ebook/tags/:id", jwtMiddleware, deleteMasterTagsEbook)

router.get("/bible", jwtMiddleware, getBible)
router.post("/bible", jwtMiddleware, createBible)
router.put("/bible", jwtMiddleware, updateBible)
router.delete("/bible/:id", jwtMiddleware, deleteBible)

router.get("/bible/detail/:bible_id", jwtMiddleware, getBibleDetail)
router.post("/bible/detail", jwtMiddleware, createBibleDetail)
router.put("/bible/detail", jwtMiddleware, updateBibleDetail)
router.delete("/bible/detail/:id", jwtMiddleware, deleteBibleDetail)

router.get("/bible/detail/read/:bible_detail_id", jwtMiddleware, getBibleDetailRead)
router.post("/bible/detail/read", jwtMiddleware, createBibleDetailRead)
router.put("/bible/detail/read", jwtMiddleware, updateBibleDetailRead)
router.delete("/bible/detail/read/:id", jwtMiddleware, deleteBibleDetailRead)

module.exports = router;