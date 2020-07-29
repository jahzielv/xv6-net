
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;

  m = 0;
       6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
       d:	e9 b6 00 00 00       	jmp    c8 <grep+0xc8>
    m += n;
      12:	8b 45 ec             	mov    -0x14(%ebp),%eax
      15:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
      18:	8b 45 f4             	mov    -0xc(%ebp),%eax
      1b:	05 e0 1a 00 00       	add    $0x1ae0,%eax
      20:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
      23:	c7 45 f0 e0 1a 00 00 	movl   $0x1ae0,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
      2a:	eb 4a                	jmp    76 <grep+0x76>
      *q = 0;
      2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
      2f:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
      32:	83 ec 08             	sub    $0x8,%esp
      35:	ff 75 f0             	pushl  -0x10(%ebp)
      38:	ff 75 08             	pushl  0x8(%ebp)
      3b:	e8 9a 01 00 00       	call   1da <match>
      40:	83 c4 10             	add    $0x10,%esp
      43:	85 c0                	test   %eax,%eax
      45:	74 26                	je     6d <grep+0x6d>
        *q = '\n';
      47:	8b 45 e8             	mov    -0x18(%ebp),%eax
      4a:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
      4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
      50:	83 c0 01             	add    $0x1,%eax
      53:	89 c2                	mov    %eax,%edx
      55:	8b 45 f0             	mov    -0x10(%ebp),%eax
      58:	29 c2                	sub    %eax,%edx
      5a:	89 d0                	mov    %edx,%eax
      5c:	83 ec 04             	sub    $0x4,%esp
      5f:	50                   	push   %eax
      60:	ff 75 f0             	pushl  -0x10(%ebp)
      63:	6a 01                	push   $0x1
      65:	e8 73 05 00 00       	call   5dd <write>
      6a:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
      6d:	8b 45 e8             	mov    -0x18(%ebp),%eax
      70:	83 c0 01             	add    $0x1,%eax
      73:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
      76:	83 ec 08             	sub    $0x8,%esp
      79:	6a 0a                	push   $0xa
      7b:	ff 75 f0             	pushl  -0x10(%ebp)
      7e:	e8 b9 03 00 00       	call   43c <strchr>
      83:	83 c4 10             	add    $0x10,%esp
      86:	89 45 e8             	mov    %eax,-0x18(%ebp)
      89:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
      8d:	75 9d                	jne    2c <grep+0x2c>
    }
    if(p == buf)
      8f:	81 7d f0 e0 1a 00 00 	cmpl   $0x1ae0,-0x10(%ebp)
      96:	75 07                	jne    9f <grep+0x9f>
      m = 0;
      98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      9f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a3:	7e 23                	jle    c8 <grep+0xc8>
      m -= p - buf;
      a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a8:	ba e0 1a 00 00       	mov    $0x1ae0,%edx
      ad:	29 d0                	sub    %edx,%eax
      af:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
      b2:	83 ec 04             	sub    $0x4,%esp
      b5:	ff 75 f4             	pushl  -0xc(%ebp)
      b8:	ff 75 f0             	pushl  -0x10(%ebp)
      bb:	68 e0 1a 00 00       	push   $0x1ae0
      c0:	e8 b3 04 00 00       	call   578 <memmove>
      c5:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
      cb:	ba ff 03 00 00       	mov    $0x3ff,%edx
      d0:	29 c2                	sub    %eax,%edx
      d2:	89 d0                	mov    %edx,%eax
      d4:	89 c2                	mov    %eax,%edx
      d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
      d9:	05 e0 1a 00 00       	add    $0x1ae0,%eax
      de:	83 ec 04             	sub    $0x4,%esp
      e1:	52                   	push   %edx
      e2:	50                   	push   %eax
      e3:	ff 75 0c             	pushl  0xc(%ebp)
      e6:	e8 ea 04 00 00       	call   5d5 <read>
      eb:	83 c4 10             	add    $0x10,%esp
      ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
      f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      f5:	0f 8f 17 ff ff ff    	jg     12 <grep+0x12>
    }
  }
}
      fb:	90                   	nop
      fc:	c9                   	leave  
      fd:	c3                   	ret    

000000fe <main>:

int
main(int argc, char *argv[])
{
      fe:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     102:	83 e4 f0             	and    $0xfffffff0,%esp
     105:	ff 71 fc             	pushl  -0x4(%ecx)
     108:	55                   	push   %ebp
     109:	89 e5                	mov    %esp,%ebp
     10b:	53                   	push   %ebx
     10c:	51                   	push   %ecx
     10d:	83 ec 10             	sub    $0x10,%esp
     110:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
     112:	83 3b 01             	cmpl   $0x1,(%ebx)
     115:	7f 17                	jg     12e <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
     117:	83 ec 08             	sub    $0x8,%esp
     11a:	68 40 13 00 00       	push   $0x1340
     11f:	6a 02                	push   $0x2
     121:	e8 2a 06 00 00       	call   750 <printf>
     126:	83 c4 10             	add    $0x10,%esp
    exit();
     129:	e8 8f 04 00 00       	call   5bd <exit>
  }
  pattern = argv[1];
     12e:	8b 43 04             	mov    0x4(%ebx),%eax
     131:	8b 40 04             	mov    0x4(%eax),%eax
     134:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(argc <= 2){
     137:	83 3b 02             	cmpl   $0x2,(%ebx)
     13a:	7f 15                	jg     151 <main+0x53>
    grep(pattern, 0);
     13c:	83 ec 08             	sub    $0x8,%esp
     13f:	6a 00                	push   $0x0
     141:	ff 75 f0             	pushl  -0x10(%ebp)
     144:	e8 b7 fe ff ff       	call   0 <grep>
     149:	83 c4 10             	add    $0x10,%esp
    exit();
     14c:	e8 6c 04 00 00       	call   5bd <exit>
  }

  for(i = 2; i < argc; i++){
     151:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
     158:	eb 74                	jmp    1ce <main+0xd0>
    if((fd = open(argv[i], 0)) < 0){
     15a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     15d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     164:	8b 43 04             	mov    0x4(%ebx),%eax
     167:	01 d0                	add    %edx,%eax
     169:	8b 00                	mov    (%eax),%eax
     16b:	83 ec 08             	sub    $0x8,%esp
     16e:	6a 00                	push   $0x0
     170:	50                   	push   %eax
     171:	e8 87 04 00 00       	call   5fd <open>
     176:	83 c4 10             	add    $0x10,%esp
     179:	89 45 ec             	mov    %eax,-0x14(%ebp)
     17c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     180:	79 29                	jns    1ab <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
     182:	8b 45 f4             	mov    -0xc(%ebp),%eax
     185:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     18c:	8b 43 04             	mov    0x4(%ebx),%eax
     18f:	01 d0                	add    %edx,%eax
     191:	8b 00                	mov    (%eax),%eax
     193:	83 ec 04             	sub    $0x4,%esp
     196:	50                   	push   %eax
     197:	68 60 13 00 00       	push   $0x1360
     19c:	6a 01                	push   $0x1
     19e:	e8 ad 05 00 00       	call   750 <printf>
     1a3:	83 c4 10             	add    $0x10,%esp
      exit();
     1a6:	e8 12 04 00 00       	call   5bd <exit>
    }
    grep(pattern, fd);
     1ab:	83 ec 08             	sub    $0x8,%esp
     1ae:	ff 75 ec             	pushl  -0x14(%ebp)
     1b1:	ff 75 f0             	pushl  -0x10(%ebp)
     1b4:	e8 47 fe ff ff       	call   0 <grep>
     1b9:	83 c4 10             	add    $0x10,%esp
    close(fd);
     1bc:	83 ec 0c             	sub    $0xc,%esp
     1bf:	ff 75 ec             	pushl  -0x14(%ebp)
     1c2:	e8 1e 04 00 00       	call   5e5 <close>
     1c7:	83 c4 10             	add    $0x10,%esp
  for(i = 2; i < argc; i++){
     1ca:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1d1:	3b 03                	cmp    (%ebx),%eax
     1d3:	7c 85                	jl     15a <main+0x5c>
  }
  exit();
     1d5:	e8 e3 03 00 00       	call   5bd <exit>

000001da <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     1da:	55                   	push   %ebp
     1db:	89 e5                	mov    %esp,%ebp
     1dd:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
     1e0:	8b 45 08             	mov    0x8(%ebp),%eax
     1e3:	0f b6 00             	movzbl (%eax),%eax
     1e6:	3c 5e                	cmp    $0x5e,%al
     1e8:	75 17                	jne    201 <match+0x27>
    return matchhere(re+1, text);
     1ea:	8b 45 08             	mov    0x8(%ebp),%eax
     1ed:	83 c0 01             	add    $0x1,%eax
     1f0:	83 ec 08             	sub    $0x8,%esp
     1f3:	ff 75 0c             	pushl  0xc(%ebp)
     1f6:	50                   	push   %eax
     1f7:	e8 38 00 00 00       	call   234 <matchhere>
     1fc:	83 c4 10             	add    $0x10,%esp
     1ff:	eb 31                	jmp    232 <match+0x58>
  do{  // must look at empty string
    if(matchhere(re, text))
     201:	83 ec 08             	sub    $0x8,%esp
     204:	ff 75 0c             	pushl  0xc(%ebp)
     207:	ff 75 08             	pushl  0x8(%ebp)
     20a:	e8 25 00 00 00       	call   234 <matchhere>
     20f:	83 c4 10             	add    $0x10,%esp
     212:	85 c0                	test   %eax,%eax
     214:	74 07                	je     21d <match+0x43>
      return 1;
     216:	b8 01 00 00 00       	mov    $0x1,%eax
     21b:	eb 15                	jmp    232 <match+0x58>
  }while(*text++ != '\0');
     21d:	8b 45 0c             	mov    0xc(%ebp),%eax
     220:	8d 50 01             	lea    0x1(%eax),%edx
     223:	89 55 0c             	mov    %edx,0xc(%ebp)
     226:	0f b6 00             	movzbl (%eax),%eax
     229:	84 c0                	test   %al,%al
     22b:	75 d4                	jne    201 <match+0x27>
  return 0;
     22d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     232:	c9                   	leave  
     233:	c3                   	ret    

00000234 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     234:	55                   	push   %ebp
     235:	89 e5                	mov    %esp,%ebp
     237:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
     23a:	8b 45 08             	mov    0x8(%ebp),%eax
     23d:	0f b6 00             	movzbl (%eax),%eax
     240:	84 c0                	test   %al,%al
     242:	75 0a                	jne    24e <matchhere+0x1a>
    return 1;
     244:	b8 01 00 00 00       	mov    $0x1,%eax
     249:	e9 99 00 00 00       	jmp    2e7 <matchhere+0xb3>
  if(re[1] == '*')
     24e:	8b 45 08             	mov    0x8(%ebp),%eax
     251:	83 c0 01             	add    $0x1,%eax
     254:	0f b6 00             	movzbl (%eax),%eax
     257:	3c 2a                	cmp    $0x2a,%al
     259:	75 21                	jne    27c <matchhere+0x48>
    return matchstar(re[0], re+2, text);
     25b:	8b 45 08             	mov    0x8(%ebp),%eax
     25e:	8d 50 02             	lea    0x2(%eax),%edx
     261:	8b 45 08             	mov    0x8(%ebp),%eax
     264:	0f b6 00             	movzbl (%eax),%eax
     267:	0f be c0             	movsbl %al,%eax
     26a:	83 ec 04             	sub    $0x4,%esp
     26d:	ff 75 0c             	pushl  0xc(%ebp)
     270:	52                   	push   %edx
     271:	50                   	push   %eax
     272:	e8 72 00 00 00       	call   2e9 <matchstar>
     277:	83 c4 10             	add    $0x10,%esp
     27a:	eb 6b                	jmp    2e7 <matchhere+0xb3>
  if(re[0] == '$' && re[1] == '\0')
     27c:	8b 45 08             	mov    0x8(%ebp),%eax
     27f:	0f b6 00             	movzbl (%eax),%eax
     282:	3c 24                	cmp    $0x24,%al
     284:	75 1d                	jne    2a3 <matchhere+0x6f>
     286:	8b 45 08             	mov    0x8(%ebp),%eax
     289:	83 c0 01             	add    $0x1,%eax
     28c:	0f b6 00             	movzbl (%eax),%eax
     28f:	84 c0                	test   %al,%al
     291:	75 10                	jne    2a3 <matchhere+0x6f>
    return *text == '\0';
     293:	8b 45 0c             	mov    0xc(%ebp),%eax
     296:	0f b6 00             	movzbl (%eax),%eax
     299:	84 c0                	test   %al,%al
     29b:	0f 94 c0             	sete   %al
     29e:	0f b6 c0             	movzbl %al,%eax
     2a1:	eb 44                	jmp    2e7 <matchhere+0xb3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     2a3:	8b 45 0c             	mov    0xc(%ebp),%eax
     2a6:	0f b6 00             	movzbl (%eax),%eax
     2a9:	84 c0                	test   %al,%al
     2ab:	74 35                	je     2e2 <matchhere+0xae>
     2ad:	8b 45 08             	mov    0x8(%ebp),%eax
     2b0:	0f b6 00             	movzbl (%eax),%eax
     2b3:	3c 2e                	cmp    $0x2e,%al
     2b5:	74 10                	je     2c7 <matchhere+0x93>
     2b7:	8b 45 08             	mov    0x8(%ebp),%eax
     2ba:	0f b6 10             	movzbl (%eax),%edx
     2bd:	8b 45 0c             	mov    0xc(%ebp),%eax
     2c0:	0f b6 00             	movzbl (%eax),%eax
     2c3:	38 c2                	cmp    %al,%dl
     2c5:	75 1b                	jne    2e2 <matchhere+0xae>
    return matchhere(re+1, text+1);
     2c7:	8b 45 0c             	mov    0xc(%ebp),%eax
     2ca:	8d 50 01             	lea    0x1(%eax),%edx
     2cd:	8b 45 08             	mov    0x8(%ebp),%eax
     2d0:	83 c0 01             	add    $0x1,%eax
     2d3:	83 ec 08             	sub    $0x8,%esp
     2d6:	52                   	push   %edx
     2d7:	50                   	push   %eax
     2d8:	e8 57 ff ff ff       	call   234 <matchhere>
     2dd:	83 c4 10             	add    $0x10,%esp
     2e0:	eb 05                	jmp    2e7 <matchhere+0xb3>
  return 0;
     2e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2e7:	c9                   	leave  
     2e8:	c3                   	ret    

000002e9 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     2e9:	55                   	push   %ebp
     2ea:	89 e5                	mov    %esp,%ebp
     2ec:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     2ef:	83 ec 08             	sub    $0x8,%esp
     2f2:	ff 75 10             	pushl  0x10(%ebp)
     2f5:	ff 75 0c             	pushl  0xc(%ebp)
     2f8:	e8 37 ff ff ff       	call   234 <matchhere>
     2fd:	83 c4 10             	add    $0x10,%esp
     300:	85 c0                	test   %eax,%eax
     302:	74 07                	je     30b <matchstar+0x22>
      return 1;
     304:	b8 01 00 00 00       	mov    $0x1,%eax
     309:	eb 29                	jmp    334 <matchstar+0x4b>
  }while(*text!='\0' && (*text++==c || c=='.'));
     30b:	8b 45 10             	mov    0x10(%ebp),%eax
     30e:	0f b6 00             	movzbl (%eax),%eax
     311:	84 c0                	test   %al,%al
     313:	74 1a                	je     32f <matchstar+0x46>
     315:	8b 45 10             	mov    0x10(%ebp),%eax
     318:	8d 50 01             	lea    0x1(%eax),%edx
     31b:	89 55 10             	mov    %edx,0x10(%ebp)
     31e:	0f b6 00             	movzbl (%eax),%eax
     321:	0f be c0             	movsbl %al,%eax
     324:	39 45 08             	cmp    %eax,0x8(%ebp)
     327:	74 c6                	je     2ef <matchstar+0x6>
     329:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
     32d:	74 c0                	je     2ef <matchstar+0x6>
  return 0;
     32f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     334:	c9                   	leave  
     335:	c3                   	ret    

