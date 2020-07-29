
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
       7:	83 ec 0c             	sub    $0xc,%esp
       a:	ff 75 08             	pushl  0x8(%ebp)
       d:	e8 c9 03 00 00       	call   3db <strlen>
      12:	83 c4 10             	add    $0x10,%esp
      15:	89 c2                	mov    %eax,%edx
      17:	8b 45 08             	mov    0x8(%ebp),%eax
      1a:	01 d0                	add    %edx,%eax
      1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      1f:	eb 04                	jmp    25 <fmtname+0x25>
      21:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
      25:	8b 45 f4             	mov    -0xc(%ebp),%eax
      28:	3b 45 08             	cmp    0x8(%ebp),%eax
      2b:	72 0a                	jb     37 <fmtname+0x37>
      2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      30:	0f b6 00             	movzbl (%eax),%eax
      33:	3c 2f                	cmp    $0x2f,%al
      35:	75 ea                	jne    21 <fmtname+0x21>
    ;
  p++;
      37:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
      3b:	83 ec 0c             	sub    $0xc,%esp
      3e:	ff 75 f4             	pushl  -0xc(%ebp)
      41:	e8 95 03 00 00       	call   3db <strlen>
      46:	83 c4 10             	add    $0x10,%esp
      49:	83 f8 0d             	cmp    $0xd,%eax
      4c:	76 05                	jbe    53 <fmtname+0x53>
    return p;
      4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
      51:	eb 60                	jmp    b3 <fmtname+0xb3>
  memmove(buf, p, strlen(p));
      53:	83 ec 0c             	sub    $0xc,%esp
      56:	ff 75 f4             	pushl  -0xc(%ebp)
      59:	e8 7d 03 00 00       	call   3db <strlen>
      5e:	83 c4 10             	add    $0x10,%esp
      61:	83 ec 04             	sub    $0x4,%esp
      64:	50                   	push   %eax
      65:	ff 75 f4             	pushl  -0xc(%ebp)
      68:	68 98 1a 00 00       	push   $0x1a98
      6d:	e8 16 05 00 00       	call   588 <memmove>
      72:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      75:	83 ec 0c             	sub    $0xc,%esp
      78:	ff 75 f4             	pushl  -0xc(%ebp)
      7b:	e8 5b 03 00 00       	call   3db <strlen>
      80:	83 c4 10             	add    $0x10,%esp
      83:	ba 0e 00 00 00       	mov    $0xe,%edx
      88:	89 d3                	mov    %edx,%ebx
      8a:	29 c3                	sub    %eax,%ebx
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	ff 75 f4             	pushl  -0xc(%ebp)
      92:	e8 44 03 00 00       	call   3db <strlen>
      97:	83 c4 10             	add    $0x10,%esp
      9a:	05 98 1a 00 00       	add    $0x1a98,%eax
      9f:	83 ec 04             	sub    $0x4,%esp
      a2:	53                   	push   %ebx
      a3:	6a 20                	push   $0x20
      a5:	50                   	push   %eax
      a6:	e8 87 03 00 00       	call   432 <memset>
      ab:	83 c4 10             	add    $0x10,%esp
  return buf;
      ae:	b8 98 1a 00 00       	mov    $0x1a98,%eax
}
      b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      b6:	c9                   	leave  
      b7:	c3                   	ret    

000000b8 <ls>:

void
ls(char *path)
{
      b8:	55                   	push   %ebp
      b9:	89 e5                	mov    %esp,%ebp
      bb:	57                   	push   %edi
      bc:	56                   	push   %esi
      bd:	53                   	push   %ebx
      be:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
      c4:	83 ec 08             	sub    $0x8,%esp
      c7:	6a 00                	push   $0x0
      c9:	ff 75 08             	pushl  0x8(%ebp)
      cc:	e8 3c 05 00 00       	call   60d <open>
      d1:	83 c4 10             	add    $0x10,%esp
      d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
      db:	79 1a                	jns    f7 <ls+0x3f>
    printf(2, "ls: cannot open %s\n", path);
      dd:	83 ec 04             	sub    $0x4,%esp
      e0:	ff 75 08             	pushl  0x8(%ebp)
      e3:	68 40 13 00 00       	push   $0x1340
      e8:	6a 02                	push   $0x2
      ea:	e8 71 06 00 00       	call   760 <printf>
      ef:	83 c4 10             	add    $0x10,%esp
    return;
      f2:	e9 e3 01 00 00       	jmp    2da <ls+0x222>
  }

  if(fstat(fd, &st) < 0){
      f7:	83 ec 08             	sub    $0x8,%esp
      fa:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
     100:	50                   	push   %eax
     101:	ff 75 e4             	pushl  -0x1c(%ebp)
     104:	e8 1c 05 00 00       	call   625 <fstat>
     109:	83 c4 10             	add    $0x10,%esp
     10c:	85 c0                	test   %eax,%eax
     10e:	79 28                	jns    138 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
     110:	83 ec 04             	sub    $0x4,%esp
     113:	ff 75 08             	pushl  0x8(%ebp)
     116:	68 54 13 00 00       	push   $0x1354
     11b:	6a 02                	push   $0x2
     11d:	e8 3e 06 00 00       	call   760 <printf>
     122:	83 c4 10             	add    $0x10,%esp
    close(fd);
     125:	83 ec 0c             	sub    $0xc,%esp
     128:	ff 75 e4             	pushl  -0x1c(%ebp)
     12b:	e8 c5 04 00 00       	call   5f5 <close>
     130:	83 c4 10             	add    $0x10,%esp
    return;
     133:	e9 a2 01 00 00       	jmp    2da <ls+0x222>
  }

  switch(st.type){
     138:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     13f:	98                   	cwtl   
     140:	83 f8 01             	cmp    $0x1,%eax
     143:	74 48                	je     18d <ls+0xd5>
     145:	83 f8 02             	cmp    $0x2,%eax
     148:	0f 85 7e 01 00 00    	jne    2cc <ls+0x214>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
     14e:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
     154:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     15a:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     161:	0f bf d8             	movswl %ax,%ebx
     164:	83 ec 0c             	sub    $0xc,%esp
     167:	ff 75 08             	pushl  0x8(%ebp)
     16a:	e8 91 fe ff ff       	call   0 <fmtname>
     16f:	83 c4 10             	add    $0x10,%esp
     172:	83 ec 08             	sub    $0x8,%esp
     175:	57                   	push   %edi
     176:	56                   	push   %esi
     177:	53                   	push   %ebx
     178:	50                   	push   %eax
     179:	68 68 13 00 00       	push   $0x1368
     17e:	6a 01                	push   $0x1
     180:	e8 db 05 00 00       	call   760 <printf>
     185:	83 c4 20             	add    $0x20,%esp
    break;
     188:	e9 3f 01 00 00       	jmp    2cc <ls+0x214>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     18d:	83 ec 0c             	sub    $0xc,%esp
     190:	ff 75 08             	pushl  0x8(%ebp)
     193:	e8 43 02 00 00       	call   3db <strlen>
     198:	83 c4 10             	add    $0x10,%esp
     19b:	83 c0 10             	add    $0x10,%eax
     19e:	3d 00 02 00 00       	cmp    $0x200,%eax
     1a3:	76 17                	jbe    1bc <ls+0x104>
      printf(1, "ls: path too long\n");
     1a5:	83 ec 08             	sub    $0x8,%esp
     1a8:	68 75 13 00 00       	push   $0x1375
     1ad:	6a 01                	push   $0x1
     1af:	e8 ac 05 00 00       	call   760 <printf>
     1b4:	83 c4 10             	add    $0x10,%esp
      break;
     1b7:	e9 10 01 00 00       	jmp    2cc <ls+0x214>
    }
    strcpy(buf, path);
     1bc:	83 ec 08             	sub    $0x8,%esp
     1bf:	ff 75 08             	pushl  0x8(%ebp)
     1c2:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1c8:	50                   	push   %eax
     1c9:	e8 9e 01 00 00       	call   36c <strcpy>
     1ce:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
     1d1:	83 ec 0c             	sub    $0xc,%esp
     1d4:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1da:	50                   	push   %eax
     1db:	e8 fb 01 00 00       	call   3db <strlen>
     1e0:	83 c4 10             	add    $0x10,%esp
     1e3:	89 c2                	mov    %eax,%edx
     1e5:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     1eb:	01 d0                	add    %edx,%eax
     1ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
     1f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1f3:	8d 50 01             	lea    0x1(%eax),%edx
     1f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
     1f9:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     1fc:	e9 aa 00 00 00       	jmp    2ab <ls+0x1f3>
      if(de.inum == 0)
     201:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
     208:	66 85 c0             	test   %ax,%ax
     20b:	75 05                	jne    212 <ls+0x15a>
        continue;
     20d:	e9 99 00 00 00       	jmp    2ab <ls+0x1f3>
      memmove(p, de.name, DIRSIZ);
     212:	83 ec 04             	sub    $0x4,%esp
     215:	6a 0e                	push   $0xe
     217:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     21d:	83 c0 02             	add    $0x2,%eax
     220:	50                   	push   %eax
     221:	ff 75 e0             	pushl  -0x20(%ebp)
     224:	e8 5f 03 00 00       	call   588 <memmove>
     229:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
     22c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     22f:	83 c0 0e             	add    $0xe,%eax
     232:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
     235:	83 ec 08             	sub    $0x8,%esp
     238:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
     23e:	50                   	push   %eax
     23f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     245:	50                   	push   %eax
     246:	e8 a3 02 00 00       	call   4ee <stat>
     24b:	83 c4 10             	add    $0x10,%esp
     24e:	85 c0                	test   %eax,%eax
     250:	79 1b                	jns    26d <ls+0x1b5>
        printf(1, "ls: cannot stat %s\n", buf);
     252:	83 ec 04             	sub    $0x4,%esp
     255:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     25b:	50                   	push   %eax
     25c:	68 54 13 00 00       	push   $0x1354
     261:	6a 01                	push   $0x1
     263:	e8 f8 04 00 00       	call   760 <printf>
     268:	83 c4 10             	add    $0x10,%esp
        continue;
     26b:	eb 3e                	jmp    2ab <ls+0x1f3>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     26d:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
     273:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     279:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
     280:	0f bf d8             	movswl %ax,%ebx
     283:	83 ec 0c             	sub    $0xc,%esp
     286:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     28c:	50                   	push   %eax
     28d:	e8 6e fd ff ff       	call   0 <fmtname>
     292:	83 c4 10             	add    $0x10,%esp
     295:	83 ec 08             	sub    $0x8,%esp
     298:	57                   	push   %edi
     299:	56                   	push   %esi
     29a:	53                   	push   %ebx
     29b:	50                   	push   %eax
     29c:	68 68 13 00 00       	push   $0x1368
     2a1:	6a 01                	push   $0x1
     2a3:	e8 b8 04 00 00       	call   760 <printf>
     2a8:	83 c4 20             	add    $0x20,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2ab:	83 ec 04             	sub    $0x4,%esp
     2ae:	6a 10                	push   $0x10
     2b0:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     2b6:	50                   	push   %eax
     2b7:	ff 75 e4             	pushl  -0x1c(%ebp)
     2ba:	e8 26 03 00 00       	call   5e5 <read>
     2bf:	83 c4 10             	add    $0x10,%esp
     2c2:	83 f8 10             	cmp    $0x10,%eax
     2c5:	0f 84 36 ff ff ff    	je     201 <ls+0x149>
    }
    break;
     2cb:	90                   	nop
  }
  close(fd);
     2cc:	83 ec 0c             	sub    $0xc,%esp
     2cf:	ff 75 e4             	pushl  -0x1c(%ebp)
     2d2:	e8 1e 03 00 00       	call   5f5 <close>
     2d7:	83 c4 10             	add    $0x10,%esp
}
     2da:	8d 65 f4             	lea    -0xc(%ebp),%esp
     2dd:	5b                   	pop    %ebx
     2de:	5e                   	pop    %esi
     2df:	5f                   	pop    %edi
     2e0:	5d                   	pop    %ebp
     2e1:	c3                   	ret    

