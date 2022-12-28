import base64

# from Cryptodome.Cipher import AES
# # from Cryptodome.Random import get_random_bytes


# input = "28Wh8EpRVZogCO1YO99qPFppDGpE5kc58LT7VaIOiEE".encode()
# key = "I am The CMS Key".encode()
# cipher = AES.new(key, AES.MODE_EAX)
# # ciphertext, tag = cipher.encrypt_and_digest(b"I am Pint tx")
# by= cipher.decrypt(input)

# # file_out = open("encrypted.bin", "wb")
# # [file_out.write(x) for x in (cipher.nonce, tag, ciphertext)]
# # file_out.close()


# print(by)


from Cryptodome.Cipher import AES
from Cryptodome.Random import get_random_bytes


# data = "PT55n1Hb/TBvLBH8jgJLkg=="

base64Key: str = "EaV7Y355ab5L5hYzygcZQQ=="
iv64 = "AAAAAAAAAAAAAAAAAAAAAA=="


def decryptUserIden(iden: str):
    def unpad(s): return s[:-ord(s[len(s) - 1:])]
    key: bytes = base64.b64decode(base64Key)
    enc: bytes = base64.b64decode(iden)
    iv: bytes = base64.b64decode(iv64)
    cipher = AES.new(key, AES.MODE_CBC, iv)
    iden_bytes = cipher.decrypt(enc)

    return unpad(iden_bytes).decode('utf-8')