00000336 <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
     336:	55                   	push   %ebp
     337:	89 e5                	mov    %esp,%ebp
     339:	57                   	push   %edi
     33a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     33b:	8b 4d 08             	mov    0x8(%ebp),%ecx
     33e:	8b 55 10             	mov    0x10(%ebp),%edx
     341:	8b 45 0c             	mov    0xc(%ebp),%eax
     344:	89 cb                	mov    %ecx,%ebx
     346:	89 df                	mov    %ebx,%edi
     348:	89 d1                	mov    %edx,%ecx
     34a:	fc                   	cld    
     34b:	f3 aa                	rep stos %al,%es:(%edi)
     34d:	89 ca                	mov    %ecx,%edx
     34f:	89 fb                	mov    %edi,%ebx
     351:	89 5d 08             	mov    %ebx,0x8(%ebp)
     354:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     357:	90                   	nop
     358:	5b                   	pop    %ebx
     359:	5f                   	pop    %edi
     35a:	5d                   	pop    %ebp
     35b:	c3                   	ret    

0000035c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     35c:	55                   	push   %ebp
     35d:	89 e5                	mov    %esp,%ebp
     35f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     362:	8b 45 08             	mov    0x8(%ebp),%eax
     365:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     368:	90                   	nop
     369:	8b 55 0c             	mov    0xc(%ebp),%edx
     36c:	8d 42 01             	lea    0x1(%edx),%eax
     36f:	89 45 0c             	mov    %eax,0xc(%ebp)
     372:	8b 45 08             	mov    0x8(%ebp),%eax
     375:	8d 48 01             	lea    0x1(%eax),%ecx
     378:	89 4d 08             	mov    %ecx,0x8(%ebp)
     37b:	0f b6 12             	movzbl (%edx),%edx
     37e:	88 10                	mov    %dl,(%eax)
     380:	0f b6 00             	movzbl (%eax),%eax
     383:	84 c0                	test   %al,%al
     385:	75 e2                	jne    369 <strcpy+0xd>
    ;
  return os;
     387:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     38a:	c9                   	leave  
     38b:	c3                   	ret    

0000038c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     38c:	55                   	push   %ebp
     38d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     38f:	eb 08                	jmp    399 <strcmp+0xd>
    p++, q++;
     391:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     395:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     399:	8b 45 08             	mov    0x8(%ebp),%eax
     39c:	0f b6 00             	movzbl (%eax),%eax
     39f:	84 c0                	test   %al,%al
     3a1:	74 10                	je     3b3 <strcmp+0x27>
     3a3:	8b 45 08             	mov    0x8(%ebp),%eax
     3a6:	0f b6 10             	movzbl (%eax),%edx
     3a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ac:	0f b6 00             	movzbl (%eax),%eax
     3af:	38 c2                	cmp    %al,%dl
     3b1:	74 de                	je     391 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     3b3:	8b 45 08             	mov    0x8(%ebp),%eax
     3b6:	0f b6 00             	movzbl (%eax),%eax
     3b9:	0f b6 d0             	movzbl %al,%edx
     3bc:	8b 45 0c             	mov    0xc(%ebp),%eax
     3bf:	0f b6 00             	movzbl (%eax),%eax
     3c2:	0f b6 c0             	movzbl %al,%eax
     3c5:	29 c2                	sub    %eax,%edx
     3c7:	89 d0                	mov    %edx,%eax
}
     3c9:	5d                   	pop    %ebp
     3ca:	c3                   	ret    

000003cb <strlen>:

uint
strlen(char *s)
{
     3cb:	55                   	push   %ebp
     3cc:	89 e5                	mov    %esp,%ebp
     3ce:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     3d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     3d8:	eb 04                	jmp    3de <strlen+0x13>
     3da:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     3de:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3e1:	8b 45 08             	mov    0x8(%ebp),%eax
     3e4:	01 d0                	add    %edx,%eax
     3e6:	0f b6 00             	movzbl (%eax),%eax
     3e9:	84 c0                	test   %al,%al
     3eb:	75 ed                	jne    3da <strlen+0xf>
    ;
  return n;
     3ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3f0:	c9                   	leave  
     3f1:	c3                   	ret    

000003f2 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     3f2:	55                   	push   %ebp
     3f3:	89 e5                	mov    %esp,%ebp
     3f5:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     3f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     3ff:	eb 0c                	jmp    40d <strnlen+0x1b>
     n++; 
     401:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     405:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     409:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     40d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     411:	74 0a                	je     41d <strnlen+0x2b>
     413:	8b 45 08             	mov    0x8(%ebp),%eax
     416:	0f b6 00             	movzbl (%eax),%eax
     419:	84 c0                	test   %al,%al
     41b:	75 e4                	jne    401 <strnlen+0xf>
   return n; 
     41d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     420:	c9                   	leave  
     421:	c3                   	ret    

00000422 <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     422:	55                   	push   %ebp
     423:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     425:	8b 45 10             	mov    0x10(%ebp),%eax
     428:	50                   	push   %eax
     429:	ff 75 0c             	pushl  0xc(%ebp)
     42c:	ff 75 08             	pushl  0x8(%ebp)
     42f:	e8 02 ff ff ff       	call   336 <stosb>
     434:	83 c4 0c             	add    $0xc,%esp
  return dst;
     437:	8b 45 08             	mov    0x8(%ebp),%eax
}
     43a:	c9                   	leave  
     43b:	c3                   	ret    

0000043c <strchr>:

char*
strchr(const char *s, char c)
{
     43c:	55                   	push   %ebp
     43d:	89 e5                	mov    %esp,%ebp
     43f:	83 ec 04             	sub    $0x4,%esp
     442:	8b 45 0c             	mov    0xc(%ebp),%eax
     445:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     448:	eb 14                	jmp    45e <strchr+0x22>
    if(*s == c)
     44a:	8b 45 08             	mov    0x8(%ebp),%eax
     44d:	0f b6 00             	movzbl (%eax),%eax
     450:	38 45 fc             	cmp    %al,-0x4(%ebp)
     453:	75 05                	jne    45a <strchr+0x1e>
      return (char*)s;
     455:	8b 45 08             	mov    0x8(%ebp),%eax
     458:	eb 13                	jmp    46d <strchr+0x31>
  for(; *s; s++)
     45a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     45e:	8b 45 08             	mov    0x8(%ebp),%eax
     461:	0f b6 00             	movzbl (%eax),%eax
     464:	84 c0                	test   %al,%al
     466:	75 e2                	jne    44a <strchr+0xe>
  return 0;
     468:	b8 00 00 00 00       	mov    $0x0,%eax
}
     46d:	c9                   	leave  
     46e:	c3                   	ret    

0000046f <gets>:

