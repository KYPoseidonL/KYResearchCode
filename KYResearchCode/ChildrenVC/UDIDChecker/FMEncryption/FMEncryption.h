#ifndef _ENCRYPT_IMPL_H_
#define _ENCRYPT_IMPL_H_

#define RMDsize				160			// 160 = 32*5
#define RMDsizeForCompress	224			// 224 = 32*7

#define DivFactor			1
#define ConvFactor			6
#define KCheckSumLength 	27
#define KMaxLength			512
// Collect four bytes into one word
#define RIPEMD160_GET_UNSIGNED_INT(desc8, pos)	(((unsigned int) (((desc8)[pos+3])&0xff)) << 24) |\
(((unsigned int) ((desc8)[pos+2])&0xff) << 16) |\
(((unsigned int) ((desc8)[pos+1])&0xff) << 8)  |\
((unsigned int) ((desc8)[pos])&0xff)

//#define RIPEMD160_GET_UNSIGNED_INT(desc8, pos)	(((unsigned int) (((desc8)[pos+3]))) << 24) |\
(((unsigned int) ((desc8)[pos+2])) << 16) |\
(((unsigned int) ((desc8)[pos+1])) << 8)  |\
((unsigned int) ((desc8)[pos]))

// ROL(x, n) cyclically rotates x over n bits to the left, x must be of an unsigned 32 bits type and 0 <= n < 32.
#define ROL(x, n)		(((x) << (n)) | ((x) >> (32-(n))))
#define ROR(x, n)		(((x) >> (n)) | ((x) << (32-(n))))

// The five basic functions F(), G() and H()
#define I(x, y, z, u, v)		((x) ^ (y) ^ (z) ^ (u) ^ (v))
#define J(x, y, z, u, v)		(((x) & (y)) | (~(z) & (u)) ^ (v))
#define K(x, y, z, u, v)		(((x) | ~(y)) ^ (z) | (~(u) ^ (v)))
#define L(x, y, z, u, v)		(((x) & (u)) | ((y) & ~(v)) | ((z) & ~(u)))
#define M(x, y, z, u, v)		((x) ^ ((y) | ~(z)) ^ (~(u) | (v)))
#define N(x, y, z, u, v)		(((x) | ~(v)) ^ (~(y) | (u)) ^ ((z) & ~(v)))
#define O(x, y, z, u, v)		(~(x) & (~(y) ^ ~(z) ^ ~(u)) | ~(v))

// The ten basic operations FF() through III()
#define II(a, b, c, d, e, f, g, x, s)			{(a) += I((b), (c), (d), (e), (f)) + (x); (a) = ROL((a), (s)) + (g); (d) = ROL((d), 10);}
#define JJ(a, b, c, d, e, f, g, x, s)			{(a) += J((b), (c), (d), (e), (f)) + (x) + 0x5a827999UL; (a) = ROL((a), (s)) + (g); (d) = ROL((d), 10);}
#define KK(a, b, c, d, e, f, g, x, s)			{(a) += K((b), (c), (d), (e), (f)) + (x) + 0x6ed9eba1UL; (a) = ROL((a), (s)) + (g); (d) = ROL((d), 10);}
#define LL(a, b, c, d, e, f, g, x, s)			{(a) += L((b), (c), (d), (e), (f)) + (x) + 0x8f1bbcdcUL; (a) = ROL((a), (s)) + (g); (d) = ROL((d), 10);}
#define MM(a, b, c, d, e, f, g, x, s)			{(a) += M((b), (c), (d), (e), (f)) + (x) + 0xa953fd4eUL; (a) = ROL((a), (s)) + (g); (d) = ROL((d), 10);}
#define NN(a, b, c, d, e, f, g, x, s)			{(a) += N((b), (c), (d), (e), (f)) + (x) + 0xb04d768fUL; (a) = ROL((a), (s)) + (g); (d) = ROL((d), 10);}
#define OO(a, b, c, d, e, f, g, x, s)			{(a) += O((b), (c), (d), (e), (f)) + (x) + 0xe67b5dc2UL; (a) = ROL((a), (s)) + (g); (d) = ROL((d), 10);}
#define III(a, b, c, d, e, f, g, x, s)        	{(a) += I((b), (c), (d), (e), (f)) + (x); (a) = ROR((a), (s)) + (g); (d) = ROR((d), 10);}
#define JJJ(a, b, c, d, e, f, g, x, s)        	{(a) += J((b), (c), (d), (e), (f)) + (x) + 0x7a6d76e9UL; (a) = ROR((a), (s)) + (g); (d) = ROR((d), 10);}
#define KKK(a, b, c, d, e, f, g, x, s)        	{(a) += K((b), (c), (d), (e), (f)) + (x) + 0x6d703ef3UL; (a) = ROR((a), (s)) + (g); (d) = ROR((d), 10);}
#define LLL(a, b, c, d, e, f, g, x, s)        	{(a) += L((b), (c), (d), (e), (f)) + (x) + 0x5c4dd124UL; (a) = ROR((a), (s)) + (g); (d) = ROR((d), 10);}
#define MMM(a, b, c, d, e, f, g, x, s)        	{(a) += M((b), (c), (d), (e), (f)) + (x) + 0x50a28be6UL; (a) = ROR((a), (s)) + (g); (d) = ROR((d), 10);}
#define NNN(a, b, c, d, e, f, g, x, s)        	{(a) += N((b), (c), (d), (e), (f)) + (x) + 0x34e1f9d2UL; (a) = ROR((a), (s)) + (g); (d) = ROR((d), 10);}
#define OOO(a, b, c, d, e, f, g, x, s)        	{(a) += O((b), (c), (d), (e), (f)) + (x) + 0x29ba47acUL; (a) = ROR((a), (s)) + (g); (d) = ROR((d), 10);}

class FMEncryption
{
public:
    FMEncryption(){};
public:
    void Encipher(const char* source,char* des, size_t sourceLen);
    SignedByte* EncodeTEA(Byte* v, int len);
private:
    void DoEncrypt(char* aHashKey, const char* aMessage, int length);
    void HashToDesc( char* aHashKey, char* aDesC );
    void MdFinish(unsigned int *aMdBuf, const char* aDesC8, int aPos, int aLswLen, int aMswLen);
    void Compress(unsigned int *aMdBuf, unsigned int *aX);
    int  CompareHash( const unsigned int aHashKey[], const unsigned int aCompareCode[] );
    void MdInit( unsigned int *aMdBuf );
private:
    void TEA(const int key[],int len);
    void encipher(unsigned int* v);
private:
    int *_key;
};
#endif /* _ENCRYPT_IMPL_H_ */
