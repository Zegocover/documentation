# Web hooks 

### Customer sign up integration
We support a webhook integration flow to link Zego customers to their work provider. 
Once a user has successfully registered through our app, we will issue the following POST 
request to a url configurable by the work provider:

<aside class="notice">
You should respond to the webhook by making a call to the <code>/v1/user/match</code> 
endpoint, with the <code>success</code> variable set to <code>true</code> if the customer number 
could be matched to a user in your system, and <code>success</code> set to <code>false</code> 
if no match could be made.
</aside>


```
{
	"customer_number": <CUSTOMER_NUMBER>,
	"email": <USER_EMAIL>,
	"phone_number": <USER_PHONE_NUMBER>,
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
            <td>customer_number</td>
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
            <td>phone_number</td>
            <td>String (optional)</td>
        </tr>
    </tbody>
</table>