char*
gets(char *buf, int max)
{
     46f:	55                   	push   %ebp
     470:	89 e5                	mov    %esp,%ebp
     472:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     475:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     47c:	eb 42                	jmp    4c0 <gets+0x51>
    cc = read(0, &c, 1);
     47e:	83 ec 04             	sub    $0x4,%esp
     481:	6a 01                	push   $0x1
     483:	8d 45 ef             	lea    -0x11(%ebp),%eax
     486:	50                   	push   %eax
     487:	6a 00                	push   $0x0
     489:	e8 47 01 00 00       	call   5d5 <read>
     48e:	83 c4 10             	add    $0x10,%esp
     491:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     494:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     498:	7e 33                	jle    4cd <gets+0x5e>
      break;
    buf[i++] = c;
     49a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     49d:	8d 50 01             	lea    0x1(%eax),%edx
     4a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4a3:	89 c2                	mov    %eax,%edx
     4a5:	8b 45 08             	mov    0x8(%ebp),%eax
     4a8:	01 c2                	add    %eax,%edx
     4aa:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4ae:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     4b0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4b4:	3c 0a                	cmp    $0xa,%al
     4b6:	74 16                	je     4ce <gets+0x5f>
     4b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4bc:	3c 0d                	cmp    $0xd,%al
     4be:	74 0e                	je     4ce <gets+0x5f>
  for(i=0; i+1 < max; ){
     4c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c3:	83 c0 01             	add    $0x1,%eax
     4c6:	39 45 0c             	cmp    %eax,0xc(%ebp)
     4c9:	7f b3                	jg     47e <gets+0xf>
     4cb:	eb 01                	jmp    4ce <gets+0x5f>
      break;
     4cd:	90                   	nop
      break;
  }
  buf[i] = '\0';
     4ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4d1:	8b 45 08             	mov    0x8(%ebp),%eax
     4d4:	01 d0                	add    %edx,%eax
     4d6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     4d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4dc:	c9                   	leave  
     4dd:	c3                   	ret    

000004de <stat>:

int
stat(char *n, struct stat *st)
{
     4de:	55                   	push   %ebp
     4df:	89 e5                	mov    %esp,%ebp
     4e1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     4e4:	83 ec 08             	sub    $0x8,%esp
     4e7:	6a 00                	push   $0x0
     4e9:	ff 75 08             	pushl  0x8(%ebp)
     4ec:	e8 0c 01 00 00       	call   5fd <open>
     4f1:	83 c4 10             	add    $0x10,%esp
     4f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     4f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4fb:	79 07                	jns    504 <stat+0x26>
    return -1;
     4fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     502:	eb 25                	jmp    529 <stat+0x4b>
  r = fstat(fd, st);
     504:	83 ec 08             	sub    $0x8,%esp
     507:	ff 75 0c             	pushl  0xc(%ebp)
     50a:	ff 75 f4             	pushl  -0xc(%ebp)
     50d:	e8 03 01 00 00       	call   615 <fstat>
     512:	83 c4 10             	add    $0x10,%esp
     515:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     518:	83 ec 0c             	sub    $0xc,%esp
     51b:	ff 75 f4             	pushl  -0xc(%ebp)
     51e:	e8 c2 00 00 00       	call   5e5 <close>
     523:	83 c4 10             	add    $0x10,%esp
  return r;
     526:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     529:	c9                   	leave  
     52a:	c3                   	ret    

0000052b <atoi>:

int
atoi(const char *s)
{
     52b:	55                   	push   %ebp
     52c:	89 e5                	mov    %esp,%ebp
     52e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     531:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     538:	eb 25                	jmp    55f <atoi+0x34>
    n = n*10 + *s++ - '0';
     53a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     53d:	89 d0                	mov    %edx,%eax
     53f:	c1 e0 02             	shl    $0x2,%eax
     542:	01 d0                	add    %edx,%eax
     544:	01 c0                	add    %eax,%eax
     546:	89 c1                	mov    %eax,%ecx
     548:	8b 45 08             	mov    0x8(%ebp),%eax
     54b:	8d 50 01             	lea    0x1(%eax),%edx
     54e:	89 55 08             	mov    %edx,0x8(%ebp)
     551:	0f b6 00             	movzbl (%eax),%eax
     554:	0f be c0             	movsbl %al,%eax
     557:	01 c8                	add    %ecx,%eax
     559:	83 e8 30             	sub    $0x30,%eax
     55c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     55f:	8b 45 08             	mov    0x8(%ebp),%eax
     562:	0f b6 00             	movzbl (%eax),%eax
     565:	3c 2f                	cmp    $0x2f,%al
     567:	7e 0a                	jle    573 <atoi+0x48>
     569:	8b 45 08             	mov    0x8(%ebp),%eax
     56c:	0f b6 00             	movzbl (%eax),%eax
     56f:	3c 39                	cmp    $0x39,%al
     571:	7e c7                	jle    53a <atoi+0xf>
  return n;
     573:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     576:	c9                   	leave  
     577:	c3                   	ret    

00000578 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     578:	55                   	push   %ebp
     579:	89 e5                	mov    %esp,%ebp
     57b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     57e:	8b 45 08             	mov    0x8(%ebp),%eax
     581:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     584:	8b 45 0c             	mov    0xc(%ebp),%eax
     587:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     58a:	eb 17                	jmp    5a3 <memmove+0x2b>
    *dst++ = *src++;
     58c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     58f:	8d 42 01             	lea    0x1(%edx),%eax
     592:	89 45 f8             	mov    %eax,-0x8(%ebp)
     595:	8b 45 fc             	mov    -0x4(%ebp),%eax
     598:	8d 48 01             	lea    0x1(%eax),%ecx
     59b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     59e:	0f b6 12             	movzbl (%edx),%edx
     5a1:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     5a3:	8b 45 10             	mov    0x10(%ebp),%eax
     5a6:	8d 50 ff             	lea    -0x1(%eax),%edx
     5a9:	89 55 10             	mov    %edx,0x10(%ebp)
     5ac:	85 c0                	test   %eax,%eax
     5ae:	7f dc                	jg     58c <memmove+0x14>
  return vdst;
     5b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
     5b3:	c9                   	leave  
     5b4:	c3                   	ret    

000005b5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     5b5:	b8 01 00 00 00       	mov    $0x1,%eax
     5ba:	cd 40                	int    $0x40
     5bc:	c3                   	ret    

000005bd <exit>:
SYSCALL(exit)
     5bd:	b8 02 00 00 00       	mov    $0x2,%eax
     5c2:	cd 40                	int    $0x40
     5c4:	c3                   	ret    

000005c5 <wait>:
SYSCALL(wait)
     5c5:	b8 03 00 00 00       	mov    $0x3,%eax
     5ca:	cd 40                	int    $0x40
     5cc:	c3                   	ret    

000005cd <pipe>:
SYSCALL(pipe)
     5cd:	b8 04 00 00 00       	mov    $0x4,%eax
     5d2:	cd 40                	int    $0x40
     5d4:	c3                   	ret    

000005d5 <read>:
SYSCALL(read)
     5d5:	b8 05 00 00 00       	mov    $0x5,%eax
     5da:	cd 40                	int    $0x40
     5dc:	c3                   	ret    

000005dd <write>:
SYSCALL(write)
     5dd:	b8 10 00 00 00       	mov    $0x10,%eax
     5e2:	cd 40                	int    $0x40
     5e4:	c3                   	ret    

000005e5 <close>:
SYSCALL(close)
     5e5:	b8 15 00 00 00       	mov    $0x15,%eax
     5ea:	cd 40                	int    $0x40
     5ec:	c3                   	ret    

000005ed <kill>:
SYSCALL(kill)
     5ed:	b8 06 00 00 00       	mov    $0x6,%eax
     5f2:	cd 40                	int    $0x40
     5f4:	c3                   	ret    

000005f5 <exec>:
SYSCALL(exec)
     5f5:	b8 07 00 00 00       	mov    $0x7,%eax
     5fa:	cd 40                	int    $0x40
     5fc:	c3                   	ret    

000005fd <open>:
SYSCALL(open)
     5fd:	b8 0f 00 00 00       	mov    $0xf,%eax
     602:	cd 40                	int    $0x40
     604:	c3                   	ret    

00000605 <mknod>:
SYSCALL(mknod)
     605:	b8 11 00 00 00       	mov    $0x11,%eax
     60a:	cd 40                	int    $0x40
     60c:	c3                   	ret    

0000060d <unlink>:
SYSCALL(unlink)
     60d:	b8 12 00 00 00       	mov    $0x12,%eax
     612:	cd 40                	int    $0x40
     614:	c3                   	ret    

00000615 <fstat>:
SYSCALL(fstat)
     615:	b8 08 00 00 00       	mov    $0x8,%eax
     61a:	cd 40                	int    $0x40
     61c:	c3                   	ret    

0000061d <link>:
SYSCALL(link)
     61d:	b8 13 00 00 00       	mov    $0x13,%eax
     622:	cd 40                	int    $0x40
     624:	c3                   	ret    

00000625 <mkdir>:
SYSCALL(mkdir)
     625:	b8 14 00 00 00       	mov    $0x14,%eax
     62a:	cd 40                	int    $0x40
     62c:	c3                   	ret    

0000062d <chdir>:
SYSCALL(chdir)
     62d:	b8 09 00 00 00       	mov    $0x9,%eax
     632:	cd 40                	int    $0x40
     634:	c3                   	ret    

00000635 <dup>:
SYSCALL(dup)
     635:	b8 0a 00 00 00       	mov    $0xa,%eax
     63a:	cd 40                	int    $0x40
     63c:	c3                   	ret    

0000063d <getpid>:
SYSCALL(getpid)
     63d:	b8 0b 00 00 00       	mov    $0xb,%eax
     642:	cd 40                	int    $0x40
     644:	c3                   	ret    

00000645 <sbrk>:
SYSCALL(sbrk)
     645:	b8 0c 00 00 00       	mov    $0xc,%eax
     64a:	cd 40                	int    $0x40
     64c:	c3                   	ret    

0000064d <sleep>:
SYSCALL(sleep)
     64d:	b8 0d 00 00 00       	mov    $0xd,%eax
     652:	cd 40                	int    $0x40
     654:	c3                   	ret    

00000655 <uptime>:
SYSCALL(uptime)
     655:	b8 0e 00 00 00       	mov    $0xe,%eax
     65a:	cd 40                	int    $0x40
     65c:	c3                   	ret    

0000065d <select>:
SYSCALL(select)
     65d:	b8 16 00 00 00       	mov    $0x16,%eax
     662:	cd 40                	int    $0x40
     664:	c3                   	ret    

00000665 <arp>:
SYSCALL(arp)
     665:	b8 17 00 00 00       	mov    $0x17,%eax
     66a:	cd 40                	int    $0x40
     66c:	c3                   	ret    

0000066d <arpserv>:
SYSCALL(arpserv)
     66d:	b8 18 00 00 00       	mov    $0x18,%eax
     672:	cd 40                	int    $0x40
     674:	c3                   	ret    

00000675 <arp_receive>:
SYSCALL(arp_receive)
     675:	b8 19 00 00 00       	mov    $0x19,%eax
     67a:	cd 40                	int    $0x40
     67c:	c3                   	ret    

0000067d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     67d:	55                   	push   %ebp
     67e:	89 e5                	mov    %esp,%ebp
     680:	83 ec 18             	sub    $0x18,%esp
     683:	8b 45 0c             	mov    0xc(%ebp),%eax
     686:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     689:	83 ec 04             	sub    $0x4,%esp
     68c:	6a 01                	push   $0x1
     68e:	8d 45 f4             	lea    -0xc(%ebp),%eax
     691:	50                   	push   %eax
     692:	ff 75 08             	pushl  0x8(%ebp)
     695:	e8 43 ff ff ff       	call   5dd <write>
     69a:	83 c4 10             	add    $0x10,%esp
}
     69d:	90                   	nop
     69e:	c9                   	leave  
     69f:	c3                   	ret    

000006a0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6a6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     6ad:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6b1:	74 17                	je     6ca <printint+0x2a>
     6b3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6b7:	79 11                	jns    6ca <printint+0x2a>
    neg = 1;
     6b9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6c0:	8b 45 0c             	mov    0xc(%ebp),%eax
     6c3:	f7 d8                	neg    %eax
     6c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6c8:	eb 06                	jmp    6d0 <printint+0x30>
  } else {
    x = xx;
     6ca:	8b 45 0c             	mov    0xc(%ebp),%eax
     6cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6da:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6dd:	ba 00 00 00 00       	mov    $0x0,%edx
     6e2:	f7 f1                	div    %ecx
     6e4:	89 d1                	mov    %edx,%ecx
     6e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e9:	8d 50 01             	lea    0x1(%eax),%edx
     6ec:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6ef:	0f b6 91 90 1a 00 00 	movzbl 0x1a90(%ecx),%edx
     6f6:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     6fa:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     700:	ba 00 00 00 00       	mov    $0x0,%edx
     705:	f7 f1                	div    %ecx
     707:	89 45 ec             	mov    %eax,-0x14(%ebp)
     70a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     70e:	75 c7                	jne    6d7 <printint+0x37>
  if(neg)
     710:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     714:	74 2d                	je     743 <printint+0xa3>
    buf[i++] = '-';
     716:	8b 45 f4             	mov    -0xc(%ebp),%eax
     719:	8d 50 01             	lea    0x1(%eax),%edx
     71c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     71f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     724:	eb 1d                	jmp    743 <printint+0xa3>
    putc(fd, buf[i]);
     726:	8d 55 dc             	lea    -0x24(%ebp),%edx
     729:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72c:	01 d0                	add    %edx,%eax
     72e:	0f b6 00             	movzbl (%eax),%eax
     731:	0f be c0             	movsbl %al,%eax
     734:	83 ec 08             	sub    $0x8,%esp
     737:	50                   	push   %eax
     738:	ff 75 08             	pushl  0x8(%ebp)
     73b:	e8 3d ff ff ff       	call   67d <putc>
     740:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     743:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     747:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     74b:	79 d9                	jns    726 <printint+0x86>
}
     74d:	90                   	nop
     74e:	c9                   	leave  
     74f:	c3                   	ret    

00000750 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     750:	55                   	push   %ebp
     751:	89 e5                	mov    %esp,%ebp
     753:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     756:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     75d:	8d 45 0c             	lea    0xc(%ebp),%eax
     760:	83 c0 04             	add    $0x4,%eax
     763:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     766:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     76d:	e9 59 01 00 00       	jmp    8cb <printf+0x17b>
    c = fmt[i] & 0xff;
     772:	8b 55 0c             	mov    0xc(%ebp),%edx
     775:	8b 45 f0             	mov    -0x10(%ebp),%eax
     778:	01 d0                	add    %edx,%eax
     77a:	0f b6 00             	movzbl (%eax),%eax
     77d:	0f be c0             	movsbl %al,%eax
     780:	25 ff 00 00 00       	and    $0xff,%eax
     785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     788:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     78c:	75 2c                	jne    7ba <printf+0x6a>
      if(c == '%'){
     78e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     792:	75 0c                	jne    7a0 <printf+0x50>
        state = '%';
     794:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     79b:	e9 27 01 00 00       	jmp    8c7 <printf+0x177>
      } else {
        putc(fd, c);
     7a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7a3:	0f be c0             	movsbl %al,%eax
     7a6:	83 ec 08             	sub    $0x8,%esp
     7a9:	50                   	push   %eax
     7aa:	ff 75 08             	pushl  0x8(%ebp)
     7ad:	e8 cb fe ff ff       	call   67d <putc>
     7b2:	83 c4 10             	add    $0x10,%esp
     7b5:	e9 0d 01 00 00       	jmp    8c7 <printf+0x177>
      }
    } else if(state == '%'){
     7ba:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7be:	0f 85 03 01 00 00    	jne    8c7 <printf+0x177>
      if(c == 'd'){
     7c4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7c8:	75 1e                	jne    7e8 <printf+0x98>
        printint(fd, *ap, 10, 1);
     7ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7cd:	8b 00                	mov    (%eax),%eax
     7cf:	6a 01                	push   $0x1
     7d1:	6a 0a                	push   $0xa
     7d3:	50                   	push   %eax
     7d4:	ff 75 08             	pushl  0x8(%ebp)
     7d7:	e8 c4 fe ff ff       	call   6a0 <printint>
     7dc:	83 c4 10             	add    $0x10,%esp
        ap++;
     7df:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7e3:	e9 d8 00 00 00       	jmp    8c0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7e8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7ec:	74 06                	je     7f4 <printf+0xa4>
     7ee:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7f2:	75 1e                	jne    812 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     7f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7f7:	8b 00                	mov    (%eax),%eax
     7f9:	6a 00                	push   $0x0
     7fb:	6a 10                	push   $0x10
     7fd:	50                   	push   %eax
     7fe:	ff 75 08             	pushl  0x8(%ebp)
     801:	e8 9a fe ff ff       	call   6a0 <printint>
     806:	83 c4 10             	add    $0x10,%esp
        ap++;
     809:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     80d:	e9 ae 00 00 00       	jmp    8c0 <printf+0x170>
      } else if(c == 's'){
     812:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     816:	75 43                	jne    85b <printf+0x10b>
        s = (char*)*ap;
     818:	8b 45 e8             	mov    -0x18(%ebp),%eax
     81b:	8b 00                	mov    (%eax),%eax
     81d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     820:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     824:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     828:	75 25                	jne    84f <printf+0xff>
          s = "(null)";
     82a:	c7 45 f4 76 13 00 00 	movl   $0x1376,-0xc(%ebp)
        while(*s != 0){
     831:	eb 1c                	jmp    84f <printf+0xff>
          putc(fd, *s);
     833:	8b 45 f4             	mov    -0xc(%ebp),%eax
     836:	0f b6 00             	movzbl (%eax),%eax
     839:	0f be c0             	movsbl %al,%eax
     83c:	83 ec 08             	sub    $0x8,%esp
     83f:	50                   	push   %eax
     840:	ff 75 08             	pushl  0x8(%ebp)
     843:	e8 35 fe ff ff       	call   67d <putc>
     848:	83 c4 10             	add    $0x10,%esp
          s++;
     84b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     84f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     852:	0f b6 00             	movzbl (%eax),%eax
     855:	84 c0                	test   %al,%al
     857:	75 da                	jne    833 <printf+0xe3>
     859:	eb 65                	jmp    8c0 <printf+0x170>
        }
      } else if(c == 'c'){
     85b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     85f:	75 1d                	jne    87e <printf+0x12e>
        putc(fd, *ap);
     861:	8b 45 e8             	mov    -0x18(%ebp),%eax
     864:	8b 00                	mov    (%eax),%eax
     866:	0f be c0             	movsbl %al,%eax
     869:	83 ec 08             	sub    $0x8,%esp
     86c:	50                   	push   %eax
     86d:	ff 75 08             	pushl  0x8(%ebp)
     870:	e8 08 fe ff ff       	call   67d <putc>
     875:	83 c4 10             	add    $0x10,%esp
        ap++;
     878:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     87c:	eb 42                	jmp    8c0 <printf+0x170>
      } else if(c == '%'){
     87e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     882:	75 17                	jne    89b <printf+0x14b>
        putc(fd, c);
     884:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     887:	0f be c0             	movsbl %al,%eax
     88a:	83 ec 08             	sub    $0x8,%esp
     88d:	50                   	push   %eax
     88e:	ff 75 08             	pushl  0x8(%ebp)
     891:	e8 e7 fd ff ff       	call   67d <putc>
     896:	83 c4 10             	add    $0x10,%esp
     899:	eb 25                	jmp    8c0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     89b:	83 ec 08             	sub    $0x8,%esp
     89e:	6a 25                	push   $0x25
     8a0:	ff 75 08             	pushl  0x8(%ebp)
     8a3:	e8 d5 fd ff ff       	call   67d <putc>
     8a8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     8ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8ae:	0f be c0             	movsbl %al,%eax
     8b1:	83 ec 08             	sub    $0x8,%esp
     8b4:	50                   	push   %eax
     8b5:	ff 75 08             	pushl  0x8(%ebp)
     8b8:	e8 c0 fd ff ff       	call   67d <putc>
     8bd:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     8c7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8cb:	8b 55 0c             	mov    0xc(%ebp),%edx
     8ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8d1:	01 d0                	add    %edx,%eax
     8d3:	0f b6 00             	movzbl (%eax),%eax
     8d6:	84 c0                	test   %al,%al
     8d8:	0f 85 94 fe ff ff    	jne    772 <printf+0x22>
    }
  }
}
     8de:	90                   	nop
     8df:	c9                   	leave  
     8e0:	c3                   	ret    