000002e2 <main>:

int
main(int argc, char *argv[])
{
     2e2:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2e6:	83 e4 f0             	and    $0xfffffff0,%esp
     2e9:	ff 71 fc             	pushl  -0x4(%ecx)
     2ec:	55                   	push   %ebp
     2ed:	89 e5                	mov    %esp,%ebp
     2ef:	53                   	push   %ebx
     2f0:	51                   	push   %ecx
     2f1:	83 ec 10             	sub    $0x10,%esp
     2f4:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
     2f6:	83 3b 01             	cmpl   $0x1,(%ebx)
     2f9:	7f 15                	jg     310 <main+0x2e>
    ls(".");
     2fb:	83 ec 0c             	sub    $0xc,%esp
     2fe:	68 88 13 00 00       	push   $0x1388
     303:	e8 b0 fd ff ff       	call   b8 <ls>
     308:	83 c4 10             	add    $0x10,%esp
    exit();
     30b:	e8 bd 02 00 00       	call   5cd <exit>
  }
  for(i=1; i<argc; i++)
     310:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     317:	eb 21                	jmp    33a <main+0x58>
    ls(argv[i]);
     319:	8b 45 f4             	mov    -0xc(%ebp),%eax
     31c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     323:	8b 43 04             	mov    0x4(%ebx),%eax
     326:	01 d0                	add    %edx,%eax
     328:	8b 00                	mov    (%eax),%eax
     32a:	83 ec 0c             	sub    $0xc,%esp
     32d:	50                   	push   %eax
     32e:	e8 85 fd ff ff       	call   b8 <ls>
     333:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
     336:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     33a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     33d:	3b 03                	cmp    (%ebx),%eax
     33f:	7c d8                	jl     319 <main+0x37>
  exit();
     341:	e8 87 02 00 00       	call   5cd <exit>

00000346 <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
     346:	55                   	push   %ebp
     347:	89 e5                	mov    %esp,%ebp
     349:	57                   	push   %edi
     34a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     34b:	8b 4d 08             	mov    0x8(%ebp),%ecx
     34e:	8b 55 10             	mov    0x10(%ebp),%edx
     351:	8b 45 0c             	mov    0xc(%ebp),%eax
     354:	89 cb                	mov    %ecx,%ebx
     356:	89 df                	mov    %ebx,%edi
     358:	89 d1                	mov    %edx,%ecx
     35a:	fc                   	cld    
     35b:	f3 aa                	rep stos %al,%es:(%edi)
     35d:	89 ca                	mov    %ecx,%edx
     35f:	89 fb                	mov    %edi,%ebx
     361:	89 5d 08             	mov    %ebx,0x8(%ebp)
     364:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     367:	90                   	nop
     368:	5b                   	pop    %ebx
     369:	5f                   	pop    %edi
     36a:	5d                   	pop    %ebp
     36b:	c3                   	ret    

0000036c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     36c:	55                   	push   %ebp
     36d:	89 e5                	mov    %esp,%ebp
     36f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     372:	8b 45 08             	mov    0x8(%ebp),%eax
     375:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     378:	90                   	nop
     379:	8b 55 0c             	mov    0xc(%ebp),%edx
     37c:	8d 42 01             	lea    0x1(%edx),%eax
     37f:	89 45 0c             	mov    %eax,0xc(%ebp)
     382:	8b 45 08             	mov    0x8(%ebp),%eax
     385:	8d 48 01             	lea    0x1(%eax),%ecx
     388:	89 4d 08             	mov    %ecx,0x8(%ebp)
     38b:	0f b6 12             	movzbl (%edx),%edx
     38e:	88 10                	mov    %dl,(%eax)
     390:	0f b6 00             	movzbl (%eax),%eax
     393:	84 c0                	test   %al,%al
     395:	75 e2                	jne    379 <strcpy+0xd>
    ;
  return os;
     397:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     39a:	c9                   	leave  
     39b:	c3                   	ret    

0000039c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     39c:	55                   	push   %ebp
     39d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     39f:	eb 08                	jmp    3a9 <strcmp+0xd>
    p++, q++;
     3a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3a5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     3a9:	8b 45 08             	mov    0x8(%ebp),%eax
     3ac:	0f b6 00             	movzbl (%eax),%eax
     3af:	84 c0                	test   %al,%al
     3b1:	74 10                	je     3c3 <strcmp+0x27>
     3b3:	8b 45 08             	mov    0x8(%ebp),%eax
     3b6:	0f b6 10             	movzbl (%eax),%edx
     3b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3bc:	0f b6 00             	movzbl (%eax),%eax
     3bf:	38 c2                	cmp    %al,%dl
     3c1:	74 de                	je     3a1 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     3c3:	8b 45 08             	mov    0x8(%ebp),%eax
     3c6:	0f b6 00             	movzbl (%eax),%eax
     3c9:	0f b6 d0             	movzbl %al,%edx
     3cc:	8b 45 0c             	mov    0xc(%ebp),%eax
     3cf:	0f b6 00             	movzbl (%eax),%eax
     3d2:	0f b6 c0             	movzbl %al,%eax
     3d5:	29 c2                	sub    %eax,%edx
     3d7:	89 d0                	mov    %edx,%eax
}
     3d9:	5d                   	pop    %ebp
     3da:	c3                   	ret    

000003db <strlen>:

uint
strlen(char *s)
{
     3db:	55                   	push   %ebp
     3dc:	89 e5                	mov    %esp,%ebp
     3de:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     3e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     3e8:	eb 04                	jmp    3ee <strlen+0x13>
     3ea:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     3ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3f1:	8b 45 08             	mov    0x8(%ebp),%eax
     3f4:	01 d0                	add    %edx,%eax
     3f6:	0f b6 00             	movzbl (%eax),%eax
     3f9:	84 c0                	test   %al,%al
     3fb:	75 ed                	jne    3ea <strlen+0xf>
    ;
  return n;
     3fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     400:	c9                   	leave  
     401:	c3                   	ret    

00000402 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     402:	55                   	push   %ebp
     403:	89 e5                	mov    %esp,%ebp
     405:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     408:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     40f:	eb 0c                	jmp    41d <strnlen+0x1b>
     n++; 
     411:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     415:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     419:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     41d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     421:	74 0a                	je     42d <strnlen+0x2b>
     423:	8b 45 08             	mov    0x8(%ebp),%eax
     426:	0f b6 00             	movzbl (%eax),%eax
     429:	84 c0                	test   %al,%al
     42b:	75 e4                	jne    411 <strnlen+0xf>
   return n; 
     42d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     430:	c9                   	leave  
     431:	c3                   	ret    

00000432 <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     432:	55                   	push   %ebp
     433:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     435:	8b 45 10             	mov    0x10(%ebp),%eax
     438:	50                   	push   %eax
     439:	ff 75 0c             	pushl  0xc(%ebp)
     43c:	ff 75 08             	pushl  0x8(%ebp)
     43f:	e8 02 ff ff ff       	call   346 <stosb>
     444:	83 c4 0c             	add    $0xc,%esp
  return dst;
     447:	8b 45 08             	mov    0x8(%ebp),%eax
}
     44a:	c9                   	leave  
     44b:	c3                   	ret    

0000044c <strchr>:

char*
strchr(const char *s, char c)
{
     44c:	55                   	push   %ebp
     44d:	89 e5                	mov    %esp,%ebp
     44f:	83 ec 04             	sub    $0x4,%esp
     452:	8b 45 0c             	mov    0xc(%ebp),%eax
     455:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     458:	eb 14                	jmp    46e <strchr+0x22>
    if(*s == c)
     45a:	8b 45 08             	mov    0x8(%ebp),%eax
     45d:	0f b6 00             	movzbl (%eax),%eax
     460:	38 45 fc             	cmp    %al,-0x4(%ebp)
     463:	75 05                	jne    46a <strchr+0x1e>
      return (char*)s;
     465:	8b 45 08             	mov    0x8(%ebp),%eax
     468:	eb 13                	jmp    47d <strchr+0x31>
  for(; *s; s++)
     46a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     46e:	8b 45 08             	mov    0x8(%ebp),%eax
     471:	0f b6 00             	movzbl (%eax),%eax
     474:	84 c0                	test   %al,%al
     476:	75 e2                	jne    45a <strchr+0xe>
  return 0;
     478:	b8 00 00 00 00       	mov    $0x0,%eax
}
     47d:	c9                   	leave  
     47e:	c3                   	ret    

0000047f <gets>:

