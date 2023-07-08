const express = require('express');
const {login, register} = require("../controller/authController");
const {jwtMiddleware} = require("../middleware/authMiddleware");
const {getProfile, updateProfile, getFamily, addFamily, getUserList} = require("../controller/profileController");
const {getKegiatan, registerKegiatan} = require("../controller/kegiatanController");
const {getAcara, registerAcara} = require("../controller/acaraController");
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
router.post("/kegiatan", jwtMiddleware, registerKegiatan)

router.get("/acara", jwtMiddleware, getAcara)
router.post("/acara", jwtMiddleware, registerAcara)

module.exports = router;