000008e1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8e1:	55                   	push   %ebp
     8e2:	89 e5                	mov    %esp,%ebp
     8e4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8e7:	8b 45 08             	mov    0x8(%ebp),%eax
     8ea:	83 e8 08             	sub    $0x8,%eax
     8ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8f0:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     8f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8f8:	eb 24                	jmp    91e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8fd:	8b 00                	mov    (%eax),%eax
     8ff:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     902:	72 12                	jb     916 <free+0x35>
     904:	8b 45 f8             	mov    -0x8(%ebp),%eax
     907:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     90a:	77 24                	ja     930 <free+0x4f>
     90c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     90f:	8b 00                	mov    (%eax),%eax
     911:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     914:	72 1a                	jb     930 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     916:	8b 45 fc             	mov    -0x4(%ebp),%eax
     919:	8b 00                	mov    (%eax),%eax
     91b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     91e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     921:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     924:	76 d4                	jbe    8fa <free+0x19>
     926:	8b 45 fc             	mov    -0x4(%ebp),%eax
     929:	8b 00                	mov    (%eax),%eax
     92b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     92e:	73 ca                	jae    8fa <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     930:	8b 45 f8             	mov    -0x8(%ebp),%eax
     933:	8b 40 04             	mov    0x4(%eax),%eax
     936:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     93d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     940:	01 c2                	add    %eax,%edx
     942:	8b 45 fc             	mov    -0x4(%ebp),%eax
     945:	8b 00                	mov    (%eax),%eax
     947:	39 c2                	cmp    %eax,%edx
     949:	75 24                	jne    96f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     94b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     94e:	8b 50 04             	mov    0x4(%eax),%edx
     951:	8b 45 fc             	mov    -0x4(%ebp),%eax
     954:	8b 00                	mov    (%eax),%eax
     956:	8b 40 04             	mov    0x4(%eax),%eax
     959:	01 c2                	add    %eax,%edx
     95b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     95e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     961:	8b 45 fc             	mov    -0x4(%ebp),%eax
     964:	8b 00                	mov    (%eax),%eax
     966:	8b 10                	mov    (%eax),%edx
     968:	8b 45 f8             	mov    -0x8(%ebp),%eax
     96b:	89 10                	mov    %edx,(%eax)
     96d:	eb 0a                	jmp    979 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     96f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     972:	8b 10                	mov    (%eax),%edx
     974:	8b 45 f8             	mov    -0x8(%ebp),%eax
     977:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     979:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97c:	8b 40 04             	mov    0x4(%eax),%eax
     97f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     986:	8b 45 fc             	mov    -0x4(%ebp),%eax
     989:	01 d0                	add    %edx,%eax
     98b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     98e:	75 20                	jne    9b0 <free+0xcf>
    p->s.size += bp->s.size;
     990:	8b 45 fc             	mov    -0x4(%ebp),%eax
     993:	8b 50 04             	mov    0x4(%eax),%edx
     996:	8b 45 f8             	mov    -0x8(%ebp),%eax
     999:	8b 40 04             	mov    0x4(%eax),%eax
     99c:	01 c2                	add    %eax,%edx
     99e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     9a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a7:	8b 10                	mov    (%eax),%edx
     9a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ac:	89 10                	mov    %edx,(%eax)
     9ae:	eb 08                	jmp    9b8 <free+0xd7>
  } else
    p->s.ptr = bp;
     9b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9b6:	89 10                	mov    %edx,(%eax)
  freep = p;
     9b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9bb:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
}
     9c0:	90                   	nop
     9c1:	c9                   	leave  
     9c2:	c3                   	ret    