char*
gets(char *buf, int max)
{
     47f:	55                   	push   %ebp
     480:	89 e5                	mov    %esp,%ebp
     482:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     485:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     48c:	eb 42                	jmp    4d0 <gets+0x51>
    cc = read(0, &c, 1);
     48e:	83 ec 04             	sub    $0x4,%esp
     491:	6a 01                	push   $0x1
     493:	8d 45 ef             	lea    -0x11(%ebp),%eax
     496:	50                   	push   %eax
     497:	6a 00                	push   $0x0
     499:	e8 47 01 00 00       	call   5e5 <read>
     49e:	83 c4 10             	add    $0x10,%esp
     4a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     4a4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4a8:	7e 33                	jle    4dd <gets+0x5e>
      break;
    buf[i++] = c;
     4aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4ad:	8d 50 01             	lea    0x1(%eax),%edx
     4b0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4b3:	89 c2                	mov    %eax,%edx
     4b5:	8b 45 08             	mov    0x8(%ebp),%eax
     4b8:	01 c2                	add    %eax,%edx
     4ba:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4be:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     4c0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4c4:	3c 0a                	cmp    $0xa,%al
     4c6:	74 16                	je     4de <gets+0x5f>
     4c8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4cc:	3c 0d                	cmp    $0xd,%al
     4ce:	74 0e                	je     4de <gets+0x5f>
  for(i=0; i+1 < max; ){
     4d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4d3:	83 c0 01             	add    $0x1,%eax
     4d6:	39 45 0c             	cmp    %eax,0xc(%ebp)
     4d9:	7f b3                	jg     48e <gets+0xf>
     4db:	eb 01                	jmp    4de <gets+0x5f>
      break;
     4dd:	90                   	nop
      break;
  }
  buf[i] = '\0';
     4de:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4e1:	8b 45 08             	mov    0x8(%ebp),%eax
     4e4:	01 d0                	add    %edx,%eax
     4e6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     4e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4ec:	c9                   	leave  
     4ed:	c3                   	ret    

000004ee <stat>:

int
stat(char *n, struct stat *st)
{
     4ee:	55                   	push   %ebp
     4ef:	89 e5                	mov    %esp,%ebp
     4f1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     4f4:	83 ec 08             	sub    $0x8,%esp
     4f7:	6a 00                	push   $0x0
     4f9:	ff 75 08             	pushl  0x8(%ebp)
     4fc:	e8 0c 01 00 00       	call   60d <open>
     501:	83 c4 10             	add    $0x10,%esp
     504:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     507:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     50b:	79 07                	jns    514 <stat+0x26>
    return -1;
     50d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     512:	eb 25                	jmp    539 <stat+0x4b>
  r = fstat(fd, st);
     514:	83 ec 08             	sub    $0x8,%esp
     517:	ff 75 0c             	pushl  0xc(%ebp)
     51a:	ff 75 f4             	pushl  -0xc(%ebp)
     51d:	e8 03 01 00 00       	call   625 <fstat>
     522:	83 c4 10             	add    $0x10,%esp
     525:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     528:	83 ec 0c             	sub    $0xc,%esp
     52b:	ff 75 f4             	pushl  -0xc(%ebp)
     52e:	e8 c2 00 00 00       	call   5f5 <close>
     533:	83 c4 10             	add    $0x10,%esp
  return r;
     536:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     539:	c9                   	leave  
     53a:	c3                   	ret    

0000053b <atoi>:

int
atoi(const char *s)
{
     53b:	55                   	push   %ebp
     53c:	89 e5                	mov    %esp,%ebp
     53e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     541:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     548:	eb 25                	jmp    56f <atoi+0x34>
    n = n*10 + *s++ - '0';
     54a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     54d:	89 d0                	mov    %edx,%eax
     54f:	c1 e0 02             	shl    $0x2,%eax
     552:	01 d0                	add    %edx,%eax
     554:	01 c0                	add    %eax,%eax
     556:	89 c1                	mov    %eax,%ecx
     558:	8b 45 08             	mov    0x8(%ebp),%eax
     55b:	8d 50 01             	lea    0x1(%eax),%edx
     55e:	89 55 08             	mov    %edx,0x8(%ebp)
     561:	0f b6 00             	movzbl (%eax),%eax
     564:	0f be c0             	movsbl %al,%eax
     567:	01 c8                	add    %ecx,%eax
     569:	83 e8 30             	sub    $0x30,%eax
     56c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     56f:	8b 45 08             	mov    0x8(%ebp),%eax
     572:	0f b6 00             	movzbl (%eax),%eax
     575:	3c 2f                	cmp    $0x2f,%al
     577:	7e 0a                	jle    583 <atoi+0x48>
     579:	8b 45 08             	mov    0x8(%ebp),%eax
     57c:	0f b6 00             	movzbl (%eax),%eax
     57f:	3c 39                	cmp    $0x39,%al
     581:	7e c7                	jle    54a <atoi+0xf>
  return n;
     583:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     586:	c9                   	leave  
     587:	c3                   	ret    

00000588 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     588:	55                   	push   %ebp
     589:	89 e5                	mov    %esp,%ebp
     58b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     58e:	8b 45 08             	mov    0x8(%ebp),%eax
     591:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     594:	8b 45 0c             	mov    0xc(%ebp),%eax
     597:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     59a:	eb 17                	jmp    5b3 <memmove+0x2b>
    *dst++ = *src++;
     59c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     59f:	8d 42 01             	lea    0x1(%edx),%eax
     5a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
     5a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5a8:	8d 48 01             	lea    0x1(%eax),%ecx
     5ab:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     5ae:	0f b6 12             	movzbl (%edx),%edx
     5b1:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     5b3:	8b 45 10             	mov    0x10(%ebp),%eax
     5b6:	8d 50 ff             	lea    -0x1(%eax),%edx
     5b9:	89 55 10             	mov    %edx,0x10(%ebp)
     5bc:	85 c0                	test   %eax,%eax
     5be:	7f dc                	jg     59c <memmove+0x14>
  return vdst;
     5c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
     5c3:	c9                   	leave  
     5c4:	c3                   	ret    

000005c5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     5c5:	b8 01 00 00 00       	mov    $0x1,%eax
     5ca:	cd 40                	int    $0x40
     5cc:	c3                   	ret    

000005cd <exit>:
SYSCALL(exit)
     5cd:	b8 02 00 00 00       	mov    $0x2,%eax
     5d2:	cd 40                	int    $0x40
     5d4:	c3                   	ret    

000005d5 <wait>:
SYSCALL(wait)
     5d5:	b8 03 00 00 00       	mov    $0x3,%eax
     5da:	cd 40                	int    $0x40
     5dc:	c3                   	ret    

000005dd <pipe>:
SYSCALL(pipe)
     5dd:	b8 04 00 00 00       	mov    $0x4,%eax
     5e2:	cd 40                	int    $0x40
     5e4:	c3                   	ret    

000005e5 <read>:
SYSCALL(read)
     5e5:	b8 05 00 00 00       	mov    $0x5,%eax
     5ea:	cd 40                	int    $0x40
     5ec:	c3                   	ret    

000005ed <write>:
SYSCALL(write)
     5ed:	b8 10 00 00 00       	mov    $0x10,%eax
     5f2:	cd 40                	int    $0x40
     5f4:	c3                   	ret    

000005f5 <close>:
SYSCALL(close)
     5f5:	b8 15 00 00 00       	mov    $0x15,%eax
     5fa:	cd 40                	int    $0x40
     5fc:	c3                   	ret    

000005fd <kill>:
SYSCALL(kill)
     5fd:	b8 06 00 00 00       	mov    $0x6,%eax
     602:	cd 40                	int    $0x40
     604:	c3                   	ret    

00000605 <exec>:
SYSCALL(exec)
     605:	b8 07 00 00 00       	mov    $0x7,%eax
     60a:	cd 40                	int    $0x40
     60c:	c3                   	ret    

0000060d <open>:
SYSCALL(open)
     60d:	b8 0f 00 00 00       	mov    $0xf,%eax
     612:	cd 40                	int    $0x40
     614:	c3                   	ret    

00000615 <mknod>:
SYSCALL(mknod)
     615:	b8 11 00 00 00       	mov    $0x11,%eax
     61a:	cd 40                	int    $0x40
     61c:	c3                   	ret    

0000061d <unlink>:
SYSCALL(unlink)
     61d:	b8 12 00 00 00       	mov    $0x12,%eax
     622:	cd 40                	int    $0x40
     624:	c3                   	ret    

00000625 <fstat>:
SYSCALL(fstat)
     625:	b8 08 00 00 00       	mov    $0x8,%eax
     62a:	cd 40                	int    $0x40
     62c:	c3                   	ret    

0000062d <link>:
SYSCALL(link)
     62d:	b8 13 00 00 00       	mov    $0x13,%eax
     632:	cd 40                	int    $0x40
     634:	c3                   	ret    

00000635 <mkdir>:
SYSCALL(mkdir)
     635:	b8 14 00 00 00       	mov    $0x14,%eax
     63a:	cd 40                	int    $0x40
     63c:	c3                   	ret    

0000063d <chdir>:
SYSCALL(chdir)
     63d:	b8 09 00 00 00       	mov    $0x9,%eax
     642:	cd 40                	int    $0x40
     644:	c3                   	ret    

00000645 <dup>:
SYSCALL(dup)
     645:	b8 0a 00 00 00       	mov    $0xa,%eax
     64a:	cd 40                	int    $0x40
     64c:	c3                   	ret    

0000064d <getpid>:
SYSCALL(getpid)
     64d:	b8 0b 00 00 00       	mov    $0xb,%eax
     652:	cd 40                	int    $0x40
     654:	c3                   	ret    

00000655 <sbrk>:
SYSCALL(sbrk)
     655:	b8 0c 00 00 00       	mov    $0xc,%eax
     65a:	cd 40                	int    $0x40
     65c:	c3                   	ret    

0000065d <sleep>:
SYSCALL(sleep)
     65d:	b8 0d 00 00 00       	mov    $0xd,%eax
     662:	cd 40                	int    $0x40
     664:	c3                   	ret    

00000665 <uptime>:
SYSCALL(uptime)
     665:	b8 0e 00 00 00       	mov    $0xe,%eax
     66a:	cd 40                	int    $0x40
     66c:	c3                   	ret    

0000066d <select>:
SYSCALL(select)
     66d:	b8 16 00 00 00       	mov    $0x16,%eax
     672:	cd 40                	int    $0x40
     674:	c3                   	ret    

00000675 <arp>:
SYSCALL(arp)
     675:	b8 17 00 00 00       	mov    $0x17,%eax
     67a:	cd 40                	int    $0x40
     67c:	c3                   	ret    

0000067d <arpserv>:
SYSCALL(arpserv)
     67d:	b8 18 00 00 00       	mov    $0x18,%eax
     682:	cd 40                	int    $0x40
     684:	c3                   	ret    

00000685 <arp_receive>:
SYSCALL(arp_receive)
     685:	b8 19 00 00 00       	mov    $0x19,%eax
     68a:	cd 40                	int    $0x40
     68c:	c3                   	ret    

0000068d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     68d:	55                   	push   %ebp
     68e:	89 e5                	mov    %esp,%ebp
     690:	83 ec 18             	sub    $0x18,%esp
     693:	8b 45 0c             	mov    0xc(%ebp),%eax
     696:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     699:	83 ec 04             	sub    $0x4,%esp
     69c:	6a 01                	push   $0x1
     69e:	8d 45 f4             	lea    -0xc(%ebp),%eax
     6a1:	50                   	push   %eax
     6a2:	ff 75 08             	pushl  0x8(%ebp)
     6a5:	e8 43 ff ff ff       	call   5ed <write>
     6aa:	83 c4 10             	add    $0x10,%esp
}
     6ad:	90                   	nop
     6ae:	c9                   	leave  
     6af:	c3                   	ret    

000006b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     6bd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6c1:	74 17                	je     6da <printint+0x2a>
     6c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6c7:	79 11                	jns    6da <printint+0x2a>
    neg = 1;
     6c9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6d0:	8b 45 0c             	mov    0xc(%ebp),%eax
     6d3:	f7 d8                	neg    %eax
     6d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6d8:	eb 06                	jmp    6e0 <printint+0x30>
  } else {
    x = xx;
     6da:	8b 45 0c             	mov    0xc(%ebp),%eax
     6dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6ed:	ba 00 00 00 00       	mov    $0x0,%edx
     6f2:	f7 f1                	div    %ecx
     6f4:	89 d1                	mov    %edx,%ecx
     6f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f9:	8d 50 01             	lea    0x1(%eax),%edx
     6fc:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6ff:	0f b6 91 84 1a 00 00 	movzbl 0x1a84(%ecx),%edx
     706:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     70a:	8b 4d 10             	mov    0x10(%ebp),%ecx
     70d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     710:	ba 00 00 00 00       	mov    $0x0,%edx
     715:	f7 f1                	div    %ecx
     717:	89 45 ec             	mov    %eax,-0x14(%ebp)
     71a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     71e:	75 c7                	jne    6e7 <printint+0x37>
  if(neg)
     720:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     724:	74 2d                	je     753 <printint+0xa3>
    buf[i++] = '-';
     726:	8b 45 f4             	mov    -0xc(%ebp),%eax
     729:	8d 50 01             	lea    0x1(%eax),%edx
     72c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     72f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     734:	eb 1d                	jmp    753 <printint+0xa3>
    putc(fd, buf[i]);
     736:	8d 55 dc             	lea    -0x24(%ebp),%edx
     739:	8b 45 f4             	mov    -0xc(%ebp),%eax
     73c:	01 d0                	add    %edx,%eax
     73e:	0f b6 00             	movzbl (%eax),%eax
     741:	0f be c0             	movsbl %al,%eax
     744:	83 ec 08             	sub    $0x8,%esp
     747:	50                   	push   %eax
     748:	ff 75 08             	pushl  0x8(%ebp)
     74b:	e8 3d ff ff ff       	call   68d <putc>
     750:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     753:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     757:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     75b:	79 d9                	jns    736 <printint+0x86>
}
     75d:	90                   	nop
     75e:	c9                   	leave  
     75f:	c3                   	ret    

00000760 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     760:	55                   	push   %ebp
     761:	89 e5                	mov    %esp,%ebp
     763:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     766:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     76d:	8d 45 0c             	lea    0xc(%ebp),%eax
     770:	83 c0 04             	add    $0x4,%eax
     773:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     776:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     77d:	e9 59 01 00 00       	jmp    8db <printf+0x17b>
    c = fmt[i] & 0xff;
     782:	8b 55 0c             	mov    0xc(%ebp),%edx
     785:	8b 45 f0             	mov    -0x10(%ebp),%eax
     788:	01 d0                	add    %edx,%eax
     78a:	0f b6 00             	movzbl (%eax),%eax
     78d:	0f be c0             	movsbl %al,%eax
     790:	25 ff 00 00 00       	and    $0xff,%eax
     795:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     798:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     79c:	75 2c                	jne    7ca <printf+0x6a>
      if(c == '%'){
     79e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     7a2:	75 0c                	jne    7b0 <printf+0x50>
        state = '%';
     7a4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7ab:	e9 27 01 00 00       	jmp    8d7 <printf+0x177>
      } else {
        putc(fd, c);
     7b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7b3:	0f be c0             	movsbl %al,%eax
     7b6:	83 ec 08             	sub    $0x8,%esp
     7b9:	50                   	push   %eax
     7ba:	ff 75 08             	pushl  0x8(%ebp)
     7bd:	e8 cb fe ff ff       	call   68d <putc>
     7c2:	83 c4 10             	add    $0x10,%esp
     7c5:	e9 0d 01 00 00       	jmp    8d7 <printf+0x177>
      }
    } else if(state == '%'){
     7ca:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7ce:	0f 85 03 01 00 00    	jne    8d7 <printf+0x177>
      if(c == 'd'){
     7d4:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7d8:	75 1e                	jne    7f8 <printf+0x98>
        printint(fd, *ap, 10, 1);
     7da:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7dd:	8b 00                	mov    (%eax),%eax
     7df:	6a 01                	push   $0x1
     7e1:	6a 0a                	push   $0xa
     7e3:	50                   	push   %eax
     7e4:	ff 75 08             	pushl  0x8(%ebp)
     7e7:	e8 c4 fe ff ff       	call   6b0 <printint>
     7ec:	83 c4 10             	add    $0x10,%esp
        ap++;
     7ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7f3:	e9 d8 00 00 00       	jmp    8d0 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     7f8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7fc:	74 06                	je     804 <printf+0xa4>
     7fe:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     802:	75 1e                	jne    822 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     804:	8b 45 e8             	mov    -0x18(%ebp),%eax
     807:	8b 00                	mov    (%eax),%eax
     809:	6a 00                	push   $0x0
     80b:	6a 10                	push   $0x10
     80d:	50                   	push   %eax
     80e:	ff 75 08             	pushl  0x8(%ebp)
     811:	e8 9a fe ff ff       	call   6b0 <printint>
     816:	83 c4 10             	add    $0x10,%esp
        ap++;
     819:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     81d:	e9 ae 00 00 00       	jmp    8d0 <printf+0x170>
      } else if(c == 's'){
     822:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     826:	75 43                	jne    86b <printf+0x10b>
        s = (char*)*ap;
     828:	8b 45 e8             	mov    -0x18(%ebp),%eax
     82b:	8b 00                	mov    (%eax),%eax
     82d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     830:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     834:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     838:	75 25                	jne    85f <printf+0xff>
          s = "(null)";
     83a:	c7 45 f4 8a 13 00 00 	movl   $0x138a,-0xc(%ebp)
        while(*s != 0){
     841:	eb 1c                	jmp    85f <printf+0xff>
          putc(fd, *s);
     843:	8b 45 f4             	mov    -0xc(%ebp),%eax
     846:	0f b6 00             	movzbl (%eax),%eax
     849:	0f be c0             	movsbl %al,%eax
     84c:	83 ec 08             	sub    $0x8,%esp
     84f:	50                   	push   %eax
     850:	ff 75 08             	pushl  0x8(%ebp)
     853:	e8 35 fe ff ff       	call   68d <putc>
     858:	83 c4 10             	add    $0x10,%esp
          s++;
     85b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     85f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     862:	0f b6 00             	movzbl (%eax),%eax
     865:	84 c0                	test   %al,%al
     867:	75 da                	jne    843 <printf+0xe3>
     869:	eb 65                	jmp    8d0 <printf+0x170>
        }
      } else if(c == 'c'){
     86b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     86f:	75 1d                	jne    88e <printf+0x12e>
        putc(fd, *ap);
     871:	8b 45 e8             	mov    -0x18(%ebp),%eax
     874:	8b 00                	mov    (%eax),%eax
     876:	0f be c0             	movsbl %al,%eax
     879:	83 ec 08             	sub    $0x8,%esp
     87c:	50                   	push   %eax
     87d:	ff 75 08             	pushl  0x8(%ebp)
     880:	e8 08 fe ff ff       	call   68d <putc>
     885:	83 c4 10             	add    $0x10,%esp
        ap++;
     888:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     88c:	eb 42                	jmp    8d0 <printf+0x170>
      } else if(c == '%'){
     88e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     892:	75 17                	jne    8ab <printf+0x14b>
        putc(fd, c);
     894:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     897:	0f be c0             	movsbl %al,%eax
     89a:	83 ec 08             	sub    $0x8,%esp
     89d:	50                   	push   %eax
     89e:	ff 75 08             	pushl  0x8(%ebp)
     8a1:	e8 e7 fd ff ff       	call   68d <putc>
     8a6:	83 c4 10             	add    $0x10,%esp
     8a9:	eb 25                	jmp    8d0 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     8ab:	83 ec 08             	sub    $0x8,%esp
     8ae:	6a 25                	push   $0x25
     8b0:	ff 75 08             	pushl  0x8(%ebp)
     8b3:	e8 d5 fd ff ff       	call   68d <putc>
     8b8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     8bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8be:	0f be c0             	movsbl %al,%eax
     8c1:	83 ec 08             	sub    $0x8,%esp
     8c4:	50                   	push   %eax
     8c5:	ff 75 08             	pushl  0x8(%ebp)
     8c8:	e8 c0 fd ff ff       	call   68d <putc>
     8cd:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8d0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     8d7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8db:	8b 55 0c             	mov    0xc(%ebp),%edx
     8de:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8e1:	01 d0                	add    %edx,%eax
     8e3:	0f b6 00             	movzbl (%eax),%eax
     8e6:	84 c0                	test   %al,%al
     8e8:	0f 85 94 fe ff ff    	jne    782 <printf+0x22>
    }
  }
}
     8ee:	90                   	nop
     8ef:	c9                   	leave  
     8f0:	c3                   	ret    

