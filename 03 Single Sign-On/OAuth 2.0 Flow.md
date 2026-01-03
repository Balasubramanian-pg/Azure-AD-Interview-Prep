# OAUTH 2.0 FLOW

# Introduction  
OAuth 2.0 is an open-standard protocol for authorization. It enables third-party services (clients) to access user resources (e.g., photos or emails) from a resource server (e.g., a social media platform) without exposing the user's credentials. Unlike authentication protocols, OAuth 2.0 focuses on authorization by issuing **access tokens** that grant limited access to specific resources for a defined time. OAuth 2.0 is specified in [RFC 6749](https://tools.ietf.org/html/rfc6749) and is widely used in web and mobile applications for secure integration.  

**Key Features**  
- Decouples authentication from authorization.  
- Supports delegated access via different **grant types** (authorization codes, implicit flows, etc.).  
- Scalable for different client types (web, mobile, server-to-server).  
- Secures communication through encryption (TLS) and token validity checks.  

---

# Core Concepts  

## Key Actors  
1. **Authorization Server**: Issues access/refresh tokens after validating the client and user.  
   - Example: Google's OAuth 2.0 Auth Server.  
2. **Resource Server**: Hosts the protected resources and verifies access tokens.  
   - Example: A user’s Gmail data stored on Google’s servers.  
3. **Client**: The third-party service requesting access to resources.  
   - Can be a web app, mobile app, or backend service.  
4. **Resource Owner**: The user who grants/denies access to their resources.  

## Grant Types  
OAuth 2.0 defines several **grant types** (authorization flows), each tailored to different client scenarios and security requirements.  

1. **Authorization Code Grant** (most secure, for web/mobile clients with backend authentication).  
2. **Implicit Grant** (simplified, deprecated for newer apps; used in legacy single-page applications).  
3. **Client Credentials Grant** (for non-user clients, e.g., server-to-server API calls).  
4. **Resource Owner Password Credentials Grant** (less common; used when client directly interacts with the user).  

**Client Types**  
- **Confidential Clients**: Can securely store sensitive credentials (e.g., web servers).  
- **Public Clients**: Cannot securely store credentials (e.g., mobile/nativ apps).  

---

# Core Flows  

## **Authorization Code Grant**  
**Steps**:  
1. **Redirect to Authorization Server**: The client redirects the user to `/authorize` with parameters like `client_id`, `redirect_uri`, `response_type=code`, and optional state.  
2. **User Authentication and Consent**: After logging in, the user grants/denies access to the client. If approved, the Authorization Server redirects back to the client’s `redirect_uri` with an authorization `code`.  
3. **Exchange Code for Tokens**: The client sends the `code` to the `/token` endpoint (along with `client_id`, `client_secret`, and `redirect_uri`) to receive the **access token** and (optionally) a **refresh token**.  

**Use Case**: A web app (e.g., an analytics dashboard) accessing a user’s Google Calendar data.  

---

## **Implicit Grant** (Deprecated)  
**Steps**:  
1. The client redirects the user to `/authorize` with `response_type=token`.  
2. After user consent, the Authorization Server redirects back to `redirect_uri` with the **access token** in the URL fragment (e.g., `#access_token=token...`).  

**Risk**: Tokens are exposed in URLs, making them vulnerable to interception in legacy browsers. Modern apps use **PKCE** (Proof Key for Code Exchange) with the **Authorization Code Grant** instead.  

---

## **Client Credentials Grant**  
**Steps**:  
1. The client directly sends a request to `/token` with `client_id`, `client_secret`, and `grant_type=client_credentials`.  
2. The server issues an **access token**, requiring no user interaction.  

**Use Case**: A backend service fetching inventory data from another internal API.  

---

## **Resource Owner Password Credentials Grant**  
**Steps**:  
1. The client requests `/token` with `grant_type=password`, along with the user’s `username` and `password`.  
2. The server authenticates the user and returns an **access token**.  

**Use Case**: Trusted clients (e.g., official mobile apps) where the client has direct user interaction. **Not recommended** for general use due to security risks.  

---

# Examples  

1. **Authorization Code Flow Example** (Web App Login):  
   - Visit: `https://auth-server.com/authorize?response_type=code&client_id=12345&redirect_uri=https://myapp.com/callback&state=xyz`  
   - User approves → redirected to `https://myapp.com/callback?code=abcdef&state=xyz`.  
   - The web app exchanges `code` for tokens via `POST` to `https://auth-server.com/token` with `client_secret`.  

2. **PKCE with Native Apps**:  
   - The client generates a `code_verifier` (e.g., "abc123xyz"), hashes it to create `code_challenge`, then sends to `/authorize`.  
   - After receiving the `code`, the client includes the `code_verifier` during token exchange, ensuring only the legitimate client can convert the code to a token.  

3. **Client Credentials Grant for System Integration**:  
   - A billing system (client) directly calls `/token` with credentials to retrieve API access token:  
   ```  
   POST /token HTTP/1.1  
   Content-Type: application/x-www-form-urlencoded  

   grant_type=client_credentials&client_id=system_api_123&client_secret=topsecret
   ```  

---

# Summary  

OAuth 2.0 is essential for secure, user-controlled sharing of resources across services. Key takeaways:  
- **Select the appropriate grant type** based on client capabilities (e.g., web vs. mobile vs. server).  
- **Prioritize security practices**: Use PKCE for public clients, encrypt communication (TLS), and limit token expiration.  
- **Understand OAuth 2.0’s scope**: Focuses on authorization, not user authentication. Modern implementations replace deprecated flows like **Implicit** with **Authorization Code** plus PKCE.  
- **Avoid pitfalls**: Never store tokens locally; use refresh tokens judiciously and avoid insecure grant types unless strictly necessary.  

OAuth 2.0 remains foundational for user privacy and secure integration in web services.

---
*Generated by Puter.js & Qwen*