000009c3 <morecore>:

static Header*
morecore(uint nu)
{
     9c3:	55                   	push   %ebp
     9c4:	89 e5                	mov    %esp,%ebp
     9c6:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9c9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9d0:	77 07                	ja     9d9 <morecore+0x16>
    nu = 4096;
     9d2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9d9:	8b 45 08             	mov    0x8(%ebp),%eax
     9dc:	c1 e0 03             	shl    $0x3,%eax
     9df:	83 ec 0c             	sub    $0xc,%esp
     9e2:	50                   	push   %eax
     9e3:	e8 5d fc ff ff       	call   645 <sbrk>
     9e8:	83 c4 10             	add    $0x10,%esp
     9eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9ee:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9f2:	75 07                	jne    9fb <morecore+0x38>
    return 0;
     9f4:	b8 00 00 00 00       	mov    $0x0,%eax
     9f9:	eb 26                	jmp    a21 <morecore+0x5e>
  hp = (Header*)p;
     9fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a01:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a04:	8b 55 08             	mov    0x8(%ebp),%edx
     a07:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a0d:	83 c0 08             	add    $0x8,%eax
     a10:	83 ec 0c             	sub    $0xc,%esp
     a13:	50                   	push   %eax
     a14:	e8 c8 fe ff ff       	call   8e1 <free>
     a19:	83 c4 10             	add    $0x10,%esp
  return freep;
     a1c:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
}
     a21:	c9                   	leave  
     a22:	c3                   	ret    

00000a23 <malloc>:

void*
malloc(uint nbytes)
{
     a23:	55                   	push   %ebp
     a24:	89 e5                	mov    %esp,%ebp
     a26:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a29:	8b 45 08             	mov    0x8(%ebp),%eax
     a2c:	83 c0 07             	add    $0x7,%eax
     a2f:	c1 e8 03             	shr    $0x3,%eax
     a32:	83 c0 01             	add    $0x1,%eax
     a35:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a38:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     a3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a40:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a44:	75 23                	jne    a69 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a46:	c7 45 f0 c0 1a 00 00 	movl   $0x1ac0,-0x10(%ebp)
     a4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a50:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
     a55:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     a5a:	a3 c0 1a 00 00       	mov    %eax,0x1ac0
    base.s.size = 0;
     a5f:	c7 05 c4 1a 00 00 00 	movl   $0x0,0x1ac4
     a66:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a69:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a6c:	8b 00                	mov    (%eax),%eax
     a6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a71:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a74:	8b 40 04             	mov    0x4(%eax),%eax
     a77:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a7a:	77 4d                	ja     ac9 <malloc+0xa6>
      if(p->s.size == nunits)
     a7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7f:	8b 40 04             	mov    0x4(%eax),%eax
     a82:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a85:	75 0c                	jne    a93 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8a:	8b 10                	mov    (%eax),%edx
     a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a8f:	89 10                	mov    %edx,(%eax)
     a91:	eb 26                	jmp    ab9 <malloc+0x96>
      else {
        p->s.size -= nunits;
     a93:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a96:	8b 40 04             	mov    0x4(%eax),%eax
     a99:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a9c:	89 c2                	mov    %eax,%edx
     a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa7:	8b 40 04             	mov    0x4(%eax),%eax
     aaa:	c1 e0 03             	shl    $0x3,%eax
     aad:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     ab0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab3:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ab6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     ab9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     abc:	a3 c8 1a 00 00       	mov    %eax,0x1ac8
      return (void*)(p + 1);
     ac1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac4:	83 c0 08             	add    $0x8,%eax
     ac7:	eb 3b                	jmp    b04 <malloc+0xe1>
    }
    if(p == freep)
     ac9:	a1 c8 1a 00 00       	mov    0x1ac8,%eax
     ace:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ad1:	75 1e                	jne    af1 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     ad3:	83 ec 0c             	sub    $0xc,%esp
     ad6:	ff 75 ec             	pushl  -0x14(%ebp)
     ad9:	e8 e5 fe ff ff       	call   9c3 <morecore>
     ade:	83 c4 10             	add    $0x10,%esp
     ae1:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ae4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ae8:	75 07                	jne    af1 <malloc+0xce>
        return 0;
     aea:	b8 00 00 00 00       	mov    $0x0,%eax
     aef:	eb 13                	jmp    b04 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     af1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afa:	8b 00                	mov    (%eax),%eax
     afc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     aff:	e9 6d ff ff ff       	jmp    a71 <malloc+0x4e>
  }
}
     b04:	c9                   	leave  
     b05:	c3                   	ret    

00000b06 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     b06:	55                   	push   %ebp
     b07:	89 e5                	mov    %esp,%ebp
     b09:	53                   	push   %ebx
     b0a:	83 ec 14             	sub    $0x14,%esp
     b0d:	8b 45 10             	mov    0x10(%ebp),%eax
     b10:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b13:	8b 45 14             	mov    0x14(%ebp),%eax
     b16:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     b19:	8b 45 18             	mov    0x18(%ebp),%eax
     b1c:	ba 00 00 00 00       	mov    $0x0,%edx
     b21:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     b24:	72 55                	jb     b7b <printnum+0x75>
     b26:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     b29:	77 05                	ja     b30 <printnum+0x2a>
     b2b:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     b2e:	72 4b                	jb     b7b <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     b30:	8b 45 1c             	mov    0x1c(%ebp),%eax
     b33:	8d 58 ff             	lea    -0x1(%eax),%ebx
     b36:	8b 45 18             	mov    0x18(%ebp),%eax
     b39:	ba 00 00 00 00       	mov    $0x0,%edx
     b3e:	52                   	push   %edx
     b3f:	50                   	push   %eax
     b40:	ff 75 f4             	pushl  -0xc(%ebp)
     b43:	ff 75 f0             	pushl  -0x10(%ebp)
     b46:	e8 a5 05 00 00       	call   10f0 <__udivdi3>
     b4b:	83 c4 10             	add    $0x10,%esp
     b4e:	83 ec 04             	sub    $0x4,%esp
     b51:	ff 75 20             	pushl  0x20(%ebp)
     b54:	53                   	push   %ebx
     b55:	ff 75 18             	pushl  0x18(%ebp)
     b58:	52                   	push   %edx
     b59:	50                   	push   %eax
     b5a:	ff 75 0c             	pushl  0xc(%ebp)
     b5d:	ff 75 08             	pushl  0x8(%ebp)
     b60:	e8 a1 ff ff ff       	call   b06 <printnum>
     b65:	83 c4 20             	add    $0x20,%esp
     b68:	eb 1b                	jmp    b85 <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     b6a:	83 ec 08             	sub    $0x8,%esp
     b6d:	ff 75 0c             	pushl  0xc(%ebp)
     b70:	ff 75 20             	pushl  0x20(%ebp)
     b73:	8b 45 08             	mov    0x8(%ebp),%eax
     b76:	ff d0                	call   *%eax
     b78:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     b7b:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     b7f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     b83:	7f e5                	jg     b6a <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     b85:	8b 4d 18             	mov    0x18(%ebp),%ecx
     b88:	bb 00 00 00 00       	mov    $0x0,%ebx
     b8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b90:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b93:	53                   	push   %ebx
     b94:	51                   	push   %ecx
     b95:	52                   	push   %edx
     b96:	50                   	push   %eax
     b97:	e8 74 06 00 00       	call   1210 <__umoddi3>
     b9c:	83 c4 10             	add    $0x10,%esp
     b9f:	05 40 14 00 00       	add    $0x1440,%eax
     ba4:	0f b6 00             	movzbl (%eax),%eax
     ba7:	0f be c0             	movsbl %al,%eax
     baa:	83 ec 08             	sub    $0x8,%esp
     bad:	ff 75 0c             	pushl  0xc(%ebp)
     bb0:	50                   	push   %eax
     bb1:	8b 45 08             	mov    0x8(%ebp),%eax
     bb4:	ff d0                	call   *%eax
     bb6:	83 c4 10             	add    $0x10,%esp
}
     bb9:	90                   	nop
     bba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bbd:	c9                   	leave  
     bbe:	c3                   	ret    

00000bbf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     bbf:	55                   	push   %ebp
     bc0:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     bc2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     bc6:	7e 14                	jle    bdc <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     bc8:	8b 45 08             	mov    0x8(%ebp),%eax
     bcb:	8b 00                	mov    (%eax),%eax
     bcd:	8d 48 08             	lea    0x8(%eax),%ecx
     bd0:	8b 55 08             	mov    0x8(%ebp),%edx
     bd3:	89 0a                	mov    %ecx,(%edx)
     bd5:	8b 50 04             	mov    0x4(%eax),%edx
     bd8:	8b 00                	mov    (%eax),%eax
     bda:	eb 30                	jmp    c0c <getuint+0x4d>
  else if (lflag)
     bdc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     be0:	74 16                	je     bf8 <getuint+0x39>
    return va_arg(*ap, unsigned long);
     be2:	8b 45 08             	mov    0x8(%ebp),%eax
     be5:	8b 00                	mov    (%eax),%eax
     be7:	8d 48 04             	lea    0x4(%eax),%ecx
     bea:	8b 55 08             	mov    0x8(%ebp),%edx
     bed:	89 0a                	mov    %ecx,(%edx)
     bef:	8b 00                	mov    (%eax),%eax
     bf1:	ba 00 00 00 00       	mov    $0x0,%edx
     bf6:	eb 14                	jmp    c0c <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     bf8:	8b 45 08             	mov    0x8(%ebp),%eax
     bfb:	8b 00                	mov    (%eax),%eax
     bfd:	8d 48 04             	lea    0x4(%eax),%ecx
     c00:	8b 55 08             	mov    0x8(%ebp),%edx
     c03:	89 0a                	mov    %ecx,(%edx)
     c05:	8b 00                	mov    (%eax),%eax
     c07:	ba 00 00 00 00       	mov    $0x0,%edx
}
     c0c:	5d                   	pop    %ebp
     c0d:	c3                   	ret    

00000c0e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     c0e:	55                   	push   %ebp
     c0f:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     c11:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     c15:	7e 14                	jle    c2b <getint+0x1d>
    return va_arg(*ap, long long);
     c17:	8b 45 08             	mov    0x8(%ebp),%eax
     c1a:	8b 00                	mov    (%eax),%eax
     c1c:	8d 48 08             	lea    0x8(%eax),%ecx
     c1f:	8b 55 08             	mov    0x8(%ebp),%edx
     c22:	89 0a                	mov    %ecx,(%edx)
     c24:	8b 50 04             	mov    0x4(%eax),%edx
     c27:	8b 00                	mov    (%eax),%eax
     c29:	eb 28                	jmp    c53 <getint+0x45>
  else if (lflag)
     c2b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     c2f:	74 12                	je     c43 <getint+0x35>
    return va_arg(*ap, long);
     c31:	8b 45 08             	mov    0x8(%ebp),%eax
     c34:	8b 00                	mov    (%eax),%eax
     c36:	8d 48 04             	lea    0x4(%eax),%ecx
     c39:	8b 55 08             	mov    0x8(%ebp),%edx
     c3c:	89 0a                	mov    %ecx,(%edx)
     c3e:	8b 00                	mov    (%eax),%eax
     c40:	99                   	cltd   
     c41:	eb 10                	jmp    c53 <getint+0x45>
  else
    return va_arg(*ap, int);
     c43:	8b 45 08             	mov    0x8(%ebp),%eax
     c46:	8b 00                	mov    (%eax),%eax
     c48:	8d 48 04             	lea    0x4(%eax),%ecx
     c4b:	8b 55 08             	mov    0x8(%ebp),%edx
     c4e:	89 0a                	mov    %ecx,(%edx)
     c50:	8b 00                	mov    (%eax),%eax
     c52:	99                   	cltd   
}
     c53:	5d                   	pop    %ebp
     c54:	c3                   	ret    

