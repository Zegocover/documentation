# Web hooks 

### Customer sign up integration
We support a webhook integration flow to link Zego customers to their work provider. 
Once a user has successfully registered through our app, we will issue the following POST 
request to a url configurable by the work provider.

You should use the `email` and `phoneNumber` to try and match the user that has signed up to a
user in your system. If there is a match, you may respond in one of the following ways:

- with a 2xx response indicating you have successfully found a match. You should then record
  the `customerNumber`, and use the customerNumber when logging shifts.

- with a 2xx response and the body 
    ```
    {
      "workProviderUserId": <YOUR_ID_FOR_THE_USER>
    }
    ```
  We will store this reference against the user in our system. You should use this `workProviderUserId` when
  logging shifts against the user.


```
{
	"customerNumber": <CUSTOMER_NUMBER>,
	"email": <USER_EMAIL>,
	"phoneNumber": <USER_PHONE_NUMBER>,
}
```

<table>
    <thead>
        <tr>
            <th>Type</th>
            <th colspan="2">Params</th>
            <th>Values</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>HEAD</td>
            <td colspan="2">X-ZEGO-SIGNATURE</td>
            <td>String</td>
        </tr>
        <tr>
            <td>POST</td>
            <td colspan="2">body</td>
            <td>JSON (Array:[Object])</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>customerNumber</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>email</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>phoneNumber</td>
            <td>String (optional)</td>
        </tr>
    </tbody>
</table>


