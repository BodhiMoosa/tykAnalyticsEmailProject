# Tyk Analytics Email Project

This simple server-side application (written in Swift using the server-side framework, Vapor) can be used to set up daily emails containing all API keys with their corresponding response codes.

## To Use:

* Requires a SendGrid account.
* Must be deployed in a constantly active environment (I personally use Heroku's Hobby Level).

Add SendGrid's key to your environment's Environment Variables (SENDGRID_API_KEY for the name).
Change Global Variables to customize settings and deploy.

the *errors/{numberOfDays}* endpoint returns detailed error logs (single page) for the previous x number of days based on the path component variable.
* include an Authorization header with your Tyk Authorization Key or you're going to get a 403 response.

## Sample Email Content:

API Key: 00000000<br />
    Response Code: 401<br />
    Count: 3<br />
    Datestamps:<br />
        2021-07-24T15:11:50.299Z<br />
        2021-07-24T02:52:44.147Z<br />
    Response Code: 404<br />
    Count: 13<br />
    Datestamps:<br />
        2021-07-24T03:23:29.827Z<br />
        2021-07-24T03:21:00.323Z<br />
        2021-07-24T03:11:05.169Z<br />
        2021-07-24T02:57:56.661Z<br />
        2021-07-24T02:56:18.551Z<br />
        2021-07-24T02:56:08.506Z<br />
        2021-07-24T02:54:50.382Z<br />
        2021-07-24T02:52:59.498Z<br />
        2021-07-24T02:48:09.202Z<br />
        2021-07-24T02:47:52.687Z<br />
        2021-07-24T02:47:15.171Z<br />
        2021-07-24T02:47:12.57Z<br />
        2021-07-24T02:46:25.239Z<br />
    Response Code: 400<br />
    Count: 2<br />
    Datestamps:<br />
        2021-07-24T03:06:31.84Z<br />
        2021-07-24T03:06:04.512Z<br />
    Response Code: 403<br />
    Count: 2<br />
    Datestamps:<br />
        2021-07-24T02:31:26.188Z<br /><br />
API Key: 5af8e16c758abc40a34f5bf382f482cb<br />
    Response Code: 404<br />
    Count: 2<br />
    Datestamps:<br />
        2021-07-24T02:36:59.62Z<br />
        2021-07-24T02:32:17.648Z<br />

## Author

* **Tayler Moosa** (https://taylermoosa.com/)


