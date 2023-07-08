const express = require('express');
const {login, register} = require("../controller/authController");
const {jwtMiddleware} = require("../middleware/authMiddleware");
const {getProfile, updateProfile, getFamily, addFamily, getUserList} = require("../controller/profileController");
const {getKegiatan, registerKegiatan, getKegiatanDetail} = require("../controller/kegiatanController");
const {getAcara, registerAcara, getAcaraDetail} = require("../controller/acaraController");
const {getEbook, getEbookDetail} = require("../controller/ebook");
const router = express.Router();

/* GET home page. */
router.post('/login', login)
router.post('/register', register)

router.get("/profile", jwtMiddleware, getProfile)
router.patch("/profile", jwtMiddleware, updateProfile)

router.get("/profile/family", jwtMiddleware, getFamily)
router.post("/profile/family", jwtMiddleware, addFamily)

router.get("/master/user",jwtMiddleware, getUserList)

router.get("/kegiatan", jwtMiddleware, getKegiatan)
router.get("/kegiatan/:id", jwtMiddleware, getKegiatanDetail)
router.post("/kegiatan", jwtMiddleware, registerKegiatan)

router.get("/acara", jwtMiddleware, getAcara)
router.get("/acara/:id", jwtMiddleware, getAcaraDetail)
router.post("/acara", jwtMiddleware, registerAcara)

router.get("/ebook", jwtMiddleware, getEbook)
router.get("/ebook/:id", jwtMiddleware, getEbookDetail)

module.exports = router;