000008f1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8f1:	55                   	push   %ebp
     8f2:	89 e5                	mov    %esp,%ebp
     8f4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8f7:	8b 45 08             	mov    0x8(%ebp),%eax
     8fa:	83 e8 08             	sub    $0x8,%eax
     8fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     900:	a1 b0 1a 00 00       	mov    0x1ab0,%eax
     905:	89 45 fc             	mov    %eax,-0x4(%ebp)
     908:	eb 24                	jmp    92e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     90a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     90d:	8b 00                	mov    (%eax),%eax
     90f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     912:	72 12                	jb     926 <free+0x35>
     914:	8b 45 f8             	mov    -0x8(%ebp),%eax
     917:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     91a:	77 24                	ja     940 <free+0x4f>
     91c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     91f:	8b 00                	mov    (%eax),%eax
     921:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     924:	72 1a                	jb     940 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     926:	8b 45 fc             	mov    -0x4(%ebp),%eax
     929:	8b 00                	mov    (%eax),%eax
     92b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     92e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     931:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     934:	76 d4                	jbe    90a <free+0x19>
     936:	8b 45 fc             	mov    -0x4(%ebp),%eax
     939:	8b 00                	mov    (%eax),%eax
     93b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     93e:	73 ca                	jae    90a <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     940:	8b 45 f8             	mov    -0x8(%ebp),%eax
     943:	8b 40 04             	mov    0x4(%eax),%eax
     946:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     94d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     950:	01 c2                	add    %eax,%edx
     952:	8b 45 fc             	mov    -0x4(%ebp),%eax
     955:	8b 00                	mov    (%eax),%eax
     957:	39 c2                	cmp    %eax,%edx
     959:	75 24                	jne    97f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     95b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     95e:	8b 50 04             	mov    0x4(%eax),%edx
     961:	8b 45 fc             	mov    -0x4(%ebp),%eax
     964:	8b 00                	mov    (%eax),%eax
     966:	8b 40 04             	mov    0x4(%eax),%eax
     969:	01 c2                	add    %eax,%edx
     96b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     96e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     971:	8b 45 fc             	mov    -0x4(%ebp),%eax
     974:	8b 00                	mov    (%eax),%eax
     976:	8b 10                	mov    (%eax),%edx
     978:	8b 45 f8             	mov    -0x8(%ebp),%eax
     97b:	89 10                	mov    %edx,(%eax)
     97d:	eb 0a                	jmp    989 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     97f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     982:	8b 10                	mov    (%eax),%edx
     984:	8b 45 f8             	mov    -0x8(%ebp),%eax
     987:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     989:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98c:	8b 40 04             	mov    0x4(%eax),%eax
     98f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     996:	8b 45 fc             	mov    -0x4(%ebp),%eax
     999:	01 d0                	add    %edx,%eax
     99b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     99e:	75 20                	jne    9c0 <free+0xcf>
    p->s.size += bp->s.size;
     9a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a3:	8b 50 04             	mov    0x4(%eax),%edx
     9a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a9:	8b 40 04             	mov    0x4(%eax),%eax
     9ac:	01 c2                	add    %eax,%edx
     9ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     9b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9b7:	8b 10                	mov    (%eax),%edx
     9b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9bc:	89 10                	mov    %edx,(%eax)
     9be:	eb 08                	jmp    9c8 <free+0xd7>
  } else
    p->s.ptr = bp;
     9c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9c3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9c6:	89 10                	mov    %edx,(%eax)
  freep = p;
     9c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9cb:	a3 b0 1a 00 00       	mov    %eax,0x1ab0
}
     9d0:	90                   	nop
     9d1:	c9                   	leave  
     9d2:	c3                   	ret    

000009d3 <morecore>:

