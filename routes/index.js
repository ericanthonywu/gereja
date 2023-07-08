const express = require('express');
const {login, register} = require("../controller/authController");
const {jwtMiddleware} = require("../middleware/authMiddleware");
const {getProfile, updateProfile, getFamily, addFamily} = require("../controller/profileController");
const router = express.Router();

/* GET home page. */
router.post('/login', login)
router.post('/register', register)

router.get("/profile", jwtMiddleware, getProfile)
router.patch("/profile", jwtMiddleware, updateProfile)
router.get("/profile/family", jwtMiddleware, getFamily)
router.post("/profile/family", jwtMiddleware, addFamily)

module.exports = router;