00000c55 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     c55:	55                   	push   %ebp
     c56:	89 e5                	mov    %esp,%ebp
     c58:	56                   	push   %esi
     c59:	53                   	push   %ebx
     c5a:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     c5d:	eb 17                	jmp    c76 <vprintfmt+0x21>
      if (ch == '\0')
     c5f:	85 db                	test   %ebx,%ebx
     c61:	0f 84 a0 03 00 00    	je     1007 <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     c67:	83 ec 08             	sub    $0x8,%esp
     c6a:	ff 75 0c             	pushl  0xc(%ebp)
     c6d:	53                   	push   %ebx
     c6e:	8b 45 08             	mov    0x8(%ebp),%eax
     c71:	ff d0                	call   *%eax
     c73:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     c76:	8b 45 10             	mov    0x10(%ebp),%eax
     c79:	8d 50 01             	lea    0x1(%eax),%edx
     c7c:	89 55 10             	mov    %edx,0x10(%ebp)
     c7f:	0f b6 00             	movzbl (%eax),%eax
     c82:	0f b6 d8             	movzbl %al,%ebx
     c85:	83 fb 25             	cmp    $0x25,%ebx
     c88:	75 d5                	jne    c5f <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     c8a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     c8e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     c95:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     c9c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     ca3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     caa:	8b 45 10             	mov    0x10(%ebp),%eax
     cad:	8d 50 01             	lea    0x1(%eax),%edx
     cb0:	89 55 10             	mov    %edx,0x10(%ebp)
     cb3:	0f b6 00             	movzbl (%eax),%eax
     cb6:	0f b6 d8             	movzbl %al,%ebx
     cb9:	8d 43 dd             	lea    -0x23(%ebx),%eax
     cbc:	83 f8 55             	cmp    $0x55,%eax
     cbf:	0f 87 15 03 00 00    	ja     fda <vprintfmt+0x385>
     cc5:	8b 04 85 64 14 00 00 	mov    0x1464(,%eax,4),%eax
     ccc:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     cce:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     cd2:	eb d6                	jmp    caa <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     cd4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     cd8:	eb d0                	jmp    caa <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     cda:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     ce1:	8b 55 e0             	mov    -0x20(%ebp),%edx
     ce4:	89 d0                	mov    %edx,%eax
     ce6:	c1 e0 02             	shl    $0x2,%eax
     ce9:	01 d0                	add    %edx,%eax
     ceb:	01 c0                	add    %eax,%eax
     ced:	01 d8                	add    %ebx,%eax
     cef:	83 e8 30             	sub    $0x30,%eax
     cf2:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     cf5:	8b 45 10             	mov    0x10(%ebp),%eax
     cf8:	0f b6 00             	movzbl (%eax),%eax
     cfb:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     cfe:	83 fb 2f             	cmp    $0x2f,%ebx
     d01:	7e 39                	jle    d3c <vprintfmt+0xe7>
     d03:	83 fb 39             	cmp    $0x39,%ebx
     d06:	7f 34                	jg     d3c <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     d08:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     d0c:	eb d3                	jmp    ce1 <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     d0e:	8b 45 14             	mov    0x14(%ebp),%eax
     d11:	8d 50 04             	lea    0x4(%eax),%edx
     d14:	89 55 14             	mov    %edx,0x14(%ebp)
     d17:	8b 00                	mov    (%eax),%eax
     d19:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     d1c:	eb 1f                	jmp    d3d <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     d1e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     d22:	79 86                	jns    caa <vprintfmt+0x55>
        width = 0;
     d24:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     d2b:	e9 7a ff ff ff       	jmp    caa <vprintfmt+0x55>

    case '#':
      altflag = 1;
     d30:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     d37:	e9 6e ff ff ff       	jmp    caa <vprintfmt+0x55>
      goto process_precision;
     d3c:	90                   	nop

process_precision:
      if (width < 0)
     d3d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     d41:	0f 89 63 ff ff ff    	jns    caa <vprintfmt+0x55>
        width = precision, precision = -1;
     d47:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d4a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     d4d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     d54:	e9 51 ff ff ff       	jmp    caa <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     d59:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     d5d:	e9 48 ff ff ff       	jmp    caa <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     d62:	8b 45 14             	mov    0x14(%ebp),%eax
     d65:	8d 50 04             	lea    0x4(%eax),%edx
     d68:	89 55 14             	mov    %edx,0x14(%ebp)
     d6b:	8b 00                	mov    (%eax),%eax
     d6d:	83 ec 08             	sub    $0x8,%esp
     d70:	ff 75 0c             	pushl  0xc(%ebp)
     d73:	50                   	push   %eax
     d74:	8b 45 08             	mov    0x8(%ebp),%eax
     d77:	ff d0                	call   *%eax
     d79:	83 c4 10             	add    $0x10,%esp
      break;
     d7c:	e9 81 02 00 00       	jmp    1002 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     d81:	8b 45 14             	mov    0x14(%ebp),%eax
     d84:	8d 50 04             	lea    0x4(%eax),%edx
     d87:	89 55 14             	mov    %edx,0x14(%ebp)
     d8a:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     d8c:	85 db                	test   %ebx,%ebx
     d8e:	79 02                	jns    d92 <vprintfmt+0x13d>
        err = -err;
     d90:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     d92:	83 fb 0f             	cmp    $0xf,%ebx
     d95:	7f 0b                	jg     da2 <vprintfmt+0x14d>
     d97:	8b 34 9d 00 14 00 00 	mov    0x1400(,%ebx,4),%esi
     d9e:	85 f6                	test   %esi,%esi
     da0:	75 19                	jne    dbb <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     da2:	53                   	push   %ebx
     da3:	68 51 14 00 00       	push   $0x1451
     da8:	ff 75 0c             	pushl  0xc(%ebp)
     dab:	ff 75 08             	pushl  0x8(%ebp)
     dae:	e8 5c 02 00 00       	call   100f <printfmt>
     db3:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     db6:	e9 47 02 00 00       	jmp    1002 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     dbb:	56                   	push   %esi
     dbc:	68 5a 14 00 00       	push   $0x145a
     dc1:	ff 75 0c             	pushl  0xc(%ebp)
     dc4:	ff 75 08             	pushl  0x8(%ebp)
     dc7:	e8 43 02 00 00       	call   100f <printfmt>
     dcc:	83 c4 10             	add    $0x10,%esp
      break;
     dcf:	e9 2e 02 00 00       	jmp    1002 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     dd4:	8b 45 14             	mov    0x14(%ebp),%eax
     dd7:	8d 50 04             	lea    0x4(%eax),%edx
     dda:	89 55 14             	mov    %edx,0x14(%ebp)
     ddd:	8b 30                	mov    (%eax),%esi
     ddf:	85 f6                	test   %esi,%esi
     de1:	75 05                	jne    de8 <vprintfmt+0x193>
        p = "(null)";
     de3:	be 5d 14 00 00       	mov    $0x145d,%esi
      if (width > 0 && padc != '-')
     de8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     dec:	7e 6f                	jle    e5d <vprintfmt+0x208>
     dee:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     df2:	74 69                	je     e5d <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     df4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     df7:	83 ec 08             	sub    $0x8,%esp
     dfa:	50                   	push   %eax
     dfb:	56                   	push   %esi
     dfc:	e8 f1 f5 ff ff       	call   3f2 <strnlen>
     e01:	83 c4 10             	add    $0x10,%esp
     e04:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     e07:	eb 17                	jmp    e20 <vprintfmt+0x1cb>
          putch(padc, putdat);
     e09:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     e0d:	83 ec 08             	sub    $0x8,%esp
     e10:	ff 75 0c             	pushl  0xc(%ebp)
     e13:	50                   	push   %eax
     e14:	8b 45 08             	mov    0x8(%ebp),%eax
     e17:	ff d0                	call   *%eax
     e19:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     e1c:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     e20:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     e24:	7f e3                	jg     e09 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     e26:	eb 35                	jmp    e5d <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     e28:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     e2c:	74 1c                	je     e4a <vprintfmt+0x1f5>
     e2e:	83 fb 1f             	cmp    $0x1f,%ebx
     e31:	7e 05                	jle    e38 <vprintfmt+0x1e3>
     e33:	83 fb 7e             	cmp    $0x7e,%ebx
     e36:	7e 12                	jle    e4a <vprintfmt+0x1f5>
          putch('?', putdat);
     e38:	83 ec 08             	sub    $0x8,%esp
     e3b:	ff 75 0c             	pushl  0xc(%ebp)
     e3e:	6a 3f                	push   $0x3f
     e40:	8b 45 08             	mov    0x8(%ebp),%eax
     e43:	ff d0                	call   *%eax
     e45:	83 c4 10             	add    $0x10,%esp
     e48:	eb 0f                	jmp    e59 <vprintfmt+0x204>
        else
          putch(ch, putdat);
     e4a:	83 ec 08             	sub    $0x8,%esp
     e4d:	ff 75 0c             	pushl  0xc(%ebp)
     e50:	53                   	push   %ebx
     e51:	8b 45 08             	mov    0x8(%ebp),%eax
     e54:	ff d0                	call   *%eax
     e56:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     e59:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     e5d:	89 f0                	mov    %esi,%eax
     e5f:	8d 70 01             	lea    0x1(%eax),%esi
     e62:	0f b6 00             	movzbl (%eax),%eax
     e65:	0f be d8             	movsbl %al,%ebx
     e68:	85 db                	test   %ebx,%ebx
     e6a:	74 26                	je     e92 <vprintfmt+0x23d>
     e6c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     e70:	78 b6                	js     e28 <vprintfmt+0x1d3>
     e72:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     e76:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     e7a:	79 ac                	jns    e28 <vprintfmt+0x1d3>
      for (; width > 0; width--)
     e7c:	eb 14                	jmp    e92 <vprintfmt+0x23d>
        putch(' ', putdat);
     e7e:	83 ec 08             	sub    $0x8,%esp
     e81:	ff 75 0c             	pushl  0xc(%ebp)
     e84:	6a 20                	push   $0x20
     e86:	8b 45 08             	mov    0x8(%ebp),%eax
     e89:	ff d0                	call   *%eax
     e8b:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     e8e:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     e92:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     e96:	7f e6                	jg     e7e <vprintfmt+0x229>
      break;
     e98:	e9 65 01 00 00       	jmp    1002 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     e9d:	83 ec 08             	sub    $0x8,%esp
     ea0:	ff 75 e8             	pushl  -0x18(%ebp)
     ea3:	8d 45 14             	lea    0x14(%ebp),%eax
     ea6:	50                   	push   %eax
     ea7:	e8 62 fd ff ff       	call   c0e <getint>
     eac:	83 c4 10             	add    $0x10,%esp
     eaf:	89 45 f0             	mov    %eax,-0x10(%ebp)
     eb2:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     eb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ebb:	85 d2                	test   %edx,%edx
     ebd:	79 23                	jns    ee2 <vprintfmt+0x28d>
        putch('-', putdat);
     ebf:	83 ec 08             	sub    $0x8,%esp
     ec2:	ff 75 0c             	pushl  0xc(%ebp)
     ec5:	6a 2d                	push   $0x2d
     ec7:	8b 45 08             	mov    0x8(%ebp),%eax
     eca:	ff d0                	call   *%eax
     ecc:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     ecf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ed2:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ed5:	f7 d8                	neg    %eax
     ed7:	83 d2 00             	adc    $0x0,%edx
     eda:	f7 da                	neg    %edx
     edc:	89 45 f0             	mov    %eax,-0x10(%ebp)
     edf:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     ee2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     ee9:	e9 b6 00 00 00       	jmp    fa4 <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     eee:	83 ec 08             	sub    $0x8,%esp
     ef1:	ff 75 e8             	pushl  -0x18(%ebp)
     ef4:	8d 45 14             	lea    0x14(%ebp),%eax
     ef7:	50                   	push   %eax
     ef8:	e8 c2 fc ff ff       	call   bbf <getuint>
     efd:	83 c4 10             	add    $0x10,%esp
     f00:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f03:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     f06:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     f0d:	e9 92 00 00 00       	jmp    fa4 <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     f12:	83 ec 08             	sub    $0x8,%esp
     f15:	ff 75 0c             	pushl  0xc(%ebp)
     f18:	6a 58                	push   $0x58
     f1a:	8b 45 08             	mov    0x8(%ebp),%eax
     f1d:	ff d0                	call   *%eax
     f1f:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     f22:	83 ec 08             	sub    $0x8,%esp
     f25:	ff 75 0c             	pushl  0xc(%ebp)
     f28:	6a 58                	push   $0x58
     f2a:	8b 45 08             	mov    0x8(%ebp),%eax
     f2d:	ff d0                	call   *%eax
     f2f:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     f32:	83 ec 08             	sub    $0x8,%esp
     f35:	ff 75 0c             	pushl  0xc(%ebp)
     f38:	6a 58                	push   $0x58
     f3a:	8b 45 08             	mov    0x8(%ebp),%eax
     f3d:	ff d0                	call   *%eax
     f3f:	83 c4 10             	add    $0x10,%esp
      break;
     f42:	e9 bb 00 00 00       	jmp    1002 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     f47:	83 ec 08             	sub    $0x8,%esp
     f4a:	ff 75 0c             	pushl  0xc(%ebp)
     f4d:	6a 30                	push   $0x30
     f4f:	8b 45 08             	mov    0x8(%ebp),%eax
     f52:	ff d0                	call   *%eax
     f54:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     f57:	83 ec 08             	sub    $0x8,%esp
     f5a:	ff 75 0c             	pushl  0xc(%ebp)
     f5d:	6a 78                	push   $0x78
     f5f:	8b 45 08             	mov    0x8(%ebp),%eax
     f62:	ff d0                	call   *%eax
     f64:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     f67:	8b 45 14             	mov    0x14(%ebp),%eax
     f6a:	8d 50 04             	lea    0x4(%eax),%edx
     f6d:	89 55 14             	mov    %edx,0x14(%ebp)
     f70:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     f72:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     f7c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     f83:	eb 1f                	jmp    fa4 <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     f85:	83 ec 08             	sub    $0x8,%esp
     f88:	ff 75 e8             	pushl  -0x18(%ebp)
     f8b:	8d 45 14             	lea    0x14(%ebp),%eax
     f8e:	50                   	push   %eax
     f8f:	e8 2b fc ff ff       	call   bbf <getuint>
     f94:	83 c4 10             	add    $0x10,%esp
     f97:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f9a:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     f9d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     fa4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     fa8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fab:	83 ec 04             	sub    $0x4,%esp
     fae:	52                   	push   %edx
     faf:	ff 75 e4             	pushl  -0x1c(%ebp)
     fb2:	50                   	push   %eax
     fb3:	ff 75 f4             	pushl  -0xc(%ebp)
     fb6:	ff 75 f0             	pushl  -0x10(%ebp)
     fb9:	ff 75 0c             	pushl  0xc(%ebp)
     fbc:	ff 75 08             	pushl  0x8(%ebp)
     fbf:	e8 42 fb ff ff       	call   b06 <printnum>
     fc4:	83 c4 20             	add    $0x20,%esp
      break;
     fc7:	eb 39                	jmp    1002 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     fc9:	83 ec 08             	sub    $0x8,%esp
     fcc:	ff 75 0c             	pushl  0xc(%ebp)
     fcf:	53                   	push   %ebx
     fd0:	8b 45 08             	mov    0x8(%ebp),%eax
     fd3:	ff d0                	call   *%eax
     fd5:	83 c4 10             	add    $0x10,%esp
      break;
     fd8:	eb 28                	jmp    1002 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     fda:	83 ec 08             	sub    $0x8,%esp
     fdd:	ff 75 0c             	pushl  0xc(%ebp)
     fe0:	6a 25                	push   $0x25
     fe2:	8b 45 08             	mov    0x8(%ebp),%eax
     fe5:	ff d0                	call   *%eax
     fe7:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     fea:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     fee:	eb 04                	jmp    ff4 <vprintfmt+0x39f>
     ff0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     ff4:	8b 45 10             	mov    0x10(%ebp),%eax
     ff7:	83 e8 01             	sub    $0x1,%eax
     ffa:	0f b6 00             	movzbl (%eax),%eax
     ffd:	3c 25                	cmp    $0x25,%al
     fff:	75 ef                	jne    ff0 <vprintfmt+0x39b>
        /* do nothing */;
      break;
    1001:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
    1002:	e9 6f fc ff ff       	jmp    c76 <vprintfmt+0x21>
        return;
    1007:	90                   	nop
    }
  }
}
    1008:	8d 65 f8             	lea    -0x8(%ebp),%esp
    100b:	5b                   	pop    %ebx
    100c:	5e                   	pop    %esi
    100d:	5d                   	pop    %ebp
    100e:	c3                   	ret    

