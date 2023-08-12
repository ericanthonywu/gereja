const express = require('express');
const {login, register} = require("../controller/user/authController");
const {jwtMiddleware} = require("../middleware/authMiddleware");
const {getProfile, updateProfile, getFamily, addFamily, getUserList, deleteFamily} = require("../controller/user/profileController");
const {getKegiatan, registerKegiatan, getKegiatanDetail, getHistoryKegiatan} = require("../controller/user/kegiatanController");
const {getAcara, registerAcara, getAcaraDetail, getHistoryAcara} = require("../controller/user/acaraController");
const {getEbook, getEbookDetail} = require("../controller/user/ebookController");
const {getBible, getBibleDetail, getBibleDetailRead, updateBibleDetailStatus,
    getBibleSelfReflection, updateBibleSelfReflection, getBibleList, getBibleListDetail
} = require("../controller/user/bibleController");
const router = express.Router();

router.post('/login', login)
router.post('/register', register)

router.get("/profile", jwtMiddleware, getProfile)
router.patch("/profile", jwtMiddleware, updateProfile)

router.get("/profile/family", jwtMiddleware, getFamily)
router.post("/profile/family", jwtMiddleware, addFamily)
router.delete("/profile/family/:family_id", jwtMiddleware, deleteFamily)

router.get("/master/user",jwtMiddleware, getUserList)

router.get("/kegiatan", jwtMiddleware, getKegiatan)
router.get("/kegiatan/history", jwtMiddleware, getHistoryKegiatan)
router.get("/kegiatan/:id", jwtMiddleware, getKegiatanDetail)
router.post("/kegiatan", jwtMiddleware, registerKegiatan)

router.get("/acara", jwtMiddleware, getAcara)
router.get("/acara/history", jwtMiddleware, getHistoryAcara)
router.get("/acara/:id", jwtMiddleware, getAcaraDetail)
router.post("/acara", jwtMiddleware, registerAcara)

router.get("/ebook", jwtMiddleware, getEbook)
router.get("/ebook/:id", jwtMiddleware, getEbookDetail)

router.get("/bible", jwtMiddleware, getBible)
router.get("/bible/detail/:bible_id", jwtMiddleware, getBibleDetail)
router.put("/bible/detail", jwtMiddleware, updateBibleDetailStatus)
router.get("/bible/detail/read/:bible_detail_id", jwtMiddleware, getBibleDetailRead)

router.get("/bible/detail/self_reflection/:bible_id", jwtMiddleware, getBibleSelfReflection)
router.patch("/bible/detail/self_reflection", jwtMiddleware, updateBibleSelfReflection)

router.get("/bible/passage", getBibleList)
router.get("/bible/passage/:abbr/:chapter", getBibleListDetail)

module.exports = router;