static Header*
morecore(uint nu)
{
     9d3:	55                   	push   %ebp
     9d4:	89 e5                	mov    %esp,%ebp
     9d6:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9d9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9e0:	77 07                	ja     9e9 <morecore+0x16>
    nu = 4096;
     9e2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9e9:	8b 45 08             	mov    0x8(%ebp),%eax
     9ec:	c1 e0 03             	shl    $0x3,%eax
     9ef:	83 ec 0c             	sub    $0xc,%esp
     9f2:	50                   	push   %eax
     9f3:	e8 5d fc ff ff       	call   655 <sbrk>
     9f8:	83 c4 10             	add    $0x10,%esp
     9fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9fe:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a02:	75 07                	jne    a0b <morecore+0x38>
    return 0;
     a04:	b8 00 00 00 00       	mov    $0x0,%eax
     a09:	eb 26                	jmp    a31 <morecore+0x5e>
  hp = (Header*)p;
     a0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a11:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a14:	8b 55 08             	mov    0x8(%ebp),%edx
     a17:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a1d:	83 c0 08             	add    $0x8,%eax
     a20:	83 ec 0c             	sub    $0xc,%esp
     a23:	50                   	push   %eax
     a24:	e8 c8 fe ff ff       	call   8f1 <free>
     a29:	83 c4 10             	add    $0x10,%esp
  return freep;
     a2c:	a1 b0 1a 00 00       	mov    0x1ab0,%eax
}
     a31:	c9                   	leave  
     a32:	c3                   	ret    

00000a33 <malloc>:

void*
malloc(uint nbytes)
{
     a33:	55                   	push   %ebp
     a34:	89 e5                	mov    %esp,%ebp
     a36:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a39:	8b 45 08             	mov    0x8(%ebp),%eax
     a3c:	83 c0 07             	add    $0x7,%eax
     a3f:	c1 e8 03             	shr    $0x3,%eax
     a42:	83 c0 01             	add    $0x1,%eax
     a45:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a48:	a1 b0 1a 00 00       	mov    0x1ab0,%eax
     a4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a50:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a54:	75 23                	jne    a79 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     a56:	c7 45 f0 a8 1a 00 00 	movl   $0x1aa8,-0x10(%ebp)
     a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a60:	a3 b0 1a 00 00       	mov    %eax,0x1ab0
     a65:	a1 b0 1a 00 00       	mov    0x1ab0,%eax
     a6a:	a3 a8 1a 00 00       	mov    %eax,0x1aa8
    base.s.size = 0;
     a6f:	c7 05 ac 1a 00 00 00 	movl   $0x0,0x1aac
     a76:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a79:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a7c:	8b 00                	mov    (%eax),%eax
     a7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a84:	8b 40 04             	mov    0x4(%eax),%eax
     a87:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a8a:	77 4d                	ja     ad9 <malloc+0xa6>
      if(p->s.size == nunits)
     a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8f:	8b 40 04             	mov    0x4(%eax),%eax
     a92:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a95:	75 0c                	jne    aa3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     a97:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9a:	8b 10                	mov    (%eax),%edx
     a9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a9f:	89 10                	mov    %edx,(%eax)
     aa1:	eb 26                	jmp    ac9 <malloc+0x96>
      else {
        p->s.size -= nunits;
     aa3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa6:	8b 40 04             	mov    0x4(%eax),%eax
     aa9:	2b 45 ec             	sub    -0x14(%ebp),%eax
     aac:	89 c2                	mov    %eax,%edx
     aae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab7:	8b 40 04             	mov    0x4(%eax),%eax
     aba:	c1 e0 03             	shl    $0x3,%eax
     abd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac3:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ac6:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     ac9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     acc:	a3 b0 1a 00 00       	mov    %eax,0x1ab0
      return (void*)(p + 1);
     ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad4:	83 c0 08             	add    $0x8,%eax
     ad7:	eb 3b                	jmp    b14 <malloc+0xe1>
    }
    if(p == freep)
     ad9:	a1 b0 1a 00 00       	mov    0x1ab0,%eax
     ade:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ae1:	75 1e                	jne    b01 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     ae3:	83 ec 0c             	sub    $0xc,%esp
     ae6:	ff 75 ec             	pushl  -0x14(%ebp)
     ae9:	e8 e5 fe ff ff       	call   9d3 <morecore>
     aee:	83 c4 10             	add    $0x10,%esp
     af1:	89 45 f4             	mov    %eax,-0xc(%ebp)
     af4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     af8:	75 07                	jne    b01 <malloc+0xce>
        return 0;
     afa:	b8 00 00 00 00       	mov    $0x0,%eax
     aff:	eb 13                	jmp    b14 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     b01:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b04:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b07:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0a:	8b 00                	mov    (%eax),%eax
     b0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     b0f:	e9 6d ff ff ff       	jmp    a81 <malloc+0x4e>
  }
}
     b14:	c9                   	leave  
     b15:	c3                   	ret    

00000b16 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     b16:	55                   	push   %ebp
     b17:	89 e5                	mov    %esp,%ebp
     b19:	53                   	push   %ebx
     b1a:	83 ec 14             	sub    $0x14,%esp
     b1d:	8b 45 10             	mov    0x10(%ebp),%eax
     b20:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b23:	8b 45 14             	mov    0x14(%ebp),%eax
     b26:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     b29:	8b 45 18             	mov    0x18(%ebp),%eax
     b2c:	ba 00 00 00 00       	mov    $0x0,%edx
     b31:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     b34:	72 55                	jb     b8b <printnum+0x75>
     b36:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     b39:	77 05                	ja     b40 <printnum+0x2a>
     b3b:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     b3e:	72 4b                	jb     b8b <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     b40:	8b 45 1c             	mov    0x1c(%ebp),%eax
     b43:	8d 58 ff             	lea    -0x1(%eax),%ebx
     b46:	8b 45 18             	mov    0x18(%ebp),%eax
     b49:	ba 00 00 00 00       	mov    $0x0,%edx
     b4e:	52                   	push   %edx
     b4f:	50                   	push   %eax
     b50:	ff 75 f4             	pushl  -0xc(%ebp)
     b53:	ff 75 f0             	pushl  -0x10(%ebp)
     b56:	e8 a5 05 00 00       	call   1100 <__udivdi3>
     b5b:	83 c4 10             	add    $0x10,%esp
     b5e:	83 ec 04             	sub    $0x4,%esp
     b61:	ff 75 20             	pushl  0x20(%ebp)
     b64:	53                   	push   %ebx
     b65:	ff 75 18             	pushl  0x18(%ebp)
     b68:	52                   	push   %edx
     b69:	50                   	push   %eax
     b6a:	ff 75 0c             	pushl  0xc(%ebp)
     b6d:	ff 75 08             	pushl  0x8(%ebp)
     b70:	e8 a1 ff ff ff       	call   b16 <printnum>
     b75:	83 c4 20             	add    $0x20,%esp
     b78:	eb 1b                	jmp    b95 <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     b7a:	83 ec 08             	sub    $0x8,%esp
     b7d:	ff 75 0c             	pushl  0xc(%ebp)
     b80:	ff 75 20             	pushl  0x20(%ebp)
     b83:	8b 45 08             	mov    0x8(%ebp),%eax
     b86:	ff d0                	call   *%eax
     b88:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     b8b:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     b8f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     b93:	7f e5                	jg     b7a <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     b95:	8b 4d 18             	mov    0x18(%ebp),%ecx
     b98:	bb 00 00 00 00       	mov    $0x0,%ebx
     b9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ba0:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ba3:	53                   	push   %ebx
     ba4:	51                   	push   %ecx
     ba5:	52                   	push   %edx
     ba6:	50                   	push   %eax
     ba7:	e8 74 06 00 00       	call   1220 <__umoddi3>
     bac:	83 c4 10             	add    $0x10,%esp
     baf:	05 60 14 00 00       	add    $0x1460,%eax
     bb4:	0f b6 00             	movzbl (%eax),%eax
     bb7:	0f be c0             	movsbl %al,%eax
     bba:	83 ec 08             	sub    $0x8,%esp
     bbd:	ff 75 0c             	pushl  0xc(%ebp)
     bc0:	50                   	push   %eax
     bc1:	8b 45 08             	mov    0x8(%ebp),%eax
     bc4:	ff d0                	call   *%eax
     bc6:	83 c4 10             	add    $0x10,%esp
}
     bc9:	90                   	nop
     bca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bcd:	c9                   	leave  
     bce:	c3                   	ret    

00000bcf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     bcf:	55                   	push   %ebp
     bd0:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     bd2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     bd6:	7e 14                	jle    bec <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     bd8:	8b 45 08             	mov    0x8(%ebp),%eax
     bdb:	8b 00                	mov    (%eax),%eax
     bdd:	8d 48 08             	lea    0x8(%eax),%ecx
     be0:	8b 55 08             	mov    0x8(%ebp),%edx
     be3:	89 0a                	mov    %ecx,(%edx)
     be5:	8b 50 04             	mov    0x4(%eax),%edx
     be8:	8b 00                	mov    (%eax),%eax
     bea:	eb 30                	jmp    c1c <getuint+0x4d>
  else if (lflag)
     bec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     bf0:	74 16                	je     c08 <getuint+0x39>
    return va_arg(*ap, unsigned long);
     bf2:	8b 45 08             	mov    0x8(%ebp),%eax
     bf5:	8b 00                	mov    (%eax),%eax
     bf7:	8d 48 04             	lea    0x4(%eax),%ecx
     bfa:	8b 55 08             	mov    0x8(%ebp),%edx
     bfd:	89 0a                	mov    %ecx,(%edx)
     bff:	8b 00                	mov    (%eax),%eax
     c01:	ba 00 00 00 00       	mov    $0x0,%edx
     c06:	eb 14                	jmp    c1c <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     c08:	8b 45 08             	mov    0x8(%ebp),%eax
     c0b:	8b 00                	mov    (%eax),%eax
     c0d:	8d 48 04             	lea    0x4(%eax),%ecx
     c10:	8b 55 08             	mov    0x8(%ebp),%edx
     c13:	89 0a                	mov    %ecx,(%edx)
     c15:	8b 00                	mov    (%eax),%eax
     c17:	ba 00 00 00 00       	mov    $0x0,%edx
}
     c1c:	5d                   	pop    %ebp
     c1d:	c3                   	ret    

00000c1e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     c1e:	55                   	push   %ebp
     c1f:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     c21:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     c25:	7e 14                	jle    c3b <getint+0x1d>
    return va_arg(*ap, long long);
     c27:	8b 45 08             	mov    0x8(%ebp),%eax
     c2a:	8b 00                	mov    (%eax),%eax
     c2c:	8d 48 08             	lea    0x8(%eax),%ecx
     c2f:	8b 55 08             	mov    0x8(%ebp),%edx
     c32:	89 0a                	mov    %ecx,(%edx)
     c34:	8b 50 04             	mov    0x4(%eax),%edx
     c37:	8b 00                	mov    (%eax),%eax
     c39:	eb 28                	jmp    c63 <getint+0x45>
  else if (lflag)
     c3b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     c3f:	74 12                	je     c53 <getint+0x35>
    return va_arg(*ap, long);
     c41:	8b 45 08             	mov    0x8(%ebp),%eax
     c44:	8b 00                	mov    (%eax),%eax
     c46:	8d 48 04             	lea    0x4(%eax),%ecx
     c49:	8b 55 08             	mov    0x8(%ebp),%edx
     c4c:	89 0a                	mov    %ecx,(%edx)
     c4e:	8b 00                	mov    (%eax),%eax
     c50:	99                   	cltd   
     c51:	eb 10                	jmp    c63 <getint+0x45>
  else
    return va_arg(*ap, int);
     c53:	8b 45 08             	mov    0x8(%ebp),%eax
     c56:	8b 00                	mov    (%eax),%eax
     c58:	8d 48 04             	lea    0x4(%eax),%ecx
     c5b:	8b 55 08             	mov    0x8(%ebp),%edx
     c5e:	89 0a                	mov    %ecx,(%edx)
     c60:	8b 00                	mov    (%eax),%eax
     c62:	99                   	cltd   
}
     c63:	5d                   	pop    %ebp
     c64:	c3                   	ret    