0000100f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
    100f:	55                   	push   %ebp
    1010:	89 e5                	mov    %esp,%ebp
    1012:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
    1015:	8d 45 14             	lea    0x14(%ebp),%eax
    1018:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
    101b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101e:	50                   	push   %eax
    101f:	ff 75 10             	pushl  0x10(%ebp)
    1022:	ff 75 0c             	pushl  0xc(%ebp)
    1025:	ff 75 08             	pushl  0x8(%ebp)
    1028:	e8 28 fc ff ff       	call   c55 <vprintfmt>
    102d:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
    1030:	90                   	nop
    1031:	c9                   	leave  
    1032:	c3                   	ret    

00001033 <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
    1033:	55                   	push   %ebp
    1034:	89 e5                	mov    %esp,%ebp
  b->cnt++;
    1036:	8b 45 0c             	mov    0xc(%ebp),%eax
    1039:	8b 40 08             	mov    0x8(%eax),%eax
    103c:	8d 50 01             	lea    0x1(%eax),%edx
    103f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1042:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
    1045:	8b 45 0c             	mov    0xc(%ebp),%eax
    1048:	8b 10                	mov    (%eax),%edx
    104a:	8b 45 0c             	mov    0xc(%ebp),%eax
    104d:	8b 40 04             	mov    0x4(%eax),%eax
    1050:	39 c2                	cmp    %eax,%edx
    1052:	73 12                	jae    1066 <sprintputch+0x33>
    *b->buf++ = ch;
    1054:	8b 45 0c             	mov    0xc(%ebp),%eax
    1057:	8b 00                	mov    (%eax),%eax
    1059:	8d 48 01             	lea    0x1(%eax),%ecx
    105c:	8b 55 0c             	mov    0xc(%ebp),%edx
    105f:	89 0a                	mov    %ecx,(%edx)
    1061:	8b 55 08             	mov    0x8(%ebp),%edx
    1064:	88 10                	mov    %dl,(%eax)
}
    1066:	90                   	nop
    1067:	5d                   	pop    %ebp
    1068:	c3                   	ret    

00001069 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    1069:	55                   	push   %ebp
    106a:	89 e5                	mov    %esp,%ebp
    106c:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
    106f:	8b 45 08             	mov    0x8(%ebp),%eax
    1072:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1075:	8b 45 0c             	mov    0xc(%ebp),%eax
    1078:	8d 50 ff             	lea    -0x1(%eax),%edx
    107b:	8b 45 08             	mov    0x8(%ebp),%eax
    107e:	01 d0                	add    %edx,%eax
    1080:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1083:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
    108a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    108e:	74 06                	je     1096 <vsnprintf+0x2d>
    1090:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1094:	7f 07                	jg     109d <vsnprintf+0x34>
    return -E_INVAL;
    1096:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    109b:	eb 20                	jmp    10bd <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
    109d:	ff 75 14             	pushl  0x14(%ebp)
    10a0:	ff 75 10             	pushl  0x10(%ebp)
    10a3:	8d 45 ec             	lea    -0x14(%ebp),%eax
    10a6:	50                   	push   %eax
    10a7:	68 33 10 00 00       	push   $0x1033
    10ac:	e8 a4 fb ff ff       	call   c55 <vprintfmt>
    10b1:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
    10b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10b7:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
    10ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10bd:	c9                   	leave  
    10be:	c3                   	ret    

000010bf <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
    10bf:	55                   	push   %ebp
    10c0:	89 e5                	mov    %esp,%ebp
    10c2:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
    10c5:	8d 45 14             	lea    0x14(%ebp),%eax
    10c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
    10cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10ce:	50                   	push   %eax
    10cf:	ff 75 10             	pushl  0x10(%ebp)
    10d2:	ff 75 0c             	pushl  0xc(%ebp)
    10d5:	ff 75 08             	pushl  0x8(%ebp)
    10d8:	e8 8c ff ff ff       	call   1069 <vsnprintf>
    10dd:	83 c4 10             	add    $0x10,%esp
    10e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
    10e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10e6:	c9                   	leave  
    10e7:	c3                   	ret    
    10e8:	66 90                	xchg   %ax,%ax
    10ea:	66 90                	xchg   %ax,%ax
    10ec:	66 90                	xchg   %ax,%ax
    10ee:	66 90                	xchg   %ax,%ax

