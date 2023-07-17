# JwtToken

The `JWT` struct provides a convenient way to work with JSON Web Tokens (JWTs) in Swift.

## Features

- Decode and access the different sections of a JWT token: header, body, and signature.
- Retrieve specific claims from the JWT token, such as issuer, subject, audience, expiration date, and more.
- Check if a JWT token has expired.

## Usage

### Initializing a JWT

```swift
// Initialize a JWT with a token
let jwt = JWT(token: "<your_jwt_token>")
```

### Accessing the Decoded Sections

```swift
// Access the decoded body section as a dictionary
if let body = jwt.body {
    // Work with the decoded body section
}

// Access the decoded header section as a dictionary
if let header = jwt.header {
    // Work with the decoded header section
}

// Access the signature section
if let signature = jwt.signature {
    // Work with the signature section
}
```

### Accessing Claims

```swift
// Access the expiration date/time from the body section
if let expiresAt = jwt.expiresAt {
    // Work with the expiration date/time
}

// Access the issuer claim from the body section
if let issuer = jwt.issuer {
    // Work with the issuer claim
}

// Access the subject claim from the body section
if let subject = jwt.subject {
    // Work with the subject claim
}

// Access the audience claim from the body section as an array of strings
if let audience = jwt.audience {
    // Work with the audience claim
}

// Access the issued-at date/time from the body section
if let issuedAt = jwt.issuedAt {
    // Work with the issued-at date/time
}

// Access the not-before date/time from the body section
if let notBefore = jwt.notBefore {
    // Work with the not-before date/time
}

// Access the identifier claim from the body section
if let identifier = jwt.identifier {
    // Work with the identifier claim
}

// Check if the JWT token has expired
if jwt.expired {
    // Handle the expired token
}

```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