00000c65 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     c65:	55                   	push   %ebp
     c66:	89 e5                	mov    %esp,%ebp
     c68:	56                   	push   %esi
     c69:	53                   	push   %ebx
     c6a:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     c6d:	eb 17                	jmp    c86 <vprintfmt+0x21>
      if (ch == '\0')
     c6f:	85 db                	test   %ebx,%ebx
     c71:	0f 84 a0 03 00 00    	je     1017 <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     c77:	83 ec 08             	sub    $0x8,%esp
     c7a:	ff 75 0c             	pushl  0xc(%ebp)
     c7d:	53                   	push   %ebx
     c7e:	8b 45 08             	mov    0x8(%ebp),%eax
     c81:	ff d0                	call   *%eax
     c83:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     c86:	8b 45 10             	mov    0x10(%ebp),%eax
     c89:	8d 50 01             	lea    0x1(%eax),%edx
     c8c:	89 55 10             	mov    %edx,0x10(%ebp)
     c8f:	0f b6 00             	movzbl (%eax),%eax
     c92:	0f b6 d8             	movzbl %al,%ebx
     c95:	83 fb 25             	cmp    $0x25,%ebx
     c98:	75 d5                	jne    c6f <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     c9a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     c9e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     ca5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     cac:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     cb3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     cba:	8b 45 10             	mov    0x10(%ebp),%eax
     cbd:	8d 50 01             	lea    0x1(%eax),%edx
     cc0:	89 55 10             	mov    %edx,0x10(%ebp)
     cc3:	0f b6 00             	movzbl (%eax),%eax
     cc6:	0f b6 d8             	movzbl %al,%ebx
     cc9:	8d 43 dd             	lea    -0x23(%ebx),%eax
     ccc:	83 f8 55             	cmp    $0x55,%eax
     ccf:	0f 87 15 03 00 00    	ja     fea <vprintfmt+0x385>
     cd5:	8b 04 85 84 14 00 00 	mov    0x1484(,%eax,4),%eax
     cdc:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     cde:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     ce2:	eb d6                	jmp    cba <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     ce4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     ce8:	eb d0                	jmp    cba <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     cea:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     cf1:	8b 55 e0             	mov    -0x20(%ebp),%edx
     cf4:	89 d0                	mov    %edx,%eax
     cf6:	c1 e0 02             	shl    $0x2,%eax
     cf9:	01 d0                	add    %edx,%eax
     cfb:	01 c0                	add    %eax,%eax
     cfd:	01 d8                	add    %ebx,%eax
     cff:	83 e8 30             	sub    $0x30,%eax
     d02:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     d05:	8b 45 10             	mov    0x10(%ebp),%eax
     d08:	0f b6 00             	movzbl (%eax),%eax
     d0b:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     d0e:	83 fb 2f             	cmp    $0x2f,%ebx
     d11:	7e 39                	jle    d4c <vprintfmt+0xe7>
     d13:	83 fb 39             	cmp    $0x39,%ebx
     d16:	7f 34                	jg     d4c <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     d18:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     d1c:	eb d3                	jmp    cf1 <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     d1e:	8b 45 14             	mov    0x14(%ebp),%eax
     d21:	8d 50 04             	lea    0x4(%eax),%edx
     d24:	89 55 14             	mov    %edx,0x14(%ebp)
     d27:	8b 00                	mov    (%eax),%eax
     d29:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     d2c:	eb 1f                	jmp    d4d <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     d2e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     d32:	79 86                	jns    cba <vprintfmt+0x55>
        width = 0;
     d34:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     d3b:	e9 7a ff ff ff       	jmp    cba <vprintfmt+0x55>

    case '#':
      altflag = 1;
     d40:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     d47:	e9 6e ff ff ff       	jmp    cba <vprintfmt+0x55>
      goto process_precision;
     d4c:	90                   	nop

process_precision:
      if (width < 0)
     d4d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     d51:	0f 89 63 ff ff ff    	jns    cba <vprintfmt+0x55>
        width = precision, precision = -1;
     d57:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d5a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     d5d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     d64:	e9 51 ff ff ff       	jmp    cba <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     d69:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     d6d:	e9 48 ff ff ff       	jmp    cba <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     d72:	8b 45 14             	mov    0x14(%ebp),%eax
     d75:	8d 50 04             	lea    0x4(%eax),%edx
     d78:	89 55 14             	mov    %edx,0x14(%ebp)
     d7b:	8b 00                	mov    (%eax),%eax
     d7d:	83 ec 08             	sub    $0x8,%esp
     d80:	ff 75 0c             	pushl  0xc(%ebp)
     d83:	50                   	push   %eax
     d84:	8b 45 08             	mov    0x8(%ebp),%eax
     d87:	ff d0                	call   *%eax
     d89:	83 c4 10             	add    $0x10,%esp
      break;
     d8c:	e9 81 02 00 00       	jmp    1012 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     d91:	8b 45 14             	mov    0x14(%ebp),%eax
     d94:	8d 50 04             	lea    0x4(%eax),%edx
     d97:	89 55 14             	mov    %edx,0x14(%ebp)
     d9a:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     d9c:	85 db                	test   %ebx,%ebx
     d9e:	79 02                	jns    da2 <vprintfmt+0x13d>
        err = -err;
     da0:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     da2:	83 fb 0f             	cmp    $0xf,%ebx
     da5:	7f 0b                	jg     db2 <vprintfmt+0x14d>
     da7:	8b 34 9d 20 14 00 00 	mov    0x1420(,%ebx,4),%esi
     dae:	85 f6                	test   %esi,%esi
     db0:	75 19                	jne    dcb <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     db2:	53                   	push   %ebx
     db3:	68 71 14 00 00       	push   $0x1471
     db8:	ff 75 0c             	pushl  0xc(%ebp)
     dbb:	ff 75 08             	pushl  0x8(%ebp)
     dbe:	e8 5c 02 00 00       	call   101f <printfmt>
     dc3:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     dc6:	e9 47 02 00 00       	jmp    1012 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     dcb:	56                   	push   %esi
     dcc:	68 7a 14 00 00       	push   $0x147a
     dd1:	ff 75 0c             	pushl  0xc(%ebp)
     dd4:	ff 75 08             	pushl  0x8(%ebp)
     dd7:	e8 43 02 00 00       	call   101f <printfmt>
     ddc:	83 c4 10             	add    $0x10,%esp
      break;
     ddf:	e9 2e 02 00 00       	jmp    1012 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     de4:	8b 45 14             	mov    0x14(%ebp),%eax
     de7:	8d 50 04             	lea    0x4(%eax),%edx
     dea:	89 55 14             	mov    %edx,0x14(%ebp)
     ded:	8b 30                	mov    (%eax),%esi
     def:	85 f6                	test   %esi,%esi
     df1:	75 05                	jne    df8 <vprintfmt+0x193>
        p = "(null)";
     df3:	be 7d 14 00 00       	mov    $0x147d,%esi
      if (width > 0 && padc != '-')
     df8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     dfc:	7e 6f                	jle    e6d <vprintfmt+0x208>
     dfe:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     e02:	74 69                	je     e6d <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     e04:	8b 45 e0             	mov    -0x20(%ebp),%eax
     e07:	83 ec 08             	sub    $0x8,%esp
     e0a:	50                   	push   %eax
     e0b:	56                   	push   %esi
     e0c:	e8 f1 f5 ff ff       	call   402 <strnlen>
     e11:	83 c4 10             	add    $0x10,%esp
     e14:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     e17:	eb 17                	jmp    e30 <vprintfmt+0x1cb>
          putch(padc, putdat);
     e19:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     e1d:	83 ec 08             	sub    $0x8,%esp
     e20:	ff 75 0c             	pushl  0xc(%ebp)
     e23:	50                   	push   %eax
     e24:	8b 45 08             	mov    0x8(%ebp),%eax
     e27:	ff d0                	call   *%eax
     e29:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     e2c:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     e30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     e34:	7f e3                	jg     e19 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     e36:	eb 35                	jmp    e6d <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     e38:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     e3c:	74 1c                	je     e5a <vprintfmt+0x1f5>
     e3e:	83 fb 1f             	cmp    $0x1f,%ebx
     e41:	7e 05                	jle    e48 <vprintfmt+0x1e3>
     e43:	83 fb 7e             	cmp    $0x7e,%ebx
     e46:	7e 12                	jle    e5a <vprintfmt+0x1f5>
          putch('?', putdat);
     e48:	83 ec 08             	sub    $0x8,%esp
     e4b:	ff 75 0c             	pushl  0xc(%ebp)
     e4e:	6a 3f                	push   $0x3f
     e50:	8b 45 08             	mov    0x8(%ebp),%eax
     e53:	ff d0                	call   *%eax
     e55:	83 c4 10             	add    $0x10,%esp
     e58:	eb 0f                	jmp    e69 <vprintfmt+0x204>
        else
          putch(ch, putdat);
     e5a:	83 ec 08             	sub    $0x8,%esp
     e5d:	ff 75 0c             	pushl  0xc(%ebp)
     e60:	53                   	push   %ebx
     e61:	8b 45 08             	mov    0x8(%ebp),%eax
     e64:	ff d0                	call   *%eax
     e66:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     e69:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     e6d:	89 f0                	mov    %esi,%eax
     e6f:	8d 70 01             	lea    0x1(%eax),%esi
     e72:	0f b6 00             	movzbl (%eax),%eax
     e75:	0f be d8             	movsbl %al,%ebx
     e78:	85 db                	test   %ebx,%ebx
     e7a:	74 26                	je     ea2 <vprintfmt+0x23d>
     e7c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     e80:	78 b6                	js     e38 <vprintfmt+0x1d3>
     e82:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     e86:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     e8a:	79 ac                	jns    e38 <vprintfmt+0x1d3>
      for (; width > 0; width--)
     e8c:	eb 14                	jmp    ea2 <vprintfmt+0x23d>
        putch(' ', putdat);
     e8e:	83 ec 08             	sub    $0x8,%esp
     e91:	ff 75 0c             	pushl  0xc(%ebp)
     e94:	6a 20                	push   $0x20
     e96:	8b 45 08             	mov    0x8(%ebp),%eax
     e99:	ff d0                	call   *%eax
     e9b:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     e9e:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     ea2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     ea6:	7f e6                	jg     e8e <vprintfmt+0x229>
      break;
     ea8:	e9 65 01 00 00       	jmp    1012 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     ead:	83 ec 08             	sub    $0x8,%esp
     eb0:	ff 75 e8             	pushl  -0x18(%ebp)
     eb3:	8d 45 14             	lea    0x14(%ebp),%eax
     eb6:	50                   	push   %eax
     eb7:	e8 62 fd ff ff       	call   c1e <getint>
     ebc:	83 c4 10             	add    $0x10,%esp
     ebf:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ec2:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     ec5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ec8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ecb:	85 d2                	test   %edx,%edx
     ecd:	79 23                	jns    ef2 <vprintfmt+0x28d>
        putch('-', putdat);
     ecf:	83 ec 08             	sub    $0x8,%esp
     ed2:	ff 75 0c             	pushl  0xc(%ebp)
     ed5:	6a 2d                	push   $0x2d
     ed7:	8b 45 08             	mov    0x8(%ebp),%eax
     eda:	ff d0                	call   *%eax
     edc:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     edf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ee2:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ee5:	f7 d8                	neg    %eax
     ee7:	83 d2 00             	adc    $0x0,%edx
     eea:	f7 da                	neg    %edx
     eec:	89 45 f0             	mov    %eax,-0x10(%ebp)
     eef:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     ef2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     ef9:	e9 b6 00 00 00       	jmp    fb4 <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     efe:	83 ec 08             	sub    $0x8,%esp
     f01:	ff 75 e8             	pushl  -0x18(%ebp)
     f04:	8d 45 14             	lea    0x14(%ebp),%eax
     f07:	50                   	push   %eax
     f08:	e8 c2 fc ff ff       	call   bcf <getuint>
     f0d:	83 c4 10             	add    $0x10,%esp
     f10:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f13:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     f16:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     f1d:	e9 92 00 00 00       	jmp    fb4 <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
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
      putch('X', putdat);
     f42:	83 ec 08             	sub    $0x8,%esp
     f45:	ff 75 0c             	pushl  0xc(%ebp)
     f48:	6a 58                	push   $0x58
     f4a:	8b 45 08             	mov    0x8(%ebp),%eax
     f4d:	ff d0                	call   *%eax
     f4f:	83 c4 10             	add    $0x10,%esp
      break;
     f52:	e9 bb 00 00 00       	jmp    1012 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     f57:	83 ec 08             	sub    $0x8,%esp
     f5a:	ff 75 0c             	pushl  0xc(%ebp)
     f5d:	6a 30                	push   $0x30
     f5f:	8b 45 08             	mov    0x8(%ebp),%eax
     f62:	ff d0                	call   *%eax
     f64:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     f67:	83 ec 08             	sub    $0x8,%esp
     f6a:	ff 75 0c             	pushl  0xc(%ebp)
     f6d:	6a 78                	push   $0x78
     f6f:	8b 45 08             	mov    0x8(%ebp),%eax
     f72:	ff d0                	call   *%eax
     f74:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     f77:	8b 45 14             	mov    0x14(%ebp),%eax
     f7a:	8d 50 04             	lea    0x4(%eax),%edx
     f7d:	89 55 14             	mov    %edx,0x14(%ebp)
     f80:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     f82:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f85:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     f8c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     f93:	eb 1f                	jmp    fb4 <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     f95:	83 ec 08             	sub    $0x8,%esp
     f98:	ff 75 e8             	pushl  -0x18(%ebp)
     f9b:	8d 45 14             	lea    0x14(%ebp),%eax
     f9e:	50                   	push   %eax
     f9f:	e8 2b fc ff ff       	call   bcf <getuint>
     fa4:	83 c4 10             	add    $0x10,%esp
     fa7:	89 45 f0             	mov    %eax,-0x10(%ebp)
     faa:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     fad:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     fb4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     fb8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fbb:	83 ec 04             	sub    $0x4,%esp
     fbe:	52                   	push   %edx
     fbf:	ff 75 e4             	pushl  -0x1c(%ebp)
     fc2:	50                   	push   %eax
     fc3:	ff 75 f4             	pushl  -0xc(%ebp)
     fc6:	ff 75 f0             	pushl  -0x10(%ebp)
     fc9:	ff 75 0c             	pushl  0xc(%ebp)
     fcc:	ff 75 08             	pushl  0x8(%ebp)
     fcf:	e8 42 fb ff ff       	call   b16 <printnum>
     fd4:	83 c4 20             	add    $0x20,%esp
      break;
     fd7:	eb 39                	jmp    1012 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     fd9:	83 ec 08             	sub    $0x8,%esp
     fdc:	ff 75 0c             	pushl  0xc(%ebp)
     fdf:	53                   	push   %ebx
     fe0:	8b 45 08             	mov    0x8(%ebp),%eax
     fe3:	ff d0                	call   *%eax
     fe5:	83 c4 10             	add    $0x10,%esp
      break;
     fe8:	eb 28                	jmp    1012 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     fea:	83 ec 08             	sub    $0x8,%esp
     fed:	ff 75 0c             	pushl  0xc(%ebp)
     ff0:	6a 25                	push   $0x25
     ff2:	8b 45 08             	mov    0x8(%ebp),%eax
     ff5:	ff d0                	call   *%eax
     ff7:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     ffa:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     ffe:	eb 04                	jmp    1004 <vprintfmt+0x39f>
    1000:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1004:	8b 45 10             	mov    0x10(%ebp),%eax
    1007:	83 e8 01             	sub    $0x1,%eax
    100a:	0f b6 00             	movzbl (%eax),%eax
    100d:	3c 25                	cmp    $0x25,%al
    100f:	75 ef                	jne    1000 <vprintfmt+0x39b>
        /* do nothing */;
      break;
    1011:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
    1012:	e9 6f fc ff ff       	jmp    c86 <vprintfmt+0x21>
        return;
    1017:	90                   	nop
    }
  }
}
    1018:	8d 65 f8             	lea    -0x8(%ebp),%esp
    101b:	5b                   	pop    %ebx
    101c:	5e                   	pop    %esi
    101d:	5d                   	pop    %ebp
    101e:	c3                   	ret    

