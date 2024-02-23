# Documenting the CA Cert I created.
 To generate a CA certificate (CA_Cert) in Ubuntu, you can use the OpenSSL toolkit, which is a widely-used tool for generating and 
 managing certificates and private keys. 
 
 Here's how you can generate a CA certificate:

# 1. Install OpenSSL:

  - If you haven't already installed OpenSSL, you can do so by running the following command in your terminal:

  $ sudo apt-get update
  $ sudo apt-get install openssl

# 2. Generate a Private Key for the Certificate Authority (CA):

  - Use the following command to generate a private key for the CA:
  $ openssl genrsa -out ca.key 2048
  - This command generates a 2048-bit RSA private key and saves it to a file named ca.key.

# 3. Create a Certificate Signing Request (CSR) for the CA:

  - Next, you'll create a CSR for the CA using the private key:

   $ openssl req -new -key ca.key -out ca.csr
  - You'll be prompted to enter information about your organization and the CA. 
   You can press Enter to accept the default values for most fields.

 $ openssl req -new -key ca.key -out ca.csr
 You are about to be asked to enter information that will be incorporated
 into your certificate request.
 What you are about to enter is what is called a Distinguished Name or a DN.
 There are quite a few fields but you can leave some blank
 For some fields there will be a default value,
 If you enter '.', the field will be left blank.
 -----
 Country Name (2 letter code) [AU]:
 State or Province Name (full name) [Some-State]:Queensland
 Locality Name (eg, city) []:Brisbane
 Organization Name (eg, company) [Internet Widgits Pty Ltd]:Mawingu
 Organizational Unit Name (eg, section) []:Creatives
 Common Name (e.g. server FQDN or YOUR name) []:allan
 Email Address []:allanmaseghe4@gmail.com

 Please enter the following 'extra' attributes
 to be sent with your certificate request
 A challenge password []:Ccie@2013
 An optional company name []:



# 4. Generate the CA Certificate:

- Finally, you'll generate the CA certificate using the private key and CSR:
$ openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt
- This command creates a self-signed CA certificate (ca.crt) valid for 365 days using the CSR (ca.csr) and the private key (ca.key).

 That's it! You've now generated a CA certificate (ca.crt) along with its private key (ca.key). 
 You can use this CA certificate to sign other certificates for various purposes such as SSL/TLS, client authentication, etc. 
 Make sure to keep the private key (ca.key) secure, as it's used to sign certificates and should not be shared.
