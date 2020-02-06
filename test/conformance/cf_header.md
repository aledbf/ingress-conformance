# Ingress Conformance Test Suite -  {{.Version}}

## **Summary**
This document provides a summary of the tests included in the Ingress conformance test suite.
Each test lists a set of formal requirements that a platform that meets conformance requirements must adhere to.

Each test is identified by the presence of the `[Conformance]` keyword in the ginkgo descriptive function calls.
The contents of this document are extracted from comments preceding those `[Conformance]` keywords
and those comments are expected to include a descriptive overview of what the test is validating using
RFC2119 keywords. This will provide a clear distinction between which bits of code in the tests are
there for the purposes of validating the platform rather than simply infrastructure logic used to setup, or
clean up the tests.

## **List of Tests**