0000101f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
    101f:	55                   	push   %ebp
    1020:	89 e5                	mov    %esp,%ebp
    1022:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
    1025:	8d 45 14             	lea    0x14(%ebp),%eax
    1028:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
    102b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    102e:	50                   	push   %eax
    102f:	ff 75 10             	pushl  0x10(%ebp)
    1032:	ff 75 0c             	pushl  0xc(%ebp)
    1035:	ff 75 08             	pushl  0x8(%ebp)
    1038:	e8 28 fc ff ff       	call   c65 <vprintfmt>
    103d:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
    1040:	90                   	nop
    1041:	c9                   	leave  
    1042:	c3                   	ret    

00001043 <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
    1043:	55                   	push   %ebp
    1044:	89 e5                	mov    %esp,%ebp
  b->cnt++;
    1046:	8b 45 0c             	mov    0xc(%ebp),%eax
    1049:	8b 40 08             	mov    0x8(%eax),%eax
    104c:	8d 50 01             	lea    0x1(%eax),%edx
    104f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1052:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
    1055:	8b 45 0c             	mov    0xc(%ebp),%eax
    1058:	8b 10                	mov    (%eax),%edx
    105a:	8b 45 0c             	mov    0xc(%ebp),%eax
    105d:	8b 40 04             	mov    0x4(%eax),%eax
    1060:	39 c2                	cmp    %eax,%edx
    1062:	73 12                	jae    1076 <sprintputch+0x33>
    *b->buf++ = ch;
    1064:	8b 45 0c             	mov    0xc(%ebp),%eax
    1067:	8b 00                	mov    (%eax),%eax
    1069:	8d 48 01             	lea    0x1(%eax),%ecx
    106c:	8b 55 0c             	mov    0xc(%ebp),%edx
    106f:	89 0a                	mov    %ecx,(%edx)
    1071:	8b 55 08             	mov    0x8(%ebp),%edx
    1074:	88 10                	mov    %dl,(%eax)
}
    1076:	90                   	nop
    1077:	5d                   	pop    %ebp
    1078:	c3                   	ret    

00001079 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    1079:	55                   	push   %ebp
    107a:	89 e5                	mov    %esp,%ebp
    107c:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
    107f:	8b 45 08             	mov    0x8(%ebp),%eax
    1082:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1085:	8b 45 0c             	mov    0xc(%ebp),%eax
    1088:	8d 50 ff             	lea    -0x1(%eax),%edx
    108b:	8b 45 08             	mov    0x8(%ebp),%eax
    108e:	01 d0                	add    %edx,%eax
    1090:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1093:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
    109a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    109e:	74 06                	je     10a6 <vsnprintf+0x2d>
    10a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    10a4:	7f 07                	jg     10ad <vsnprintf+0x34>
    return -E_INVAL;
    10a6:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    10ab:	eb 20                	jmp    10cd <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
    10ad:	ff 75 14             	pushl  0x14(%ebp)
    10b0:	ff 75 10             	pushl  0x10(%ebp)
    10b3:	8d 45 ec             	lea    -0x14(%ebp),%eax
    10b6:	50                   	push   %eax
    10b7:	68 43 10 00 00       	push   $0x1043
    10bc:	e8 a4 fb ff ff       	call   c65 <vprintfmt>
    10c1:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
    10c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    10c7:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
    10ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10cd:	c9                   	leave  
    10ce:	c3                   	ret    

000010cf <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
    10cf:	55                   	push   %ebp
    10d0:	89 e5                	mov    %esp,%ebp
    10d2:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
    10d5:	8d 45 14             	lea    0x14(%ebp),%eax
    10d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
    10db:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10de:	50                   	push   %eax
    10df:	ff 75 10             	pushl  0x10(%ebp)
    10e2:	ff 75 0c             	pushl  0xc(%ebp)
    10e5:	ff 75 08             	pushl  0x8(%ebp)
    10e8:	e8 8c ff ff ff       	call   1079 <vsnprintf>
    10ed:	83 c4 10             	add    $0x10,%esp
    10f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
    10f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    10f6:	c9                   	leave  
    10f7:	c3                   	ret    
    10f8:	66 90                	xchg   %ax,%ax
    10fa:	66 90                	xchg   %ax,%ax
    10fc:	66 90                	xchg   %ax,%ax
    10fe:	66 90                	xchg   %ax,%ax

