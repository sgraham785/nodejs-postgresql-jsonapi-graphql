require('dotenv').config()
import nodemailer from 'nodemailer'

// create reusable transporter object using SMTP transport
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
})

// Reusable transporter connection header
export {transporter}
