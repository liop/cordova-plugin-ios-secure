## iOS  Secure Plugin for Apache Cordova 



## Example

Here's an example of how I suggest you use the plugin in your code :

### signedParamsByMd5
```js
var parmas = {"x":"","y":""};
var signedStr = Secure.signedParamsByMd5(parmas);
// signedStr is a string if sign success
```

### addMd5SignToParma
```js
var parmas = {"x":"","y":""};
var signedparams = Secure.signedParamsByMd5(parmas);
// signedparams is dictionary by params add {"sign_type":"md5","sign":signadStr}
```

## Platform Support

Currently iOS only (version 5 and higher).

## License

[MIT License](http://ilee.mit-license.org)