00001100 <__udivdi3>:
    1100:	55                   	push   %ebp
    1101:	57                   	push   %edi
    1102:	56                   	push   %esi
    1103:	53                   	push   %ebx
    1104:	83 ec 1c             	sub    $0x1c,%esp
    1107:	8b 54 24 3c          	mov    0x3c(%esp),%edx
    110b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
    110f:	8b 74 24 34          	mov    0x34(%esp),%esi
    1113:	8b 5c 24 38          	mov    0x38(%esp),%ebx
    1117:	85 d2                	test   %edx,%edx
    1119:	75 35                	jne    1150 <__udivdi3+0x50>
    111b:	39 f3                	cmp    %esi,%ebx
    111d:	0f 87 bd 00 00 00    	ja     11e0 <__udivdi3+0xe0>
    1123:	85 db                	test   %ebx,%ebx
    1125:	89 d9                	mov    %ebx,%ecx
    1127:	75 0b                	jne    1134 <__udivdi3+0x34>
    1129:	b8 01 00 00 00       	mov    $0x1,%eax
    112e:	31 d2                	xor    %edx,%edx
    1130:	f7 f3                	div    %ebx
    1132:	89 c1                	mov    %eax,%ecx
    1134:	31 d2                	xor    %edx,%edx
    1136:	89 f0                	mov    %esi,%eax
    1138:	f7 f1                	div    %ecx
    113a:	89 c6                	mov    %eax,%esi
    113c:	89 e8                	mov    %ebp,%eax
    113e:	89 f7                	mov    %esi,%edi
    1140:	f7 f1                	div    %ecx
    1142:	89 fa                	mov    %edi,%edx
    1144:	83 c4 1c             	add    $0x1c,%esp
    1147:	5b                   	pop    %ebx
    1148:	5e                   	pop    %esi
    1149:	5f                   	pop    %edi
    114a:	5d                   	pop    %ebp
    114b:	c3                   	ret    
    114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1150:	39 f2                	cmp    %esi,%edx
    1152:	77 7c                	ja     11d0 <__udivdi3+0xd0>
    1154:	0f bd fa             	bsr    %edx,%edi
    1157:	83 f7 1f             	xor    $0x1f,%edi
    115a:	0f 84 98 00 00 00    	je     11f8 <__udivdi3+0xf8>
    1160:	89 f9                	mov    %edi,%ecx
    1162:	b8 20 00 00 00       	mov    $0x20,%eax
    1167:	29 f8                	sub    %edi,%eax
    1169:	d3 e2                	shl    %cl,%edx
    116b:	89 54 24 08          	mov    %edx,0x8(%esp)
    116f:	89 c1                	mov    %eax,%ecx
    1171:	89 da                	mov    %ebx,%edx
    1173:	d3 ea                	shr    %cl,%edx
    1175:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    1179:	09 d1                	or     %edx,%ecx
    117b:	89 f2                	mov    %esi,%edx
    117d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1181:	89 f9                	mov    %edi,%ecx
    1183:	d3 e3                	shl    %cl,%ebx
    1185:	89 c1                	mov    %eax,%ecx
    1187:	d3 ea                	shr    %cl,%edx
    1189:	89 f9                	mov    %edi,%ecx
    118b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    118f:	d3 e6                	shl    %cl,%esi
    1191:	89 eb                	mov    %ebp,%ebx
    1193:	89 c1                	mov    %eax,%ecx
    1195:	d3 eb                	shr    %cl,%ebx
    1197:	09 de                	or     %ebx,%esi
    1199:	89 f0                	mov    %esi,%eax
    119b:	f7 74 24 08          	divl   0x8(%esp)
    119f:	89 d6                	mov    %edx,%esi
    11a1:	89 c3                	mov    %eax,%ebx
    11a3:	f7 64 24 0c          	mull   0xc(%esp)
    11a7:	39 d6                	cmp    %edx,%esi
    11a9:	72 0c                	jb     11b7 <__udivdi3+0xb7>
    11ab:	89 f9                	mov    %edi,%ecx
    11ad:	d3 e5                	shl    %cl,%ebp
    11af:	39 c5                	cmp    %eax,%ebp
    11b1:	73 5d                	jae    1210 <__udivdi3+0x110>
    11b3:	39 d6                	cmp    %edx,%esi
    11b5:	75 59                	jne    1210 <__udivdi3+0x110>
    11b7:	8d 43 ff             	lea    -0x1(%ebx),%eax
    11ba:	31 ff                	xor    %edi,%edi
    11bc:	89 fa                	mov    %edi,%edx
    11be:	83 c4 1c             	add    $0x1c,%esp
    11c1:	5b                   	pop    %ebx
    11c2:	5e                   	pop    %esi
    11c3:	5f                   	pop    %edi
    11c4:	5d                   	pop    %ebp
    11c5:	c3                   	ret    
    11c6:	8d 76 00             	lea    0x0(%esi),%esi
    11c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    11d0:	31 ff                	xor    %edi,%edi
    11d2:	31 c0                	xor    %eax,%eax
    11d4:	89 fa                	mov    %edi,%edx
    11d6:	83 c4 1c             	add    $0x1c,%esp
    11d9:	5b                   	pop    %ebx
    11da:	5e                   	pop    %esi
    11db:	5f                   	pop    %edi
    11dc:	5d                   	pop    %ebp
    11dd:	c3                   	ret    
    11de:	66 90                	xchg   %ax,%ax
    11e0:	31 ff                	xor    %edi,%edi
    11e2:	89 e8                	mov    %ebp,%eax
    11e4:	89 f2                	mov    %esi,%edx
    11e6:	f7 f3                	div    %ebx
    11e8:	89 fa                	mov    %edi,%edx
    11ea:	83 c4 1c             	add    $0x1c,%esp
    11ed:	5b                   	pop    %ebx
    11ee:	5e                   	pop    %esi
    11ef:	5f                   	pop    %edi
    11f0:	5d                   	pop    %ebp
    11f1:	c3                   	ret    
    11f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11f8:	39 f2                	cmp    %esi,%edx
    11fa:	72 06                	jb     1202 <__udivdi3+0x102>
    11fc:	31 c0                	xor    %eax,%eax
    11fe:	39 eb                	cmp    %ebp,%ebx
    1200:	77 d2                	ja     11d4 <__udivdi3+0xd4>
    1202:	b8 01 00 00 00       	mov    $0x1,%eax
    1207:	eb cb                	jmp    11d4 <__udivdi3+0xd4>
    1209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1210:	89 d8                	mov    %ebx,%eax
    1212:	31 ff                	xor    %edi,%edi
    1214:	eb be                	jmp    11d4 <__udivdi3+0xd4>
    1216:	66 90                	xchg   %ax,%ax
    1218:	66 90                	xchg   %ax,%ax
    121a:	66 90                	xchg   %ax,%ax
    121c:	66 90                	xchg   %ax,%ax
    121e:	66 90                	xchg   %ax,%ax

00001220 <__umoddi3>:
    1220:	55                   	push   %ebp
    1221:	57                   	push   %edi
    1222:	56                   	push   %esi
    1223:	53                   	push   %ebx
    1224:	83 ec 1c             	sub    $0x1c,%esp
    1227:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
    122b:	8b 74 24 30          	mov    0x30(%esp),%esi
    122f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
    1233:	8b 7c 24 38          	mov    0x38(%esp),%edi
    1237:	85 ed                	test   %ebp,%ebp
    1239:	89 f0                	mov    %esi,%eax
    123b:	89 da                	mov    %ebx,%edx
    123d:	75 19                	jne    1258 <__umoddi3+0x38>
    123f:	39 df                	cmp    %ebx,%edi
    1241:	0f 86 b1 00 00 00    	jbe    12f8 <__umoddi3+0xd8>
    1247:	f7 f7                	div    %edi
    1249:	89 d0                	mov    %edx,%eax
    124b:	31 d2                	xor    %edx,%edx
    124d:	83 c4 1c             	add    $0x1c,%esp
    1250:	5b                   	pop    %ebx
    1251:	5e                   	pop    %esi
    1252:	5f                   	pop    %edi
    1253:	5d                   	pop    %ebp
    1254:	c3                   	ret    
    1255:	8d 76 00             	lea    0x0(%esi),%esi
    1258:	39 dd                	cmp    %ebx,%ebp
    125a:	77 f1                	ja     124d <__umoddi3+0x2d>
    125c:	0f bd cd             	bsr    %ebp,%ecx
    125f:	83 f1 1f             	xor    $0x1f,%ecx
    1262:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1266:	0f 84 b4 00 00 00    	je     1320 <__umoddi3+0x100>
    126c:	b8 20 00 00 00       	mov    $0x20,%eax
    1271:	89 c2                	mov    %eax,%edx
    1273:	8b 44 24 04          	mov    0x4(%esp),%eax
    1277:	29 c2                	sub    %eax,%edx
    1279:	89 c1                	mov    %eax,%ecx
    127b:	89 f8                	mov    %edi,%eax
    127d:	d3 e5                	shl    %cl,%ebp
    127f:	89 d1                	mov    %edx,%ecx
    1281:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1285:	d3 e8                	shr    %cl,%eax
    1287:	09 c5                	or     %eax,%ebp
    1289:	8b 44 24 04          	mov    0x4(%esp),%eax
    128d:	89 c1                	mov    %eax,%ecx
    128f:	d3 e7                	shl    %cl,%edi
    1291:	89 d1                	mov    %edx,%ecx
    1293:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1297:	89 df                	mov    %ebx,%edi
    1299:	d3 ef                	shr    %cl,%edi
    129b:	89 c1                	mov    %eax,%ecx
    129d:	89 f0                	mov    %esi,%eax
    129f:	d3 e3                	shl    %cl,%ebx
    12a1:	89 d1                	mov    %edx,%ecx
    12a3:	89 fa                	mov    %edi,%edx
    12a5:	d3 e8                	shr    %cl,%eax
    12a7:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
    12ac:	09 d8                	or     %ebx,%eax
    12ae:	f7 f5                	div    %ebp
    12b0:	d3 e6                	shl    %cl,%esi
    12b2:	89 d1                	mov    %edx,%ecx
    12b4:	f7 64 24 08          	mull   0x8(%esp)
    12b8:	39 d1                	cmp    %edx,%ecx
    12ba:	89 c3                	mov    %eax,%ebx
    12bc:	89 d7                	mov    %edx,%edi
    12be:	72 06                	jb     12c6 <__umoddi3+0xa6>
    12c0:	75 0e                	jne    12d0 <__umoddi3+0xb0>
    12c2:	39 c6                	cmp    %eax,%esi
    12c4:	73 0a                	jae    12d0 <__umoddi3+0xb0>
    12c6:	2b 44 24 08          	sub    0x8(%esp),%eax
    12ca:	19 ea                	sbb    %ebp,%edx
    12cc:	89 d7                	mov    %edx,%edi
    12ce:	89 c3                	mov    %eax,%ebx
    12d0:	89 ca                	mov    %ecx,%edx
    12d2:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    12d7:	29 de                	sub    %ebx,%esi
    12d9:	19 fa                	sbb    %edi,%edx
    12db:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    12df:	89 d0                	mov    %edx,%eax
    12e1:	d3 e0                	shl    %cl,%eax
    12e3:	89 d9                	mov    %ebx,%ecx
    12e5:	d3 ee                	shr    %cl,%esi
    12e7:	d3 ea                	shr    %cl,%edx
    12e9:	09 f0                	or     %esi,%eax
    12eb:	83 c4 1c             	add    $0x1c,%esp
    12ee:	5b                   	pop    %ebx
    12ef:	5e                   	pop    %esi
    12f0:	5f                   	pop    %edi
    12f1:	5d                   	pop    %ebp
    12f2:	c3                   	ret    
    12f3:	90                   	nop
    12f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12f8:	85 ff                	test   %edi,%edi
    12fa:	89 f9                	mov    %edi,%ecx
    12fc:	75 0b                	jne    1309 <__umoddi3+0xe9>
    12fe:	b8 01 00 00 00       	mov    $0x1,%eax
    1303:	31 d2                	xor    %edx,%edx
    1305:	f7 f7                	div    %edi
    1307:	89 c1                	mov    %eax,%ecx
    1309:	89 d8                	mov    %ebx,%eax
    130b:	31 d2                	xor    %edx,%edx
    130d:	f7 f1                	div    %ecx
    130f:	89 f0                	mov    %esi,%eax
    1311:	f7 f1                	div    %ecx
    1313:	e9 31 ff ff ff       	jmp    1249 <__umoddi3+0x29>
    1318:	90                   	nop
    1319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1320:	39 dd                	cmp    %ebx,%ebp
    1322:	72 08                	jb     132c <__umoddi3+0x10c>
    1324:	39 f7                	cmp    %esi,%edi
    1326:	0f 87 21 ff ff ff    	ja     124d <__umoddi3+0x2d>
    132c:	89 da                	mov    %ebx,%edx
    132e:	89 f0                	mov    %esi,%eax
    1330:	29 f8                	sub    %edi,%eax
    1332:	19 ea                	sbb    %ebp,%edx
    1334:	e9 14 ff ff ff       	jmp    124d <__umoddi3+0x2d>
