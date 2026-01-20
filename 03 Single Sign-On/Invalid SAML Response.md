# [Invalid SAML Response](03 Single Sign-On/Invalid SAML Response.md)

Canonical documentation for [Invalid SAML Response](03 Single Sign-On/Invalid SAML Response.md). This document defines concepts, terminology, and standard usage.

## Purpose
The concept of an "[Invalid SAML Response](03 Single Sign-On/Invalid SAML Response.md)" exists to define the failure state of a Security Assertion Markup Language (SAML) message during the authentication or authorization handshake between an Identity Provider (IdP) and a Service Provider (SP). This topic addresses the critical security requirement of ensuring that identity data is authentic, untampered, and intended for the specific recipient. Without a rigorous definition of what constitutes an invalid response, federated identity systems would be vulnerable to spoofing, replay attacks, and unauthorized data access.

> [!NOTE]
> This documentation is intended to be implementation-agnostic and authoritative.

## Scope
Clarify what is in scope and out of scope for this topic.

**In scope:**
* **Structural Integrity:** Validation of the XML schema and document structure.
* **Cryptographic Validity:** Verification of digital signatures and message digests.
* **Temporal Constraints:** Evaluation of timestamps and validity periods.
* **Trust Relationships:** Verification of issuers, audiences, and recipients against metadata.
* **Protocol Compliance:** Adherence to the [SAML 2.0](03 Single Sign-On/SAML 2.0.md) (and 1.1) core specifications.

**Out of scope:**
* **Vendor-Specific Error Codes:** Specific error strings or codes used by proprietary software (e.g., Microsoft Entra ID, Okta, Ping Identity).
* **Network Transport Issues:** Failures related to TLS/SSL or HTTP transport layers that occur before the SAML message is parsed.
* **User Authorization Logic:** Decisions made by the application *after* a SAML response is deemed valid (e.g., "User is valid but lacks 'Admin' role").

## Definitions
Provide precise definitions for key terms.

| Term | Definition |
|------|------------|
| **Assertion** | A package of information that supplies zero or more statements made by a SAML authority. |
| **Audience Restriction** | A condition within the assertion specifying that the information is intended for a specific Service Provider. |
| **Clock Skew** | The difference in system time between the IdP and the SP, which can lead to premature or expired validity checks. |
| **Digest Mismatch** | A failure where the calculated hash of the XML content does not match the value stored in the digital signature. |
| **InResponseTo** | An attribute used to correlate a SAML Response to a specific SAML Request. |
| **Issuer** | The unique identifier (usually a URI) of the Identity Provider that generated the response. |
| **Signature Validation** | The process of using a public key to verify that the SAML message was signed by a trusted private key and has not been altered. |
| **Trust Anchor** | The pre-shared metadata or certificate used by the SP to verify the identity of the IdP. |

## Core Concepts
The validity of a SAML Response rests on four fundamental pillars:

1.  **Authenticity:** The message must originate from a known and trusted Identity Provider. This is verified via the `Issuer` element and the digital signature.
2.  **Integrity:** The message must not have been modified in transit. This is ensured through XML Digital Signatures (XMLDSig).
3.  **Confidentiality:** If the assertion contains sensitive attributes, it may be encrypted. Failure to decrypt using the correct private key renders the response invalid.
4.  **Validity Context:** The response must be used within the correct time frame, by the intended recipient, and in response to a valid request.

## Standard Model
The standard model for validating a SAML Response follows a sequential pipeline. A failure at any stage classifies the response as "Invalid."

1.  **Serialization & Schema Check:** The SP ensures the XML is well-formed and conforms to the SAML XSD (XML Schema Definition).
2.  **Signature Verification:**
    *   The SP locates the `<ds:Signature>` element.
    *   The SP validates the certificate against its local trust store (metadata).
    *   The cryptographic signature is verified against the message content.
3.  **Condition Evaluation:**
    *   **Timestamps:** The current time must be between `NotBefore` and `NotOnOrAfter`.
    *   **Audience:** The `Audience` URI in the assertion must match the SP’s Entity ID.
4.  **Subject Confirmation:** The SP verifies that the `Recipient` attribute in the `<SubjectConfirmationData>` matches the SP’s Assertion Consumer Service (ACS) URL.
5.  **State Correlation:** If the flow was SP-initiated, the `InResponseTo` attribute must match the ID of the original AuthnRequest.

## Common Patterns
The following patterns represent the most frequent causes of an [Invalid SAML Response](03 Single Sign-On/Invalid SAML Response.md):

*   **Expired Assertions:** The response arrives after the `NotOnOrAfter` timestamp, often due to user delay or network latency.
*   **Certificate Mismatch:** The IdP has rotated its signing certificate, but the SP is still attempting to validate using an old certificate stored in its metadata.
*   **Recipient/Audience Mismatch:** The IdP is configured with an incorrect Entity ID or ACS URL for the SP, causing the SP to reject the assertion as "not intended for me."
*   **Unsigned Assertions:** The IdP signs the Response but not the Assertion (or vice versa), while the SP policy requires both to be signed.

## Anti-Patterns
Discouraged practices that lead to security vulnerabilities or brittle integrations:

*   **Signature Skipping:** Accepting a SAML Response without verifying the digital signature. This allows any actor to forge identity assertions.
*   **Infinite Clock Skew:** Setting an excessively large tolerance for timestamp validation (e.g., >10 minutes), which increases the window for replay attacks.
*   **Hardcoding Metadata:** Manually entering IdP certificates and endpoints instead of using a dynamic metadata refresh mechanism, leading to invalid responses during certificate rotations.
*   **Ignoring InResponseTo:** Failing to track the request ID, allowing for unsolicited assertions in flows where they are not permitted.

## Edge Cases
*   **Multiple Assertions:** A SAML Response may contain multiple assertions. If one is valid and another is invalid (e.g., expired), the entire response is typically treated as invalid.
*   **Nested Signatures:** Signatures can exist at the Response level, the Assertion level, or both. An invalid signature at the Response level invalidates the entire envelope, even if the Assertion signature is valid.
*   **Comment Injection:** XML comments placed strategically within the SAML XML can sometimes bypass poorly implemented canonicalization algorithms, leading to a valid signature but invalid data interpretation.
*   **Clock Drift at Millisecond Precision:** Systems synchronized to different NTP servers may experience sub-second drift that causes "NotBefore" failures if the IdP issues a token for the exact current second.

## Related Topics
*   **SAML Metadata:** The XML document used to exchange configuration and trust anchors.
*   **XML Canonicalization (C14N):** The process of preparing XML for signing to ensure minor formatting changes don't break signatures.
*   **Identity Provider (IdP) Discovery:** The process of determining which IdP to use for a specific user.
*   **Single Logout (SLO):** The protocol for terminating sessions across all participants in a federation.

## Change Log
| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-01-20 | Initial AI-generated canonical documentation |