require('dotenv').config()

import path from 'path'
import {transporter} from '../../configs/mailer'
import emailTemplates from 'email-templates'

const templatesDir = path.resolve(__dirname, './templates')
const EmailAddressRequiredError = new Error('email address required')

const sendOne = (templateName, locals, fn) => {
  // make sure that we have an user email
  if (!locals.email) {
    return fn(EmailAddressRequiredError)
  }
  // make sure that we have a message
  if (!locals.subject) {
    return fn(EmailAddressRequiredError)
  }
  emailTemplates(templatesDir, (err, template) => {
    if (err) {
      console.log(err)
      return fn(err)
    }
    // Send a single email
    template(templateName, locals, (err, html, text) => {
      if (err) {
        console.log(err)
        return fn(err)
      }
      // if we are testing don't send out an email instead return
      // success and the html and txt strings for inspection
      if (process.env.NODE_ENV === 'test' || process.env.NODE_ENV === 'development') {
        console.log(`Email Sent! :: ${html}`)
        fn(null, '250 2.0.0 OK 1350452502 s5sm19782310obo.10', html, text)
        return
      }

      transporter.sendMail({
        from: process.env.EMAIL_FROM,
        to: locals.email,
        subject: locals.subject,
        html,
        // generateTextFromHTML: true,
        text
      }, (err, responseStatus) => {
        if (err) {
          return fn(err)
        }
        return fn(null, responseStatus.message, html, text)
      })
    })
  })
}

export {sendOne}