000010f0 <__udivdi3>:
    10f0:	55                   	push   %ebp
    10f1:	57                   	push   %edi
    10f2:	56                   	push   %esi
    10f3:	53                   	push   %ebx
    10f4:	83 ec 1c             	sub    $0x1c,%esp
    10f7:	8b 54 24 3c          	mov    0x3c(%esp),%edx
    10fb:	8b 6c 24 30          	mov    0x30(%esp),%ebp
    10ff:	8b 74 24 34          	mov    0x34(%esp),%esi
    1103:	8b 5c 24 38          	mov    0x38(%esp),%ebx
    1107:	85 d2                	test   %edx,%edx
    1109:	75 35                	jne    1140 <__udivdi3+0x50>
    110b:	39 f3                	cmp    %esi,%ebx
    110d:	0f 87 bd 00 00 00    	ja     11d0 <__udivdi3+0xe0>
    1113:	85 db                	test   %ebx,%ebx
    1115:	89 d9                	mov    %ebx,%ecx
    1117:	75 0b                	jne    1124 <__udivdi3+0x34>
    1119:	b8 01 00 00 00       	mov    $0x1,%eax
    111e:	31 d2                	xor    %edx,%edx
    1120:	f7 f3                	div    %ebx
    1122:	89 c1                	mov    %eax,%ecx
    1124:	31 d2                	xor    %edx,%edx
    1126:	89 f0                	mov    %esi,%eax
    1128:	f7 f1                	div    %ecx
    112a:	89 c6                	mov    %eax,%esi
    112c:	89 e8                	mov    %ebp,%eax
    112e:	89 f7                	mov    %esi,%edi
    1130:	f7 f1                	div    %ecx
    1132:	89 fa                	mov    %edi,%edx
    1134:	83 c4 1c             	add    $0x1c,%esp
    1137:	5b                   	pop    %ebx
    1138:	5e                   	pop    %esi
    1139:	5f                   	pop    %edi
    113a:	5d                   	pop    %ebp
    113b:	c3                   	ret    
    113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1140:	39 f2                	cmp    %esi,%edx
    1142:	77 7c                	ja     11c0 <__udivdi3+0xd0>
    1144:	0f bd fa             	bsr    %edx,%edi
    1147:	83 f7 1f             	xor    $0x1f,%edi
    114a:	0f 84 98 00 00 00    	je     11e8 <__udivdi3+0xf8>
    1150:	89 f9                	mov    %edi,%ecx
    1152:	b8 20 00 00 00       	mov    $0x20,%eax
    1157:	29 f8                	sub    %edi,%eax
    1159:	d3 e2                	shl    %cl,%edx
    115b:	89 54 24 08          	mov    %edx,0x8(%esp)
    115f:	89 c1                	mov    %eax,%ecx
    1161:	89 da                	mov    %ebx,%edx
    1163:	d3 ea                	shr    %cl,%edx
    1165:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    1169:	09 d1                	or     %edx,%ecx
    116b:	89 f2                	mov    %esi,%edx
    116d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1171:	89 f9                	mov    %edi,%ecx
    1173:	d3 e3                	shl    %cl,%ebx
    1175:	89 c1                	mov    %eax,%ecx
    1177:	d3 ea                	shr    %cl,%edx
    1179:	89 f9                	mov    %edi,%ecx
    117b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    117f:	d3 e6                	shl    %cl,%esi
    1181:	89 eb                	mov    %ebp,%ebx
    1183:	89 c1                	mov    %eax,%ecx
    1185:	d3 eb                	shr    %cl,%ebx
    1187:	09 de                	or     %ebx,%esi
    1189:	89 f0                	mov    %esi,%eax
    118b:	f7 74 24 08          	divl   0x8(%esp)
    118f:	89 d6                	mov    %edx,%esi
    1191:	89 c3                	mov    %eax,%ebx
    1193:	f7 64 24 0c          	mull   0xc(%esp)
    1197:	39 d6                	cmp    %edx,%esi
    1199:	72 0c                	jb     11a7 <__udivdi3+0xb7>
    119b:	89 f9                	mov    %edi,%ecx
    119d:	d3 e5                	shl    %cl,%ebp
    119f:	39 c5                	cmp    %eax,%ebp
    11a1:	73 5d                	jae    1200 <__udivdi3+0x110>
    11a3:	39 d6                	cmp    %edx,%esi
    11a5:	75 59                	jne    1200 <__udivdi3+0x110>
    11a7:	8d 43 ff             	lea    -0x1(%ebx),%eax
    11aa:	31 ff                	xor    %edi,%edi
    11ac:	89 fa                	mov    %edi,%edx
    11ae:	83 c4 1c             	add    $0x1c,%esp
    11b1:	5b                   	pop    %ebx
    11b2:	5e                   	pop    %esi
    11b3:	5f                   	pop    %edi
    11b4:	5d                   	pop    %ebp
    11b5:	c3                   	ret    
    11b6:	8d 76 00             	lea    0x0(%esi),%esi
    11b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    11c0:	31 ff                	xor    %edi,%edi
    11c2:	31 c0                	xor    %eax,%eax
    11c4:	89 fa                	mov    %edi,%edx
    11c6:	83 c4 1c             	add    $0x1c,%esp
    11c9:	5b                   	pop    %ebx
    11ca:	5e                   	pop    %esi
    11cb:	5f                   	pop    %edi
    11cc:	5d                   	pop    %ebp
    11cd:	c3                   	ret    
    11ce:	66 90                	xchg   %ax,%ax
    11d0:	31 ff                	xor    %edi,%edi
    11d2:	89 e8                	mov    %ebp,%eax
    11d4:	89 f2                	mov    %esi,%edx
    11d6:	f7 f3                	div    %ebx
    11d8:	89 fa                	mov    %edi,%edx
    11da:	83 c4 1c             	add    $0x1c,%esp
    11dd:	5b                   	pop    %ebx
    11de:	5e                   	pop    %esi
    11df:	5f                   	pop    %edi
    11e0:	5d                   	pop    %ebp
    11e1:	c3                   	ret    
    11e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11e8:	39 f2                	cmp    %esi,%edx
    11ea:	72 06                	jb     11f2 <__udivdi3+0x102>
    11ec:	31 c0                	xor    %eax,%eax
    11ee:	39 eb                	cmp    %ebp,%ebx
    11f0:	77 d2                	ja     11c4 <__udivdi3+0xd4>
    11f2:	b8 01 00 00 00       	mov    $0x1,%eax
    11f7:	eb cb                	jmp    11c4 <__udivdi3+0xd4>
    11f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1200:	89 d8                	mov    %ebx,%eax
    1202:	31 ff                	xor    %edi,%edi
    1204:	eb be                	jmp    11c4 <__udivdi3+0xd4>
    1206:	66 90                	xchg   %ax,%ax
    1208:	66 90                	xchg   %ax,%ax
    120a:	66 90                	xchg   %ax,%ax
    120c:	66 90                	xchg   %ax,%ax
    120e:	66 90                	xchg   %ax,%ax

00001210 <__umoddi3>:
    1210:	55                   	push   %ebp
    1211:	57                   	push   %edi
    1212:	56                   	push   %esi
    1213:	53                   	push   %ebx
    1214:	83 ec 1c             	sub    $0x1c,%esp
    1217:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
    121b:	8b 74 24 30          	mov    0x30(%esp),%esi
    121f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
    1223:	8b 7c 24 38          	mov    0x38(%esp),%edi
    1227:	85 ed                	test   %ebp,%ebp
    1229:	89 f0                	mov    %esi,%eax
    122b:	89 da                	mov    %ebx,%edx
    122d:	75 19                	jne    1248 <__umoddi3+0x38>
    122f:	39 df                	cmp    %ebx,%edi
    1231:	0f 86 b1 00 00 00    	jbe    12e8 <__umoddi3+0xd8>
    1237:	f7 f7                	div    %edi
    1239:	89 d0                	mov    %edx,%eax
    123b:	31 d2                	xor    %edx,%edx
    123d:	83 c4 1c             	add    $0x1c,%esp
    1240:	5b                   	pop    %ebx
    1241:	5e                   	pop    %esi
    1242:	5f                   	pop    %edi
    1243:	5d                   	pop    %ebp
    1244:	c3                   	ret    
    1245:	8d 76 00             	lea    0x0(%esi),%esi
    1248:	39 dd                	cmp    %ebx,%ebp
    124a:	77 f1                	ja     123d <__umoddi3+0x2d>
    124c:	0f bd cd             	bsr    %ebp,%ecx
    124f:	83 f1 1f             	xor    $0x1f,%ecx
    1252:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1256:	0f 84 b4 00 00 00    	je     1310 <__umoddi3+0x100>
    125c:	b8 20 00 00 00       	mov    $0x20,%eax
    1261:	89 c2                	mov    %eax,%edx
    1263:	8b 44 24 04          	mov    0x4(%esp),%eax
    1267:	29 c2                	sub    %eax,%edx
    1269:	89 c1                	mov    %eax,%ecx
    126b:	89 f8                	mov    %edi,%eax
    126d:	d3 e5                	shl    %cl,%ebp
    126f:	89 d1                	mov    %edx,%ecx
    1271:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1275:	d3 e8                	shr    %cl,%eax
    1277:	09 c5                	or     %eax,%ebp
    1279:	8b 44 24 04          	mov    0x4(%esp),%eax
    127d:	89 c1                	mov    %eax,%ecx
    127f:	d3 e7                	shl    %cl,%edi
    1281:	89 d1                	mov    %edx,%ecx
    1283:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1287:	89 df                	mov    %ebx,%edi
    1289:	d3 ef                	shr    %cl,%edi
    128b:	89 c1                	mov    %eax,%ecx
    128d:	89 f0                	mov    %esi,%eax
    128f:	d3 e3                	shl    %cl,%ebx
    1291:	89 d1                	mov    %edx,%ecx
    1293:	89 fa                	mov    %edi,%edx
    1295:	d3 e8                	shr    %cl,%eax
    1297:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
    129c:	09 d8                	or     %ebx,%eax
    129e:	f7 f5                	div    %ebp
    12a0:	d3 e6                	shl    %cl,%esi
    12a2:	89 d1                	mov    %edx,%ecx
    12a4:	f7 64 24 08          	mull   0x8(%esp)
    12a8:	39 d1                	cmp    %edx,%ecx
    12aa:	89 c3                	mov    %eax,%ebx
    12ac:	89 d7                	mov    %edx,%edi
    12ae:	72 06                	jb     12b6 <__umoddi3+0xa6>
    12b0:	75 0e                	jne    12c0 <__umoddi3+0xb0>
    12b2:	39 c6                	cmp    %eax,%esi
    12b4:	73 0a                	jae    12c0 <__umoddi3+0xb0>
    12b6:	2b 44 24 08          	sub    0x8(%esp),%eax
    12ba:	19 ea                	sbb    %ebp,%edx
    12bc:	89 d7                	mov    %edx,%edi
    12be:	89 c3                	mov    %eax,%ebx
    12c0:	89 ca                	mov    %ecx,%edx
    12c2:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    12c7:	29 de                	sub    %ebx,%esi
    12c9:	19 fa                	sbb    %edi,%edx
    12cb:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    12cf:	89 d0                	mov    %edx,%eax
    12d1:	d3 e0                	shl    %cl,%eax
    12d3:	89 d9                	mov    %ebx,%ecx
    12d5:	d3 ee                	shr    %cl,%esi
    12d7:	d3 ea                	shr    %cl,%edx
    12d9:	09 f0                	or     %esi,%eax
    12db:	83 c4 1c             	add    $0x1c,%esp
    12de:	5b                   	pop    %ebx
    12df:	5e                   	pop    %esi
    12e0:	5f                   	pop    %edi
    12e1:	5d                   	pop    %ebp
    12e2:	c3                   	ret    
    12e3:	90                   	nop
    12e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12e8:	85 ff                	test   %edi,%edi
    12ea:	89 f9                	mov    %edi,%ecx
    12ec:	75 0b                	jne    12f9 <__umoddi3+0xe9>
    12ee:	b8 01 00 00 00       	mov    $0x1,%eax
    12f3:	31 d2                	xor    %edx,%edx
    12f5:	f7 f7                	div    %edi
    12f7:	89 c1                	mov    %eax,%ecx
    12f9:	89 d8                	mov    %ebx,%eax
    12fb:	31 d2                	xor    %edx,%edx
    12fd:	f7 f1                	div    %ecx
    12ff:	89 f0                	mov    %esi,%eax
    1301:	f7 f1                	div    %ecx
    1303:	e9 31 ff ff ff       	jmp    1239 <__umoddi3+0x29>
    1308:	90                   	nop
    1309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1310:	39 dd                	cmp    %ebx,%ebp
    1312:	72 08                	jb     131c <__umoddi3+0x10c>
    1314:	39 f7                	cmp    %esi,%edi
    1316:	0f 87 21 ff ff ff    	ja     123d <__umoddi3+0x2d>
    131c:	89 da                	mov    %ebx,%edx
    131e:	89 f0                	mov    %esi,%eax
    1320:	29 f8                	sub    %edi,%eax
    1322:	19 ea                	sbb    %ebp,%edx
    1324:	e9 14 ff ff ff       	jmp    123d <__umoddi3+0x2d>
