
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 f4 0e 00 00       	call   f05 <exit>

  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 ac 1c 00 00 	mov    0x1cac(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 80 1c 00 00       	push   $0x1c80
      2c:	e8 6b 03 00 00       	call   39c <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 bc 0e 00 00       	call   f05 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 de 0e 00 00       	call   f3d <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 87 1c 00 00       	push   $0x1c87
      71:	6a 02                	push   $0x2
      73:	e8 20 10 00 00       	call   1098 <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c6 01 00 00       	jmp    246 <runcmd+0x246>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 e8             	mov    %eax,-0x18(%ebp)
    close(rcmd->fd);
      86:	8b 45 e8             	mov    -0x18(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 98 0e 00 00       	call   f2d <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 e8             	mov    -0x18(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 97 0e 00 00       	call   f45 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 97 1c 00 00       	push   $0x1c97
      c4:	6a 02                	push   $0x2
      c6:	e8 cd 0f 00 00       	call   1098 <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 32 0e 00 00       	call   f05 <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5c 01 00 00       	jmp    246 <runcmd+0x246>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fork1() == 0)
      f0:	e8 c7 02 00 00       	call   3bc <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      runcmd(lcmd->left);
      f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
    wait();
     10b:	e8 fd 0d 00 00       	call   f0d <wait>
    runcmd(lcmd->right);
     110:	8b 45 f0             	mov    -0x10(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 1f 01 00 00       	jmp    246 <runcmd+0x246>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 dc 0d 00 00       	call   f15 <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 a7 1c 00 00       	push   $0x1ca7
     148:	e8 4f 02 00 00       	call   39c <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 67 02 00 00       	call   3bc <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 ca 0d 00 00       	call   f2d <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 0b 0e 00 00       	call   f7d <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 ac 0d 00 00       	call   f2d <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 9d 0d 00 00       	call   f2d <close>
     190:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     193:	8b 45 ec             	mov    -0x14(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1a5:	e8 12 02 00 00       	call   3bc <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 75 0d 00 00       	call   f2d <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 b6 0d 00 00       	call   f7d <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 57 0d 00 00       	call   f2d <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 48 0d 00 00       	call   f2d <close>
     1e5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 27 0d 00 00       	call   f2d <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 18 0d 00 00       	call   f2d <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 f0 0c 00 00       	call   f0d <wait>
    wait();
     21d:	e8 eb 0c 00 00       	call   f0d <wait>
    break;
     222:	eb 22                	jmp    246 <runcmd+0x246>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(fork1() == 0)
     22a:	e8 8d 01 00 00       	call   3bc <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 12                	jne    245 <runcmd+0x245>
      runcmd(bcmd->cmd);
     233:	8b 45 f4             	mov    -0xc(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	90                   	nop
  }
  exit();
     246:	e8 ba 0c 00 00       	call   f05 <exit>

0000024b <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     24b:	55                   	push   %ebp
     24c:	89 e5                	mov    %esp,%ebp
     24e:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     251:	83 ec 08             	sub    $0x8,%esp
     254:	68 c4 1c 00 00       	push   $0x1cc4
     259:	6a 02                	push   $0x2
     25b:	e8 38 0e 00 00       	call   1098 <printf>
     260:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     263:	8b 45 0c             	mov    0xc(%ebp),%eax
     266:	83 ec 04             	sub    $0x4,%esp
     269:	50                   	push   %eax
     26a:	6a 00                	push   $0x0
     26c:	ff 75 08             	pushl  0x8(%ebp)
     26f:	e8 f6 0a 00 00       	call   d6a <memset>
     274:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     277:	83 ec 08             	sub    $0x8,%esp
     27a:	ff 75 0c             	pushl  0xc(%ebp)
     27d:	ff 75 08             	pushl  0x8(%ebp)
     280:	e8 32 0b 00 00       	call   db7 <gets>
     285:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     288:	8b 45 08             	mov    0x8(%ebp),%eax
     28b:	0f b6 00             	movzbl (%eax),%eax
     28e:	84 c0                	test   %al,%al
     290:	75 07                	jne    299 <getcmd+0x4e>
    return -1;
     292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     297:	eb 05                	jmp    29e <getcmd+0x53>
  return 0;
     299:	b8 00 00 00 00       	mov    $0x0,%eax
}
     29e:	c9                   	leave  
     29f:	c3                   	ret    

000002a0 <main>:

int
main(void)
{
     2a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     2a4:	83 e4 f0             	and    $0xfffffff0,%esp
     2a7:	ff 71 fc             	pushl  -0x4(%ecx)
     2aa:	55                   	push   %ebp
     2ab:	89 e5                	mov    %esp,%ebp
     2ad:	51                   	push   %ecx
     2ae:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
     2b1:	eb 16                	jmp    2c9 <main+0x29>
    if(fd >= 3){
     2b3:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     2b7:	7e 10                	jle    2c9 <main+0x29>
      close(fd);
     2b9:	83 ec 0c             	sub    $0xc,%esp
     2bc:	ff 75 f4             	pushl  -0xc(%ebp)
     2bf:	e8 69 0c 00 00       	call   f2d <close>
     2c4:	83 c4 10             	add    $0x10,%esp
      break;
     2c7:	eb 1b                	jmp    2e4 <main+0x44>
  while((fd = open("console", O_RDWR)) >= 0){
     2c9:	83 ec 08             	sub    $0x8,%esp
     2cc:	6a 02                	push   $0x2
     2ce:	68 c7 1c 00 00       	push   $0x1cc7
     2d3:	e8 6d 0c 00 00       	call   f45 <open>
     2d8:	83 c4 10             	add    $0x10,%esp
     2db:	89 45 f4             	mov    %eax,-0xc(%ebp)
     2de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2e2:	79 cf                	jns    2b3 <main+0x13>
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     2e4:	e9 94 00 00 00       	jmp    37d <main+0xdd>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2e9:	0f b6 05 80 26 00 00 	movzbl 0x2680,%eax
     2f0:	3c 63                	cmp    $0x63,%al
     2f2:	75 5f                	jne    353 <main+0xb3>
     2f4:	0f b6 05 81 26 00 00 	movzbl 0x2681,%eax
     2fb:	3c 64                	cmp    $0x64,%al
     2fd:	75 54                	jne    353 <main+0xb3>
     2ff:	0f b6 05 82 26 00 00 	movzbl 0x2682,%eax
     306:	3c 20                	cmp    $0x20,%al
     308:	75 49                	jne    353 <main+0xb3>
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     30a:	83 ec 0c             	sub    $0xc,%esp
     30d:	68 80 26 00 00       	push   $0x2680
     312:	e8 fc 09 00 00       	call   d13 <strlen>
     317:	83 c4 10             	add    $0x10,%esp
     31a:	83 e8 01             	sub    $0x1,%eax
     31d:	c6 80 80 26 00 00 00 	movb   $0x0,0x2680(%eax)
      if(chdir(buf+3) < 0)
     324:	b8 83 26 00 00       	mov    $0x2683,%eax
     329:	83 ec 0c             	sub    $0xc,%esp
     32c:	50                   	push   %eax
     32d:	e8 43 0c 00 00       	call   f75 <chdir>
     332:	83 c4 10             	add    $0x10,%esp
     335:	85 c0                	test   %eax,%eax
     337:	79 44                	jns    37d <main+0xdd>
        printf(2, "cannot cd %s\n", buf+3);
     339:	b8 83 26 00 00       	mov    $0x2683,%eax
     33e:	83 ec 04             	sub    $0x4,%esp
     341:	50                   	push   %eax
     342:	68 cf 1c 00 00       	push   $0x1ccf
     347:	6a 02                	push   $0x2
     349:	e8 4a 0d 00 00       	call   1098 <printf>
     34e:	83 c4 10             	add    $0x10,%esp
      continue;
     351:	eb 2a                	jmp    37d <main+0xdd>
    }
    if(fork1() == 0)
     353:	e8 64 00 00 00       	call   3bc <fork1>
     358:	85 c0                	test   %eax,%eax
     35a:	75 1c                	jne    378 <main+0xd8>
      runcmd(parsecmd(buf));
     35c:	83 ec 0c             	sub    $0xc,%esp
     35f:	68 80 26 00 00       	push   $0x2680
     364:	e8 ab 03 00 00       	call   714 <parsecmd>
     369:	83 c4 10             	add    $0x10,%esp
     36c:	83 ec 0c             	sub    $0xc,%esp
     36f:	50                   	push   %eax
     370:	e8 8b fc ff ff       	call   0 <runcmd>
     375:	83 c4 10             	add    $0x10,%esp
    wait();
     378:	e8 90 0b 00 00       	call   f0d <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     37d:	83 ec 08             	sub    $0x8,%esp
     380:	6a 64                	push   $0x64
     382:	68 80 26 00 00       	push   $0x2680
     387:	e8 bf fe ff ff       	call   24b <getcmd>
     38c:	83 c4 10             	add    $0x10,%esp
     38f:	85 c0                	test   %eax,%eax
     391:	0f 89 52 ff ff ff    	jns    2e9 <main+0x49>
  }
  exit();
     397:	e8 69 0b 00 00       	call   f05 <exit>

0000039c <panic>:
}

void
panic(char *s)
{
     39c:	55                   	push   %ebp
     39d:	89 e5                	mov    %esp,%ebp
     39f:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     3a2:	83 ec 04             	sub    $0x4,%esp
     3a5:	ff 75 08             	pushl  0x8(%ebp)
     3a8:	68 dd 1c 00 00       	push   $0x1cdd
     3ad:	6a 02                	push   $0x2
     3af:	e8 e4 0c 00 00       	call   1098 <printf>
     3b4:	83 c4 10             	add    $0x10,%esp
  exit();
     3b7:	e8 49 0b 00 00       	call   f05 <exit>

000003bc <fork1>:
}

int
fork1(void)
{
     3bc:	55                   	push   %ebp
     3bd:	89 e5                	mov    %esp,%ebp
     3bf:	83 ec 18             	sub    $0x18,%esp
  int pid;

  pid = fork();
     3c2:	e8 36 0b 00 00       	call   efd <fork>
     3c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     3ca:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     3ce:	75 10                	jne    3e0 <fork1+0x24>
    panic("fork");
     3d0:	83 ec 0c             	sub    $0xc,%esp
     3d3:	68 e1 1c 00 00       	push   $0x1ce1
     3d8:	e8 bf ff ff ff       	call   39c <panic>
     3dd:	83 c4 10             	add    $0x10,%esp
  return pid;
     3e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     3e3:	c9                   	leave  
     3e4:	c3                   	ret    

000003e5 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3e5:	55                   	push   %ebp
     3e6:	89 e5                	mov    %esp,%ebp
     3e8:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3eb:	83 ec 0c             	sub    $0xc,%esp
     3ee:	6a 54                	push   $0x54
     3f0:	e8 76 0f 00 00       	call   136b <malloc>
     3f5:	83 c4 10             	add    $0x10,%esp
     3f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     3fb:	83 ec 04             	sub    $0x4,%esp
     3fe:	6a 54                	push   $0x54
     400:	6a 00                	push   $0x0
     402:	ff 75 f4             	pushl  -0xc(%ebp)
     405:	e8 60 09 00 00       	call   d6a <memset>
     40a:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     40d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     410:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     416:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     419:	c9                   	leave  
     41a:	c3                   	ret    

0000041b <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     41b:	55                   	push   %ebp
     41c:	89 e5                	mov    %esp,%ebp
     41e:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     421:	83 ec 0c             	sub    $0xc,%esp
     424:	6a 18                	push   $0x18
     426:	e8 40 0f 00 00       	call   136b <malloc>
     42b:	83 c4 10             	add    $0x10,%esp
     42e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     431:	83 ec 04             	sub    $0x4,%esp
     434:	6a 18                	push   $0x18
     436:	6a 00                	push   $0x0
     438:	ff 75 f4             	pushl  -0xc(%ebp)
     43b:	e8 2a 09 00 00       	call   d6a <memset>
     440:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     443:	8b 45 f4             	mov    -0xc(%ebp),%eax
     446:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     44c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44f:	8b 55 08             	mov    0x8(%ebp),%edx
     452:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     455:	8b 45 f4             	mov    -0xc(%ebp),%eax
     458:	8b 55 0c             	mov    0xc(%ebp),%edx
     45b:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     45e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     461:	8b 55 10             	mov    0x10(%ebp),%edx
     464:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     467:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46a:	8b 55 14             	mov    0x14(%ebp),%edx
     46d:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     470:	8b 45 f4             	mov    -0xc(%ebp),%eax
     473:	8b 55 18             	mov    0x18(%ebp),%edx
     476:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     479:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     47c:	c9                   	leave  
     47d:	c3                   	ret    

0000047e <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     47e:	55                   	push   %ebp
     47f:	89 e5                	mov    %esp,%ebp
     481:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     484:	83 ec 0c             	sub    $0xc,%esp
     487:	6a 0c                	push   $0xc
     489:	e8 dd 0e 00 00       	call   136b <malloc>
     48e:	83 c4 10             	add    $0x10,%esp
     491:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     494:	83 ec 04             	sub    $0x4,%esp
     497:	6a 0c                	push   $0xc
     499:	6a 00                	push   $0x0
     49b:	ff 75 f4             	pushl  -0xc(%ebp)
     49e:	e8 c7 08 00 00       	call   d6a <memset>
     4a3:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     4a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4a9:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     4af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4b2:	8b 55 08             	mov    0x8(%ebp),%edx
     4b5:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     4b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4bb:	8b 55 0c             	mov    0xc(%ebp),%edx
     4be:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     4c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     4c4:	c9                   	leave  
     4c5:	c3                   	ret    

000004c6 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     4c6:	55                   	push   %ebp
     4c7:	89 e5                	mov    %esp,%ebp
     4c9:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4cc:	83 ec 0c             	sub    $0xc,%esp
     4cf:	6a 0c                	push   $0xc
     4d1:	e8 95 0e 00 00       	call   136b <malloc>
     4d6:	83 c4 10             	add    $0x10,%esp
     4d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     4dc:	83 ec 04             	sub    $0x4,%esp
     4df:	6a 0c                	push   $0xc
     4e1:	6a 00                	push   $0x0
     4e3:	ff 75 f4             	pushl  -0xc(%ebp)
     4e6:	e8 7f 08 00 00       	call   d6a <memset>
     4eb:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     4ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f1:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     4f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4fa:	8b 55 08             	mov    0x8(%ebp),%edx
     4fd:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     500:	8b 45 f4             	mov    -0xc(%ebp),%eax
     503:	8b 55 0c             	mov    0xc(%ebp),%edx
     506:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     509:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     50c:	c9                   	leave  
     50d:	c3                   	ret    

0000050e <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     50e:	55                   	push   %ebp
     50f:	89 e5                	mov    %esp,%ebp
     511:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     514:	83 ec 0c             	sub    $0xc,%esp
     517:	6a 08                	push   $0x8
     519:	e8 4d 0e 00 00       	call   136b <malloc>
     51e:	83 c4 10             	add    $0x10,%esp
     521:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     524:	83 ec 04             	sub    $0x4,%esp
     527:	6a 08                	push   $0x8
     529:	6a 00                	push   $0x0
     52b:	ff 75 f4             	pushl  -0xc(%ebp)
     52e:	e8 37 08 00 00       	call   d6a <memset>
     533:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     536:	8b 45 f4             	mov    -0xc(%ebp),%eax
     539:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     542:	8b 55 08             	mov    0x8(%ebp),%edx
     545:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     548:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     54b:	c9                   	leave  
     54c:	c3                   	ret    

0000054d <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     54d:	55                   	push   %ebp
     54e:	89 e5                	mov    %esp,%ebp
     550:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;

  s = *ps;
     553:	8b 45 08             	mov    0x8(%ebp),%eax
     556:	8b 00                	mov    (%eax),%eax
     558:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     55b:	eb 04                	jmp    561 <gettoken+0x14>
    s++;
     55d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     561:	8b 45 f4             	mov    -0xc(%ebp),%eax
     564:	3b 45 0c             	cmp    0xc(%ebp),%eax
     567:	73 1e                	jae    587 <gettoken+0x3a>
     569:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56c:	0f b6 00             	movzbl (%eax),%eax
     56f:	0f be c0             	movsbl %al,%eax
     572:	83 ec 08             	sub    $0x8,%esp
     575:	50                   	push   %eax
     576:	68 48 26 00 00       	push   $0x2648
     57b:	e8 04 08 00 00       	call   d84 <strchr>
     580:	83 c4 10             	add    $0x10,%esp
     583:	85 c0                	test   %eax,%eax
     585:	75 d6                	jne    55d <gettoken+0x10>
  if(q)
     587:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     58b:	74 08                	je     595 <gettoken+0x48>
    *q = s;
     58d:	8b 45 10             	mov    0x10(%ebp),%eax
     590:	8b 55 f4             	mov    -0xc(%ebp),%edx
     593:	89 10                	mov    %edx,(%eax)
  ret = *s;
     595:	8b 45 f4             	mov    -0xc(%ebp),%eax
     598:	0f b6 00             	movzbl (%eax),%eax
     59b:	0f be c0             	movsbl %al,%eax
     59e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     5a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a4:	0f b6 00             	movzbl (%eax),%eax
     5a7:	0f be c0             	movsbl %al,%eax
     5aa:	83 f8 29             	cmp    $0x29,%eax
     5ad:	7f 14                	jg     5c3 <gettoken+0x76>
     5af:	83 f8 28             	cmp    $0x28,%eax
     5b2:	7d 28                	jge    5dc <gettoken+0x8f>
     5b4:	85 c0                	test   %eax,%eax
     5b6:	0f 84 94 00 00 00    	je     650 <gettoken+0x103>
     5bc:	83 f8 26             	cmp    $0x26,%eax
     5bf:	74 1b                	je     5dc <gettoken+0x8f>
     5c1:	eb 3a                	jmp    5fd <gettoken+0xb0>
     5c3:	83 f8 3e             	cmp    $0x3e,%eax
     5c6:	74 1a                	je     5e2 <gettoken+0x95>
     5c8:	83 f8 3e             	cmp    $0x3e,%eax
     5cb:	7f 0a                	jg     5d7 <gettoken+0x8a>
     5cd:	83 e8 3b             	sub    $0x3b,%eax
     5d0:	83 f8 01             	cmp    $0x1,%eax
     5d3:	77 28                	ja     5fd <gettoken+0xb0>
     5d5:	eb 05                	jmp    5dc <gettoken+0x8f>
     5d7:	83 f8 7c             	cmp    $0x7c,%eax
     5da:	75 21                	jne    5fd <gettoken+0xb0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     5dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     5e0:	eb 75                	jmp    657 <gettoken+0x10a>
  case '>':
    s++;
     5e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     5e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e9:	0f b6 00             	movzbl (%eax),%eax
     5ec:	3c 3e                	cmp    $0x3e,%al
     5ee:	75 63                	jne    653 <gettoken+0x106>
      ret = '+';
     5f0:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     5f7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     5fb:	eb 56                	jmp    653 <gettoken+0x106>
  default:
    ret = 'a';
     5fd:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     604:	eb 04                	jmp    60a <gettoken+0xbd>
      s++;
     606:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     60a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     60d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     610:	73 44                	jae    656 <gettoken+0x109>
     612:	8b 45 f4             	mov    -0xc(%ebp),%eax
     615:	0f b6 00             	movzbl (%eax),%eax
     618:	0f be c0             	movsbl %al,%eax
     61b:	83 ec 08             	sub    $0x8,%esp
     61e:	50                   	push   %eax
     61f:	68 48 26 00 00       	push   $0x2648
     624:	e8 5b 07 00 00       	call   d84 <strchr>
     629:	83 c4 10             	add    $0x10,%esp
     62c:	85 c0                	test   %eax,%eax
     62e:	75 26                	jne    656 <gettoken+0x109>
     630:	8b 45 f4             	mov    -0xc(%ebp),%eax
     633:	0f b6 00             	movzbl (%eax),%eax
     636:	0f be c0             	movsbl %al,%eax
     639:	83 ec 08             	sub    $0x8,%esp
     63c:	50                   	push   %eax
     63d:	68 50 26 00 00       	push   $0x2650
     642:	e8 3d 07 00 00       	call   d84 <strchr>
     647:	83 c4 10             	add    $0x10,%esp
     64a:	85 c0                	test   %eax,%eax
     64c:	74 b8                	je     606 <gettoken+0xb9>
    break;
     64e:	eb 06                	jmp    656 <gettoken+0x109>
    break;
     650:	90                   	nop
     651:	eb 04                	jmp    657 <gettoken+0x10a>
    break;
     653:	90                   	nop
     654:	eb 01                	jmp    657 <gettoken+0x10a>
    break;
     656:	90                   	nop
  }
  if(eq)
     657:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     65b:	74 0e                	je     66b <gettoken+0x11e>
    *eq = s;
     65d:	8b 45 14             	mov    0x14(%ebp),%eax
     660:	8b 55 f4             	mov    -0xc(%ebp),%edx
     663:	89 10                	mov    %edx,(%eax)

  while(s < es && strchr(whitespace, *s))
     665:	eb 04                	jmp    66b <gettoken+0x11e>
    s++;
     667:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     66b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     66e:	3b 45 0c             	cmp    0xc(%ebp),%eax
     671:	73 1e                	jae    691 <gettoken+0x144>
     673:	8b 45 f4             	mov    -0xc(%ebp),%eax
     676:	0f b6 00             	movzbl (%eax),%eax
     679:	0f be c0             	movsbl %al,%eax
     67c:	83 ec 08             	sub    $0x8,%esp
     67f:	50                   	push   %eax
     680:	68 48 26 00 00       	push   $0x2648
     685:	e8 fa 06 00 00       	call   d84 <strchr>
     68a:	83 c4 10             	add    $0x10,%esp
     68d:	85 c0                	test   %eax,%eax
     68f:	75 d6                	jne    667 <gettoken+0x11a>
  *ps = s;
     691:	8b 45 08             	mov    0x8(%ebp),%eax
     694:	8b 55 f4             	mov    -0xc(%ebp),%edx
     697:	89 10                	mov    %edx,(%eax)
  return ret;
     699:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     69c:	c9                   	leave  
     69d:	c3                   	ret    

0000069e <peek>:

int
peek(char **ps, char *es, char *toks)
{
     69e:	55                   	push   %ebp
     69f:	89 e5                	mov    %esp,%ebp
     6a1:	83 ec 18             	sub    $0x18,%esp
  char *s;

  s = *ps;
     6a4:	8b 45 08             	mov    0x8(%ebp),%eax
     6a7:	8b 00                	mov    (%eax),%eax
     6a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     6ac:	eb 04                	jmp    6b2 <peek+0x14>
    s++;
     6ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     6b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6b8:	73 1e                	jae    6d8 <peek+0x3a>
     6ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6bd:	0f b6 00             	movzbl (%eax),%eax
     6c0:	0f be c0             	movsbl %al,%eax
     6c3:	83 ec 08             	sub    $0x8,%esp
     6c6:	50                   	push   %eax
     6c7:	68 48 26 00 00       	push   $0x2648
     6cc:	e8 b3 06 00 00       	call   d84 <strchr>
     6d1:	83 c4 10             	add    $0x10,%esp
     6d4:	85 c0                	test   %eax,%eax
     6d6:	75 d6                	jne    6ae <peek+0x10>
  *ps = s;
     6d8:	8b 45 08             	mov    0x8(%ebp),%eax
     6db:	8b 55 f4             	mov    -0xc(%ebp),%edx
     6de:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     6e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6e3:	0f b6 00             	movzbl (%eax),%eax
     6e6:	84 c0                	test   %al,%al
     6e8:	74 23                	je     70d <peek+0x6f>
     6ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ed:	0f b6 00             	movzbl (%eax),%eax
     6f0:	0f be c0             	movsbl %al,%eax
     6f3:	83 ec 08             	sub    $0x8,%esp
     6f6:	50                   	push   %eax
     6f7:	ff 75 10             	pushl  0x10(%ebp)
     6fa:	e8 85 06 00 00       	call   d84 <strchr>
     6ff:	83 c4 10             	add    $0x10,%esp
     702:	85 c0                	test   %eax,%eax
     704:	74 07                	je     70d <peek+0x6f>
     706:	b8 01 00 00 00       	mov    $0x1,%eax
     70b:	eb 05                	jmp    712 <peek+0x74>
     70d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     712:	c9                   	leave  
     713:	c3                   	ret    

00000714 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     714:	55                   	push   %ebp
     715:	89 e5                	mov    %esp,%ebp
     717:	53                   	push   %ebx
     718:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     71b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     71e:	8b 45 08             	mov    0x8(%ebp),%eax
     721:	83 ec 0c             	sub    $0xc,%esp
     724:	50                   	push   %eax
     725:	e8 e9 05 00 00       	call   d13 <strlen>
     72a:	83 c4 10             	add    $0x10,%esp
     72d:	01 d8                	add    %ebx,%eax
     72f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     732:	83 ec 08             	sub    $0x8,%esp
     735:	ff 75 f4             	pushl  -0xc(%ebp)
     738:	8d 45 08             	lea    0x8(%ebp),%eax
     73b:	50                   	push   %eax
     73c:	e8 61 00 00 00       	call   7a2 <parseline>
     741:	83 c4 10             	add    $0x10,%esp
     744:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     747:	83 ec 04             	sub    $0x4,%esp
     74a:	68 e6 1c 00 00       	push   $0x1ce6
     74f:	ff 75 f4             	pushl  -0xc(%ebp)
     752:	8d 45 08             	lea    0x8(%ebp),%eax
     755:	50                   	push   %eax
     756:	e8 43 ff ff ff       	call   69e <peek>
     75b:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     75e:	8b 45 08             	mov    0x8(%ebp),%eax
     761:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     764:	74 26                	je     78c <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     766:	8b 45 08             	mov    0x8(%ebp),%eax
     769:	83 ec 04             	sub    $0x4,%esp
     76c:	50                   	push   %eax
     76d:	68 e7 1c 00 00       	push   $0x1ce7
     772:	6a 02                	push   $0x2
     774:	e8 1f 09 00 00       	call   1098 <printf>
     779:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     77c:	83 ec 0c             	sub    $0xc,%esp
     77f:	68 f6 1c 00 00       	push   $0x1cf6
     784:	e8 13 fc ff ff       	call   39c <panic>
     789:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     78c:	83 ec 0c             	sub    $0xc,%esp
     78f:	ff 75 f0             	pushl  -0x10(%ebp)
     792:	e8 eb 03 00 00       	call   b82 <nulterminate>
     797:	83 c4 10             	add    $0x10,%esp
  return cmd;
     79a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     79d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7a0:	c9                   	leave  
     7a1:	c3                   	ret    

000007a2 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     7a2:	55                   	push   %ebp
     7a3:	89 e5                	mov    %esp,%ebp
     7a5:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     7a8:	83 ec 08             	sub    $0x8,%esp
     7ab:	ff 75 0c             	pushl  0xc(%ebp)
     7ae:	ff 75 08             	pushl  0x8(%ebp)
     7b1:	e8 99 00 00 00       	call   84f <parsepipe>
     7b6:	83 c4 10             	add    $0x10,%esp
     7b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7bc:	eb 23                	jmp    7e1 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     7be:	6a 00                	push   $0x0
     7c0:	6a 00                	push   $0x0
     7c2:	ff 75 0c             	pushl  0xc(%ebp)
     7c5:	ff 75 08             	pushl  0x8(%ebp)
     7c8:	e8 80 fd ff ff       	call   54d <gettoken>
     7cd:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     7d0:	83 ec 0c             	sub    $0xc,%esp
     7d3:	ff 75 f4             	pushl  -0xc(%ebp)
     7d6:	e8 33 fd ff ff       	call   50e <backcmd>
     7db:	83 c4 10             	add    $0x10,%esp
     7de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     7e1:	83 ec 04             	sub    $0x4,%esp
     7e4:	68 fd 1c 00 00       	push   $0x1cfd
     7e9:	ff 75 0c             	pushl  0xc(%ebp)
     7ec:	ff 75 08             	pushl  0x8(%ebp)
     7ef:	e8 aa fe ff ff       	call   69e <peek>
     7f4:	83 c4 10             	add    $0x10,%esp
     7f7:	85 c0                	test   %eax,%eax
     7f9:	75 c3                	jne    7be <parseline+0x1c>
  }
  if(peek(ps, es, ";")){
     7fb:	83 ec 04             	sub    $0x4,%esp
     7fe:	68 ff 1c 00 00       	push   $0x1cff
     803:	ff 75 0c             	pushl  0xc(%ebp)
     806:	ff 75 08             	pushl  0x8(%ebp)
     809:	e8 90 fe ff ff       	call   69e <peek>
     80e:	83 c4 10             	add    $0x10,%esp
     811:	85 c0                	test   %eax,%eax
     813:	74 35                	je     84a <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     815:	6a 00                	push   $0x0
     817:	6a 00                	push   $0x0
     819:	ff 75 0c             	pushl  0xc(%ebp)
     81c:	ff 75 08             	pushl  0x8(%ebp)
     81f:	e8 29 fd ff ff       	call   54d <gettoken>
     824:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     827:	83 ec 08             	sub    $0x8,%esp
     82a:	ff 75 0c             	pushl  0xc(%ebp)
     82d:	ff 75 08             	pushl  0x8(%ebp)
     830:	e8 6d ff ff ff       	call   7a2 <parseline>
     835:	83 c4 10             	add    $0x10,%esp
     838:	83 ec 08             	sub    $0x8,%esp
     83b:	50                   	push   %eax
     83c:	ff 75 f4             	pushl  -0xc(%ebp)
     83f:	e8 82 fc ff ff       	call   4c6 <listcmd>
     844:	83 c4 10             	add    $0x10,%esp
     847:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     84d:	c9                   	leave  
     84e:	c3                   	ret    

0000084f <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     84f:	55                   	push   %ebp
     850:	89 e5                	mov    %esp,%ebp
     852:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     855:	83 ec 08             	sub    $0x8,%esp
     858:	ff 75 0c             	pushl  0xc(%ebp)
     85b:	ff 75 08             	pushl  0x8(%ebp)
     85e:	e8 ec 01 00 00       	call   a4f <parseexec>
     863:	83 c4 10             	add    $0x10,%esp
     866:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     869:	83 ec 04             	sub    $0x4,%esp
     86c:	68 01 1d 00 00       	push   $0x1d01
     871:	ff 75 0c             	pushl  0xc(%ebp)
     874:	ff 75 08             	pushl  0x8(%ebp)
     877:	e8 22 fe ff ff       	call   69e <peek>
     87c:	83 c4 10             	add    $0x10,%esp
     87f:	85 c0                	test   %eax,%eax
     881:	74 35                	je     8b8 <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     883:	6a 00                	push   $0x0
     885:	6a 00                	push   $0x0
     887:	ff 75 0c             	pushl  0xc(%ebp)
     88a:	ff 75 08             	pushl  0x8(%ebp)
     88d:	e8 bb fc ff ff       	call   54d <gettoken>
     892:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     895:	83 ec 08             	sub    $0x8,%esp
     898:	ff 75 0c             	pushl  0xc(%ebp)
     89b:	ff 75 08             	pushl  0x8(%ebp)
     89e:	e8 ac ff ff ff       	call   84f <parsepipe>
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	83 ec 08             	sub    $0x8,%esp
     8a9:	50                   	push   %eax
     8aa:	ff 75 f4             	pushl  -0xc(%ebp)
     8ad:	e8 cc fb ff ff       	call   47e <pipecmd>
     8b2:	83 c4 10             	add    $0x10,%esp
     8b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     8b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     8bb:	c9                   	leave  
     8bc:	c3                   	ret    

000008bd <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8bd:	55                   	push   %ebp
     8be:	89 e5                	mov    %esp,%ebp
     8c0:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8c3:	e9 b6 00 00 00       	jmp    97e <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     8c8:	6a 00                	push   $0x0
     8ca:	6a 00                	push   $0x0
     8cc:	ff 75 10             	pushl  0x10(%ebp)
     8cf:	ff 75 0c             	pushl  0xc(%ebp)
     8d2:	e8 76 fc ff ff       	call   54d <gettoken>
     8d7:	83 c4 10             	add    $0x10,%esp
     8da:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     8dd:	8d 45 ec             	lea    -0x14(%ebp),%eax
     8e0:	50                   	push   %eax
     8e1:	8d 45 f0             	lea    -0x10(%ebp),%eax
     8e4:	50                   	push   %eax
     8e5:	ff 75 10             	pushl  0x10(%ebp)
     8e8:	ff 75 0c             	pushl  0xc(%ebp)
     8eb:	e8 5d fc ff ff       	call   54d <gettoken>
     8f0:	83 c4 10             	add    $0x10,%esp
     8f3:	83 f8 61             	cmp    $0x61,%eax
     8f6:	74 10                	je     908 <parseredirs+0x4b>
      panic("missing file for redirection");
     8f8:	83 ec 0c             	sub    $0xc,%esp
     8fb:	68 03 1d 00 00       	push   $0x1d03
     900:	e8 97 fa ff ff       	call   39c <panic>
     905:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     908:	8b 45 f4             	mov    -0xc(%ebp),%eax
     90b:	83 f8 3c             	cmp    $0x3c,%eax
     90e:	74 0c                	je     91c <parseredirs+0x5f>
     910:	83 f8 3e             	cmp    $0x3e,%eax
     913:	74 26                	je     93b <parseredirs+0x7e>
     915:	83 f8 2b             	cmp    $0x2b,%eax
     918:	74 43                	je     95d <parseredirs+0xa0>
     91a:	eb 62                	jmp    97e <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     91c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     91f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     922:	83 ec 0c             	sub    $0xc,%esp
     925:	6a 00                	push   $0x0
     927:	6a 00                	push   $0x0
     929:	52                   	push   %edx
     92a:	50                   	push   %eax
     92b:	ff 75 08             	pushl  0x8(%ebp)
     92e:	e8 e8 fa ff ff       	call   41b <redircmd>
     933:	83 c4 20             	add    $0x20,%esp
     936:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     939:	eb 43                	jmp    97e <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     93b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     93e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     941:	83 ec 0c             	sub    $0xc,%esp
     944:	6a 01                	push   $0x1
     946:	68 01 02 00 00       	push   $0x201
     94b:	52                   	push   %edx
     94c:	50                   	push   %eax
     94d:	ff 75 08             	pushl  0x8(%ebp)
     950:	e8 c6 fa ff ff       	call   41b <redircmd>
     955:	83 c4 20             	add    $0x20,%esp
     958:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     95b:	eb 21                	jmp    97e <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     95d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     960:	8b 45 f0             	mov    -0x10(%ebp),%eax
     963:	83 ec 0c             	sub    $0xc,%esp
     966:	6a 01                	push   $0x1
     968:	68 01 02 00 00       	push   $0x201
     96d:	52                   	push   %edx
     96e:	50                   	push   %eax
     96f:	ff 75 08             	pushl  0x8(%ebp)
     972:	e8 a4 fa ff ff       	call   41b <redircmd>
     977:	83 c4 20             	add    $0x20,%esp
     97a:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     97d:	90                   	nop
  while(peek(ps, es, "<>")){
     97e:	83 ec 04             	sub    $0x4,%esp
     981:	68 20 1d 00 00       	push   $0x1d20
     986:	ff 75 10             	pushl  0x10(%ebp)
     989:	ff 75 0c             	pushl  0xc(%ebp)
     98c:	e8 0d fd ff ff       	call   69e <peek>
     991:	83 c4 10             	add    $0x10,%esp
     994:	85 c0                	test   %eax,%eax
     996:	0f 85 2c ff ff ff    	jne    8c8 <parseredirs+0xb>
    }
  }
  return cmd;
     99c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     99f:	c9                   	leave  
     9a0:	c3                   	ret    

000009a1 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     9a1:	55                   	push   %ebp
     9a2:	89 e5                	mov    %esp,%ebp
     9a4:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     9a7:	83 ec 04             	sub    $0x4,%esp
     9aa:	68 23 1d 00 00       	push   $0x1d23
     9af:	ff 75 0c             	pushl  0xc(%ebp)
     9b2:	ff 75 08             	pushl  0x8(%ebp)
     9b5:	e8 e4 fc ff ff       	call   69e <peek>
     9ba:	83 c4 10             	add    $0x10,%esp
     9bd:	85 c0                	test   %eax,%eax
     9bf:	75 10                	jne    9d1 <parseblock+0x30>
    panic("parseblock");
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	68 25 1d 00 00       	push   $0x1d25
     9c9:	e8 ce f9 ff ff       	call   39c <panic>
     9ce:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     9d1:	6a 00                	push   $0x0
     9d3:	6a 00                	push   $0x0
     9d5:	ff 75 0c             	pushl  0xc(%ebp)
     9d8:	ff 75 08             	pushl  0x8(%ebp)
     9db:	e8 6d fb ff ff       	call   54d <gettoken>
     9e0:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     9e3:	83 ec 08             	sub    $0x8,%esp
     9e6:	ff 75 0c             	pushl  0xc(%ebp)
     9e9:	ff 75 08             	pushl  0x8(%ebp)
     9ec:	e8 b1 fd ff ff       	call   7a2 <parseline>
     9f1:	83 c4 10             	add    $0x10,%esp
     9f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     9f7:	83 ec 04             	sub    $0x4,%esp
     9fa:	68 30 1d 00 00       	push   $0x1d30
     9ff:	ff 75 0c             	pushl  0xc(%ebp)
     a02:	ff 75 08             	pushl  0x8(%ebp)
     a05:	e8 94 fc ff ff       	call   69e <peek>
     a0a:	83 c4 10             	add    $0x10,%esp
     a0d:	85 c0                	test   %eax,%eax
     a0f:	75 10                	jne    a21 <parseblock+0x80>
    panic("syntax - missing )");
     a11:	83 ec 0c             	sub    $0xc,%esp
     a14:	68 32 1d 00 00       	push   $0x1d32
     a19:	e8 7e f9 ff ff       	call   39c <panic>
     a1e:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     a21:	6a 00                	push   $0x0
     a23:	6a 00                	push   $0x0
     a25:	ff 75 0c             	pushl  0xc(%ebp)
     a28:	ff 75 08             	pushl  0x8(%ebp)
     a2b:	e8 1d fb ff ff       	call   54d <gettoken>
     a30:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     a33:	83 ec 04             	sub    $0x4,%esp
     a36:	ff 75 0c             	pushl  0xc(%ebp)
     a39:	ff 75 08             	pushl  0x8(%ebp)
     a3c:	ff 75 f4             	pushl  -0xc(%ebp)
     a3f:	e8 79 fe ff ff       	call   8bd <parseredirs>
     a44:	83 c4 10             	add    $0x10,%esp
     a47:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a4d:	c9                   	leave  
     a4e:	c3                   	ret    

00000a4f <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     a4f:	55                   	push   %ebp
     a50:	89 e5                	mov    %esp,%ebp
     a52:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     a55:	83 ec 04             	sub    $0x4,%esp
     a58:	68 23 1d 00 00       	push   $0x1d23
     a5d:	ff 75 0c             	pushl  0xc(%ebp)
     a60:	ff 75 08             	pushl  0x8(%ebp)
     a63:	e8 36 fc ff ff       	call   69e <peek>
     a68:	83 c4 10             	add    $0x10,%esp
     a6b:	85 c0                	test   %eax,%eax
     a6d:	74 16                	je     a85 <parseexec+0x36>
    return parseblock(ps, es);
     a6f:	83 ec 08             	sub    $0x8,%esp
     a72:	ff 75 0c             	pushl  0xc(%ebp)
     a75:	ff 75 08             	pushl  0x8(%ebp)
     a78:	e8 24 ff ff ff       	call   9a1 <parseblock>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	e9 fb 00 00 00       	jmp    b80 <parseexec+0x131>

  ret = execcmd();
     a85:	e8 5b f9 ff ff       	call   3e5 <execcmd>
     a8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a90:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     a93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     a9a:	83 ec 04             	sub    $0x4,%esp
     a9d:	ff 75 0c             	pushl  0xc(%ebp)
     aa0:	ff 75 08             	pushl  0x8(%ebp)
     aa3:	ff 75 f0             	pushl  -0x10(%ebp)
     aa6:	e8 12 fe ff ff       	call   8bd <parseredirs>
     aab:	83 c4 10             	add    $0x10,%esp
     aae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     ab1:	e9 87 00 00 00       	jmp    b3d <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     ab6:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ab9:	50                   	push   %eax
     aba:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     abd:	50                   	push   %eax
     abe:	ff 75 0c             	pushl  0xc(%ebp)
     ac1:	ff 75 08             	pushl  0x8(%ebp)
     ac4:	e8 84 fa ff ff       	call   54d <gettoken>
     ac9:	83 c4 10             	add    $0x10,%esp
     acc:	89 45 e8             	mov    %eax,-0x18(%ebp)
     acf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ad3:	0f 84 84 00 00 00    	je     b5d <parseexec+0x10e>
      break;
    if(tok != 'a')
     ad9:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     add:	74 10                	je     aef <parseexec+0xa0>
      panic("syntax");
     adf:	83 ec 0c             	sub    $0xc,%esp
     ae2:	68 f6 1c 00 00       	push   $0x1cf6
     ae7:	e8 b0 f8 ff ff       	call   39c <panic>
     aec:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     aef:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     af2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     af5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     af8:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     afc:	8b 55 e0             	mov    -0x20(%ebp),%edx
     aff:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b02:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     b05:	83 c1 08             	add    $0x8,%ecx
     b08:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     b0c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     b10:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     b14:	7e 10                	jle    b26 <parseexec+0xd7>
      panic("too many args");
     b16:	83 ec 0c             	sub    $0xc,%esp
     b19:	68 45 1d 00 00       	push   $0x1d45
     b1e:	e8 79 f8 ff ff       	call   39c <panic>
     b23:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     b26:	83 ec 04             	sub    $0x4,%esp
     b29:	ff 75 0c             	pushl  0xc(%ebp)
     b2c:	ff 75 08             	pushl  0x8(%ebp)
     b2f:	ff 75 f0             	pushl  -0x10(%ebp)
     b32:	e8 86 fd ff ff       	call   8bd <parseredirs>
     b37:	83 c4 10             	add    $0x10,%esp
     b3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     b3d:	83 ec 04             	sub    $0x4,%esp
     b40:	68 53 1d 00 00       	push   $0x1d53
     b45:	ff 75 0c             	pushl  0xc(%ebp)
     b48:	ff 75 08             	pushl  0x8(%ebp)
     b4b:	e8 4e fb ff ff       	call   69e <peek>
     b50:	83 c4 10             	add    $0x10,%esp
     b53:	85 c0                	test   %eax,%eax
     b55:	0f 84 5b ff ff ff    	je     ab6 <parseexec+0x67>
     b5b:	eb 01                	jmp    b5e <parseexec+0x10f>
      break;
     b5d:	90                   	nop
  }
  cmd->argv[argc] = 0;
     b5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b61:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b64:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     b6b:	00 
  cmd->eargv[argc] = 0;
     b6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     b72:	83 c2 08             	add    $0x8,%edx
     b75:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     b7c:	00 
  return ret;
     b7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     b80:	c9                   	leave  
     b81:	c3                   	ret    

00000b82 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     b82:	55                   	push   %ebp
     b83:	89 e5                	mov    %esp,%ebp
     b85:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     b88:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     b8c:	75 0a                	jne    b98 <nulterminate+0x16>
    return 0;
     b8e:	b8 00 00 00 00       	mov    $0x0,%eax
     b93:	e9 e4 00 00 00       	jmp    c7c <nulterminate+0xfa>

  switch(cmd->type){
     b98:	8b 45 08             	mov    0x8(%ebp),%eax
     b9b:	8b 00                	mov    (%eax),%eax
     b9d:	83 f8 05             	cmp    $0x5,%eax
     ba0:	0f 87 d3 00 00 00    	ja     c79 <nulterminate+0xf7>
     ba6:	8b 04 85 58 1d 00 00 	mov    0x1d58(,%eax,4),%eax
     bad:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     baf:	8b 45 08             	mov    0x8(%ebp),%eax
     bb2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     bb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bbc:	eb 14                	jmp    bd2 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     bbe:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bc1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bc4:	83 c2 08             	add    $0x8,%edx
     bc7:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     bcb:	c6 00 00             	movb   $0x0,(%eax)
    for(i=0; ecmd->argv[i]; i++)
     bce:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     bd2:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bd8:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     bdc:	85 c0                	test   %eax,%eax
     bde:	75 de                	jne    bbe <nulterminate+0x3c>
    break;
     be0:	e9 94 00 00 00       	jmp    c79 <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     be5:	8b 45 08             	mov    0x8(%ebp),%eax
     be8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(rcmd->cmd);
     beb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bee:	8b 40 04             	mov    0x4(%eax),%eax
     bf1:	83 ec 0c             	sub    $0xc,%esp
     bf4:	50                   	push   %eax
     bf5:	e8 88 ff ff ff       	call   b82 <nulterminate>
     bfa:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     bfd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c00:	8b 40 0c             	mov    0xc(%eax),%eax
     c03:	c6 00 00             	movb   $0x0,(%eax)
    break;
     c06:	eb 71                	jmp    c79 <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     c08:	8b 45 08             	mov    0x8(%ebp),%eax
     c0b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     c0e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c11:	8b 40 04             	mov    0x4(%eax),%eax
     c14:	83 ec 0c             	sub    $0xc,%esp
     c17:	50                   	push   %eax
     c18:	e8 65 ff ff ff       	call   b82 <nulterminate>
     c1d:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     c20:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c23:	8b 40 08             	mov    0x8(%eax),%eax
     c26:	83 ec 0c             	sub    $0xc,%esp
     c29:	50                   	push   %eax
     c2a:	e8 53 ff ff ff       	call   b82 <nulterminate>
     c2f:	83 c4 10             	add    $0x10,%esp
    break;
     c32:	eb 45                	jmp    c79 <nulterminate+0xf7>

  case LIST:
    lcmd = (struct listcmd*)cmd;
     c34:	8b 45 08             	mov    0x8(%ebp),%eax
     c37:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(lcmd->left);
     c3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c3d:	8b 40 04             	mov    0x4(%eax),%eax
     c40:	83 ec 0c             	sub    $0xc,%esp
     c43:	50                   	push   %eax
     c44:	e8 39 ff ff ff       	call   b82 <nulterminate>
     c49:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     c4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c4f:	8b 40 08             	mov    0x8(%eax),%eax
     c52:	83 ec 0c             	sub    $0xc,%esp
     c55:	50                   	push   %eax
     c56:	e8 27 ff ff ff       	call   b82 <nulterminate>
     c5b:	83 c4 10             	add    $0x10,%esp
    break;
     c5e:	eb 19                	jmp    c79 <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     c60:	8b 45 08             	mov    0x8(%ebp),%eax
     c63:	89 45 f0             	mov    %eax,-0x10(%ebp)
    nulterminate(bcmd->cmd);
     c66:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c69:	8b 40 04             	mov    0x4(%eax),%eax
     c6c:	83 ec 0c             	sub    $0xc,%esp
     c6f:	50                   	push   %eax
     c70:	e8 0d ff ff ff       	call   b82 <nulterminate>
     c75:	83 c4 10             	add    $0x10,%esp
    break;
     c78:	90                   	nop
  }
  return cmd;
     c79:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c7c:	c9                   	leave  
     c7d:	c3                   	ret    

00000c7e <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
     c7e:	55                   	push   %ebp
     c7f:	89 e5                	mov    %esp,%ebp
     c81:	57                   	push   %edi
     c82:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     c83:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c86:	8b 55 10             	mov    0x10(%ebp),%edx
     c89:	8b 45 0c             	mov    0xc(%ebp),%eax
     c8c:	89 cb                	mov    %ecx,%ebx
     c8e:	89 df                	mov    %ebx,%edi
     c90:	89 d1                	mov    %edx,%ecx
     c92:	fc                   	cld    
     c93:	f3 aa                	rep stos %al,%es:(%edi)
     c95:	89 ca                	mov    %ecx,%edx
     c97:	89 fb                	mov    %edi,%ebx
     c99:	89 5d 08             	mov    %ebx,0x8(%ebp)
     c9c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     c9f:	90                   	nop
     ca0:	5b                   	pop    %ebx
     ca1:	5f                   	pop    %edi
     ca2:	5d                   	pop    %ebp
     ca3:	c3                   	ret    

00000ca4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     ca4:	55                   	push   %ebp
     ca5:	89 e5                	mov    %esp,%ebp
     ca7:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     caa:	8b 45 08             	mov    0x8(%ebp),%eax
     cad:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     cb0:	90                   	nop
     cb1:	8b 55 0c             	mov    0xc(%ebp),%edx
     cb4:	8d 42 01             	lea    0x1(%edx),%eax
     cb7:	89 45 0c             	mov    %eax,0xc(%ebp)
     cba:	8b 45 08             	mov    0x8(%ebp),%eax
     cbd:	8d 48 01             	lea    0x1(%eax),%ecx
     cc0:	89 4d 08             	mov    %ecx,0x8(%ebp)
     cc3:	0f b6 12             	movzbl (%edx),%edx
     cc6:	88 10                	mov    %dl,(%eax)
     cc8:	0f b6 00             	movzbl (%eax),%eax
     ccb:	84 c0                	test   %al,%al
     ccd:	75 e2                	jne    cb1 <strcpy+0xd>
    ;
  return os;
     ccf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     cd2:	c9                   	leave  
     cd3:	c3                   	ret    

00000cd4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     cd4:	55                   	push   %ebp
     cd5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     cd7:	eb 08                	jmp    ce1 <strcmp+0xd>
    p++, q++;
     cd9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cdd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     ce1:	8b 45 08             	mov    0x8(%ebp),%eax
     ce4:	0f b6 00             	movzbl (%eax),%eax
     ce7:	84 c0                	test   %al,%al
     ce9:	74 10                	je     cfb <strcmp+0x27>
     ceb:	8b 45 08             	mov    0x8(%ebp),%eax
     cee:	0f b6 10             	movzbl (%eax),%edx
     cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
     cf4:	0f b6 00             	movzbl (%eax),%eax
     cf7:	38 c2                	cmp    %al,%dl
     cf9:	74 de                	je     cd9 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     cfb:	8b 45 08             	mov    0x8(%ebp),%eax
     cfe:	0f b6 00             	movzbl (%eax),%eax
     d01:	0f b6 d0             	movzbl %al,%edx
     d04:	8b 45 0c             	mov    0xc(%ebp),%eax
     d07:	0f b6 00             	movzbl (%eax),%eax
     d0a:	0f b6 c0             	movzbl %al,%eax
     d0d:	29 c2                	sub    %eax,%edx
     d0f:	89 d0                	mov    %edx,%eax
}
     d11:	5d                   	pop    %ebp
     d12:	c3                   	ret    

00000d13 <strlen>:

uint
strlen(char *s)
{
     d13:	55                   	push   %ebp
     d14:	89 e5                	mov    %esp,%ebp
     d16:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     d19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     d20:	eb 04                	jmp    d26 <strlen+0x13>
     d22:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     d26:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d29:	8b 45 08             	mov    0x8(%ebp),%eax
     d2c:	01 d0                	add    %edx,%eax
     d2e:	0f b6 00             	movzbl (%eax),%eax
     d31:	84 c0                	test   %al,%al
     d33:	75 ed                	jne    d22 <strlen+0xf>
    ;
  return n;
     d35:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     d38:	c9                   	leave  
     d39:	c3                   	ret    

00000d3a <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     d3a:	55                   	push   %ebp
     d3b:	89 e5                	mov    %esp,%ebp
     d3d:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     d40:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     d47:	eb 0c                	jmp    d55 <strnlen+0x1b>
     n++; 
     d49:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     d4d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d51:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     d55:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d59:	74 0a                	je     d65 <strnlen+0x2b>
     d5b:	8b 45 08             	mov    0x8(%ebp),%eax
     d5e:	0f b6 00             	movzbl (%eax),%eax
     d61:	84 c0                	test   %al,%al
     d63:	75 e4                	jne    d49 <strnlen+0xf>
   return n; 
     d65:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     d68:	c9                   	leave  
     d69:	c3                   	ret    

00000d6a <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     d6a:	55                   	push   %ebp
     d6b:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     d6d:	8b 45 10             	mov    0x10(%ebp),%eax
     d70:	50                   	push   %eax
     d71:	ff 75 0c             	pushl  0xc(%ebp)
     d74:	ff 75 08             	pushl  0x8(%ebp)
     d77:	e8 02 ff ff ff       	call   c7e <stosb>
     d7c:	83 c4 0c             	add    $0xc,%esp
  return dst;
     d7f:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d82:	c9                   	leave  
     d83:	c3                   	ret    

00000d84 <strchr>:

char*
strchr(const char *s, char c)
{
     d84:	55                   	push   %ebp
     d85:	89 e5                	mov    %esp,%ebp
     d87:	83 ec 04             	sub    $0x4,%esp
     d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d8d:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     d90:	eb 14                	jmp    da6 <strchr+0x22>
    if(*s == c)
     d92:	8b 45 08             	mov    0x8(%ebp),%eax
     d95:	0f b6 00             	movzbl (%eax),%eax
     d98:	38 45 fc             	cmp    %al,-0x4(%ebp)
     d9b:	75 05                	jne    da2 <strchr+0x1e>
      return (char*)s;
     d9d:	8b 45 08             	mov    0x8(%ebp),%eax
     da0:	eb 13                	jmp    db5 <strchr+0x31>
  for(; *s; s++)
     da2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     da6:	8b 45 08             	mov    0x8(%ebp),%eax
     da9:	0f b6 00             	movzbl (%eax),%eax
     dac:	84 c0                	test   %al,%al
     dae:	75 e2                	jne    d92 <strchr+0xe>
  return 0;
     db0:	b8 00 00 00 00       	mov    $0x0,%eax
}
     db5:	c9                   	leave  
     db6:	c3                   	ret    

00000db7 <gets>:

char*
gets(char *buf, int max)
{
     db7:	55                   	push   %ebp
     db8:	89 e5                	mov    %esp,%ebp
     dba:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     dbd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     dc4:	eb 42                	jmp    e08 <gets+0x51>
    cc = read(0, &c, 1);
     dc6:	83 ec 04             	sub    $0x4,%esp
     dc9:	6a 01                	push   $0x1
     dcb:	8d 45 ef             	lea    -0x11(%ebp),%eax
     dce:	50                   	push   %eax
     dcf:	6a 00                	push   $0x0
     dd1:	e8 47 01 00 00       	call   f1d <read>
     dd6:	83 c4 10             	add    $0x10,%esp
     dd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     ddc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     de0:	7e 33                	jle    e15 <gets+0x5e>
      break;
    buf[i++] = c;
     de2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de5:	8d 50 01             	lea    0x1(%eax),%edx
     de8:	89 55 f4             	mov    %edx,-0xc(%ebp)
     deb:	89 c2                	mov    %eax,%edx
     ded:	8b 45 08             	mov    0x8(%ebp),%eax
     df0:	01 c2                	add    %eax,%edx
     df2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     df6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     df8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     dfc:	3c 0a                	cmp    $0xa,%al
     dfe:	74 16                	je     e16 <gets+0x5f>
     e00:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     e04:	3c 0d                	cmp    $0xd,%al
     e06:	74 0e                	je     e16 <gets+0x5f>
  for(i=0; i+1 < max; ){
     e08:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e0b:	83 c0 01             	add    $0x1,%eax
     e0e:	39 45 0c             	cmp    %eax,0xc(%ebp)
     e11:	7f b3                	jg     dc6 <gets+0xf>
     e13:	eb 01                	jmp    e16 <gets+0x5f>
      break;
     e15:	90                   	nop
      break;
  }
  buf[i] = '\0';
     e16:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e19:	8b 45 08             	mov    0x8(%ebp),%eax
     e1c:	01 d0                	add    %edx,%eax
     e1e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     e21:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e24:	c9                   	leave  
     e25:	c3                   	ret    

00000e26 <stat>:

int
stat(char *n, struct stat *st)
{
     e26:	55                   	push   %ebp
     e27:	89 e5                	mov    %esp,%ebp
     e29:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     e2c:	83 ec 08             	sub    $0x8,%esp
     e2f:	6a 00                	push   $0x0
     e31:	ff 75 08             	pushl  0x8(%ebp)
     e34:	e8 0c 01 00 00       	call   f45 <open>
     e39:	83 c4 10             	add    $0x10,%esp
     e3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     e3f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e43:	79 07                	jns    e4c <stat+0x26>
    return -1;
     e45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e4a:	eb 25                	jmp    e71 <stat+0x4b>
  r = fstat(fd, st);
     e4c:	83 ec 08             	sub    $0x8,%esp
     e4f:	ff 75 0c             	pushl  0xc(%ebp)
     e52:	ff 75 f4             	pushl  -0xc(%ebp)
     e55:	e8 03 01 00 00       	call   f5d <fstat>
     e5a:	83 c4 10             	add    $0x10,%esp
     e5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     e60:	83 ec 0c             	sub    $0xc,%esp
     e63:	ff 75 f4             	pushl  -0xc(%ebp)
     e66:	e8 c2 00 00 00       	call   f2d <close>
     e6b:	83 c4 10             	add    $0x10,%esp
  return r;
     e6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     e71:	c9                   	leave  
     e72:	c3                   	ret    

00000e73 <atoi>:

int
atoi(const char *s)
{
     e73:	55                   	push   %ebp
     e74:	89 e5                	mov    %esp,%ebp
     e76:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     e79:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     e80:	eb 25                	jmp    ea7 <atoi+0x34>
    n = n*10 + *s++ - '0';
     e82:	8b 55 fc             	mov    -0x4(%ebp),%edx
     e85:	89 d0                	mov    %edx,%eax
     e87:	c1 e0 02             	shl    $0x2,%eax
     e8a:	01 d0                	add    %edx,%eax
     e8c:	01 c0                	add    %eax,%eax
     e8e:	89 c1                	mov    %eax,%ecx
     e90:	8b 45 08             	mov    0x8(%ebp),%eax
     e93:	8d 50 01             	lea    0x1(%eax),%edx
     e96:	89 55 08             	mov    %edx,0x8(%ebp)
     e99:	0f b6 00             	movzbl (%eax),%eax
     e9c:	0f be c0             	movsbl %al,%eax
     e9f:	01 c8                	add    %ecx,%eax
     ea1:	83 e8 30             	sub    $0x30,%eax
     ea4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     ea7:	8b 45 08             	mov    0x8(%ebp),%eax
     eaa:	0f b6 00             	movzbl (%eax),%eax
     ead:	3c 2f                	cmp    $0x2f,%al
     eaf:	7e 0a                	jle    ebb <atoi+0x48>
     eb1:	8b 45 08             	mov    0x8(%ebp),%eax
     eb4:	0f b6 00             	movzbl (%eax),%eax
     eb7:	3c 39                	cmp    $0x39,%al
     eb9:	7e c7                	jle    e82 <atoi+0xf>
  return n;
     ebb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     ebe:	c9                   	leave  
     ebf:	c3                   	ret    

00000ec0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     ec0:	55                   	push   %ebp
     ec1:	89 e5                	mov    %esp,%ebp
     ec3:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     ec6:	8b 45 08             	mov    0x8(%ebp),%eax
     ec9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     ed2:	eb 17                	jmp    eeb <memmove+0x2b>
    *dst++ = *src++;
     ed4:	8b 55 f8             	mov    -0x8(%ebp),%edx
     ed7:	8d 42 01             	lea    0x1(%edx),%eax
     eda:	89 45 f8             	mov    %eax,-0x8(%ebp)
     edd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ee0:	8d 48 01             	lea    0x1(%eax),%ecx
     ee3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     ee6:	0f b6 12             	movzbl (%edx),%edx
     ee9:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     eeb:	8b 45 10             	mov    0x10(%ebp),%eax
     eee:	8d 50 ff             	lea    -0x1(%eax),%edx
     ef1:	89 55 10             	mov    %edx,0x10(%ebp)
     ef4:	85 c0                	test   %eax,%eax
     ef6:	7f dc                	jg     ed4 <memmove+0x14>
  return vdst;
     ef8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     efb:	c9                   	leave  
     efc:	c3                   	ret    

00000efd <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     efd:	b8 01 00 00 00       	mov    $0x1,%eax
     f02:	cd 40                	int    $0x40
     f04:	c3                   	ret    

00000f05 <exit>:
SYSCALL(exit)
     f05:	b8 02 00 00 00       	mov    $0x2,%eax
     f0a:	cd 40                	int    $0x40
     f0c:	c3                   	ret    

00000f0d <wait>:
SYSCALL(wait)
     f0d:	b8 03 00 00 00       	mov    $0x3,%eax
     f12:	cd 40                	int    $0x40
     f14:	c3                   	ret    

00000f15 <pipe>:
SYSCALL(pipe)
     f15:	b8 04 00 00 00       	mov    $0x4,%eax
     f1a:	cd 40                	int    $0x40
     f1c:	c3                   	ret    

00000f1d <read>:
SYSCALL(read)
     f1d:	b8 05 00 00 00       	mov    $0x5,%eax
     f22:	cd 40                	int    $0x40
     f24:	c3                   	ret    

00000f25 <write>:
SYSCALL(write)
     f25:	b8 10 00 00 00       	mov    $0x10,%eax
     f2a:	cd 40                	int    $0x40
     f2c:	c3                   	ret    

00000f2d <close>:
SYSCALL(close)
     f2d:	b8 15 00 00 00       	mov    $0x15,%eax
     f32:	cd 40                	int    $0x40
     f34:	c3                   	ret    

00000f35 <kill>:
SYSCALL(kill)
     f35:	b8 06 00 00 00       	mov    $0x6,%eax
     f3a:	cd 40                	int    $0x40
     f3c:	c3                   	ret    

00000f3d <exec>:
SYSCALL(exec)
     f3d:	b8 07 00 00 00       	mov    $0x7,%eax
     f42:	cd 40                	int    $0x40
     f44:	c3                   	ret    

00000f45 <open>:
SYSCALL(open)
     f45:	b8 0f 00 00 00       	mov    $0xf,%eax
     f4a:	cd 40                	int    $0x40
     f4c:	c3                   	ret    

00000f4d <mknod>:
SYSCALL(mknod)
     f4d:	b8 11 00 00 00       	mov    $0x11,%eax
     f52:	cd 40                	int    $0x40
     f54:	c3                   	ret    

00000f55 <unlink>:
SYSCALL(unlink)
     f55:	b8 12 00 00 00       	mov    $0x12,%eax
     f5a:	cd 40                	int    $0x40
     f5c:	c3                   	ret    

00000f5d <fstat>:
SYSCALL(fstat)
     f5d:	b8 08 00 00 00       	mov    $0x8,%eax
     f62:	cd 40                	int    $0x40
     f64:	c3                   	ret    

00000f65 <link>:
SYSCALL(link)
     f65:	b8 13 00 00 00       	mov    $0x13,%eax
     f6a:	cd 40                	int    $0x40
     f6c:	c3                   	ret    

00000f6d <mkdir>:
SYSCALL(mkdir)
     f6d:	b8 14 00 00 00       	mov    $0x14,%eax
     f72:	cd 40                	int    $0x40
     f74:	c3                   	ret    

00000f75 <chdir>:
SYSCALL(chdir)
     f75:	b8 09 00 00 00       	mov    $0x9,%eax
     f7a:	cd 40                	int    $0x40
     f7c:	c3                   	ret    

00000f7d <dup>:
SYSCALL(dup)
     f7d:	b8 0a 00 00 00       	mov    $0xa,%eax
     f82:	cd 40                	int    $0x40
     f84:	c3                   	ret    

00000f85 <getpid>:
SYSCALL(getpid)
     f85:	b8 0b 00 00 00       	mov    $0xb,%eax
     f8a:	cd 40                	int    $0x40
     f8c:	c3                   	ret    

00000f8d <sbrk>:
SYSCALL(sbrk)
     f8d:	b8 0c 00 00 00       	mov    $0xc,%eax
     f92:	cd 40                	int    $0x40
     f94:	c3                   	ret    

00000f95 <sleep>:
SYSCALL(sleep)
     f95:	b8 0d 00 00 00       	mov    $0xd,%eax
     f9a:	cd 40                	int    $0x40
     f9c:	c3                   	ret    

00000f9d <uptime>:
SYSCALL(uptime)
     f9d:	b8 0e 00 00 00       	mov    $0xe,%eax
     fa2:	cd 40                	int    $0x40
     fa4:	c3                   	ret    

00000fa5 <select>:
SYSCALL(select)
     fa5:	b8 16 00 00 00       	mov    $0x16,%eax
     faa:	cd 40                	int    $0x40
     fac:	c3                   	ret    

00000fad <arp>:
SYSCALL(arp)
     fad:	b8 17 00 00 00       	mov    $0x17,%eax
     fb2:	cd 40                	int    $0x40
     fb4:	c3                   	ret    

00000fb5 <arpserv>:
SYSCALL(arpserv)
     fb5:	b8 18 00 00 00       	mov    $0x18,%eax
     fba:	cd 40                	int    $0x40
     fbc:	c3                   	ret    

00000fbd <arp_receive>:
SYSCALL(arp_receive)
     fbd:	b8 19 00 00 00       	mov    $0x19,%eax
     fc2:	cd 40                	int    $0x40
     fc4:	c3                   	ret    

00000fc5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     fc5:	55                   	push   %ebp
     fc6:	89 e5                	mov    %esp,%ebp
     fc8:	83 ec 18             	sub    $0x18,%esp
     fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
     fce:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     fd1:	83 ec 04             	sub    $0x4,%esp
     fd4:	6a 01                	push   $0x1
     fd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
     fd9:	50                   	push   %eax
     fda:	ff 75 08             	pushl  0x8(%ebp)
     fdd:	e8 43 ff ff ff       	call   f25 <write>
     fe2:	83 c4 10             	add    $0x10,%esp
}
     fe5:	90                   	nop
     fe6:	c9                   	leave  
     fe7:	c3                   	ret    

00000fe8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fe8:	55                   	push   %ebp
     fe9:	89 e5                	mov    %esp,%ebp
     feb:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     fee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     ff5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     ff9:	74 17                	je     1012 <printint+0x2a>
     ffb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     fff:	79 11                	jns    1012 <printint+0x2a>
    neg = 1;
    1001:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1008:	8b 45 0c             	mov    0xc(%ebp),%eax
    100b:	f7 d8                	neg    %eax
    100d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1010:	eb 06                	jmp    1018 <printint+0x30>
  } else {
    x = xx;
    1012:	8b 45 0c             	mov    0xc(%ebp),%eax
    1015:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    1018:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    101f:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1022:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1025:	ba 00 00 00 00       	mov    $0x0,%edx
    102a:	f7 f1                	div    %ecx
    102c:	89 d1                	mov    %edx,%ecx
    102e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1031:	8d 50 01             	lea    0x1(%eax),%edx
    1034:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1037:	0f b6 91 58 26 00 00 	movzbl 0x2658(%ecx),%edx
    103e:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1042:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1045:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1048:	ba 00 00 00 00       	mov    $0x0,%edx
    104d:	f7 f1                	div    %ecx
    104f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1052:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1056:	75 c7                	jne    101f <printint+0x37>
  if(neg)
    1058:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    105c:	74 2d                	je     108b <printint+0xa3>
    buf[i++] = '-';
    105e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1061:	8d 50 01             	lea    0x1(%eax),%edx
    1064:	89 55 f4             	mov    %edx,-0xc(%ebp)
    1067:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    106c:	eb 1d                	jmp    108b <printint+0xa3>
    putc(fd, buf[i]);
    106e:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1071:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1074:	01 d0                	add    %edx,%eax
    1076:	0f b6 00             	movzbl (%eax),%eax
    1079:	0f be c0             	movsbl %al,%eax
    107c:	83 ec 08             	sub    $0x8,%esp
    107f:	50                   	push   %eax
    1080:	ff 75 08             	pushl  0x8(%ebp)
    1083:	e8 3d ff ff ff       	call   fc5 <putc>
    1088:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    108b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    108f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1093:	79 d9                	jns    106e <printint+0x86>
}
    1095:	90                   	nop
    1096:	c9                   	leave  
    1097:	c3                   	ret    

00001098 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1098:	55                   	push   %ebp
    1099:	89 e5                	mov    %esp,%ebp
    109b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    109e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    10a5:	8d 45 0c             	lea    0xc(%ebp),%eax
    10a8:	83 c0 04             	add    $0x4,%eax
    10ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    10ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    10b5:	e9 59 01 00 00       	jmp    1213 <printf+0x17b>
    c = fmt[i] & 0xff;
    10ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    10bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    10c0:	01 d0                	add    %edx,%eax
    10c2:	0f b6 00             	movzbl (%eax),%eax
    10c5:	0f be c0             	movsbl %al,%eax
    10c8:	25 ff 00 00 00       	and    $0xff,%eax
    10cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    10d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    10d4:	75 2c                	jne    1102 <printf+0x6a>
      if(c == '%'){
    10d6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    10da:	75 0c                	jne    10e8 <printf+0x50>
        state = '%';
    10dc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    10e3:	e9 27 01 00 00       	jmp    120f <printf+0x177>
      } else {
        putc(fd, c);
    10e8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10eb:	0f be c0             	movsbl %al,%eax
    10ee:	83 ec 08             	sub    $0x8,%esp
    10f1:	50                   	push   %eax
    10f2:	ff 75 08             	pushl  0x8(%ebp)
    10f5:	e8 cb fe ff ff       	call   fc5 <putc>
    10fa:	83 c4 10             	add    $0x10,%esp
    10fd:	e9 0d 01 00 00       	jmp    120f <printf+0x177>
      }
    } else if(state == '%'){
    1102:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1106:	0f 85 03 01 00 00    	jne    120f <printf+0x177>
      if(c == 'd'){
    110c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1110:	75 1e                	jne    1130 <printf+0x98>
        printint(fd, *ap, 10, 1);
    1112:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1115:	8b 00                	mov    (%eax),%eax
    1117:	6a 01                	push   $0x1
    1119:	6a 0a                	push   $0xa
    111b:	50                   	push   %eax
    111c:	ff 75 08             	pushl  0x8(%ebp)
    111f:	e8 c4 fe ff ff       	call   fe8 <printint>
    1124:	83 c4 10             	add    $0x10,%esp
        ap++;
    1127:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    112b:	e9 d8 00 00 00       	jmp    1208 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1130:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    1134:	74 06                	je     113c <printf+0xa4>
    1136:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    113a:	75 1e                	jne    115a <printf+0xc2>
        printint(fd, *ap, 16, 0);
    113c:	8b 45 e8             	mov    -0x18(%ebp),%eax
    113f:	8b 00                	mov    (%eax),%eax
    1141:	6a 00                	push   $0x0
    1143:	6a 10                	push   $0x10
    1145:	50                   	push   %eax
    1146:	ff 75 08             	pushl  0x8(%ebp)
    1149:	e8 9a fe ff ff       	call   fe8 <printint>
    114e:	83 c4 10             	add    $0x10,%esp
        ap++;
    1151:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1155:	e9 ae 00 00 00       	jmp    1208 <printf+0x170>
      } else if(c == 's'){
    115a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    115e:	75 43                	jne    11a3 <printf+0x10b>
        s = (char*)*ap;
    1160:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1163:	8b 00                	mov    (%eax),%eax
    1165:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1168:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    116c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1170:	75 25                	jne    1197 <printf+0xff>
          s = "(null)";
    1172:	c7 45 f4 70 1d 00 00 	movl   $0x1d70,-0xc(%ebp)
        while(*s != 0){
    1179:	eb 1c                	jmp    1197 <printf+0xff>
          putc(fd, *s);
    117b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    117e:	0f b6 00             	movzbl (%eax),%eax
    1181:	0f be c0             	movsbl %al,%eax
    1184:	83 ec 08             	sub    $0x8,%esp
    1187:	50                   	push   %eax
    1188:	ff 75 08             	pushl  0x8(%ebp)
    118b:	e8 35 fe ff ff       	call   fc5 <putc>
    1190:	83 c4 10             	add    $0x10,%esp
          s++;
    1193:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1197:	8b 45 f4             	mov    -0xc(%ebp),%eax
    119a:	0f b6 00             	movzbl (%eax),%eax
    119d:	84 c0                	test   %al,%al
    119f:	75 da                	jne    117b <printf+0xe3>
    11a1:	eb 65                	jmp    1208 <printf+0x170>
        }
      } else if(c == 'c'){
    11a3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    11a7:	75 1d                	jne    11c6 <printf+0x12e>
        putc(fd, *ap);
    11a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    11ac:	8b 00                	mov    (%eax),%eax
    11ae:	0f be c0             	movsbl %al,%eax
    11b1:	83 ec 08             	sub    $0x8,%esp
    11b4:	50                   	push   %eax
    11b5:	ff 75 08             	pushl  0x8(%ebp)
    11b8:	e8 08 fe ff ff       	call   fc5 <putc>
    11bd:	83 c4 10             	add    $0x10,%esp
        ap++;
    11c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    11c4:	eb 42                	jmp    1208 <printf+0x170>
      } else if(c == '%'){
    11c6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    11ca:	75 17                	jne    11e3 <printf+0x14b>
        putc(fd, c);
    11cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11cf:	0f be c0             	movsbl %al,%eax
    11d2:	83 ec 08             	sub    $0x8,%esp
    11d5:	50                   	push   %eax
    11d6:	ff 75 08             	pushl  0x8(%ebp)
    11d9:	e8 e7 fd ff ff       	call   fc5 <putc>
    11de:	83 c4 10             	add    $0x10,%esp
    11e1:	eb 25                	jmp    1208 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    11e3:	83 ec 08             	sub    $0x8,%esp
    11e6:	6a 25                	push   $0x25
    11e8:	ff 75 08             	pushl  0x8(%ebp)
    11eb:	e8 d5 fd ff ff       	call   fc5 <putc>
    11f0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    11f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    11f6:	0f be c0             	movsbl %al,%eax
    11f9:	83 ec 08             	sub    $0x8,%esp
    11fc:	50                   	push   %eax
    11fd:	ff 75 08             	pushl  0x8(%ebp)
    1200:	e8 c0 fd ff ff       	call   fc5 <putc>
    1205:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1208:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    120f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1213:	8b 55 0c             	mov    0xc(%ebp),%edx
    1216:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1219:	01 d0                	add    %edx,%eax
    121b:	0f b6 00             	movzbl (%eax),%eax
    121e:	84 c0                	test   %al,%al
    1220:	0f 85 94 fe ff ff    	jne    10ba <printf+0x22>
    }
  }
}
    1226:	90                   	nop
    1227:	c9                   	leave  
    1228:	c3                   	ret    

00001229 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1229:	55                   	push   %ebp
    122a:	89 e5                	mov    %esp,%ebp
    122c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    122f:	8b 45 08             	mov    0x8(%ebp),%eax
    1232:	83 e8 08             	sub    $0x8,%eax
    1235:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1238:	a1 ec 26 00 00       	mov    0x26ec,%eax
    123d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1240:	eb 24                	jmp    1266 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1242:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1245:	8b 00                	mov    (%eax),%eax
    1247:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    124a:	72 12                	jb     125e <free+0x35>
    124c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    124f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1252:	77 24                	ja     1278 <free+0x4f>
    1254:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1257:	8b 00                	mov    (%eax),%eax
    1259:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    125c:	72 1a                	jb     1278 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    125e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1261:	8b 00                	mov    (%eax),%eax
    1263:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1266:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1269:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    126c:	76 d4                	jbe    1242 <free+0x19>
    126e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1271:	8b 00                	mov    (%eax),%eax
    1273:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1276:	73 ca                	jae    1242 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1278:	8b 45 f8             	mov    -0x8(%ebp),%eax
    127b:	8b 40 04             	mov    0x4(%eax),%eax
    127e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1285:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1288:	01 c2                	add    %eax,%edx
    128a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    128d:	8b 00                	mov    (%eax),%eax
    128f:	39 c2                	cmp    %eax,%edx
    1291:	75 24                	jne    12b7 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    1293:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1296:	8b 50 04             	mov    0x4(%eax),%edx
    1299:	8b 45 fc             	mov    -0x4(%ebp),%eax
    129c:	8b 00                	mov    (%eax),%eax
    129e:	8b 40 04             	mov    0x4(%eax),%eax
    12a1:	01 c2                	add    %eax,%edx
    12a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12a6:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    12a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ac:	8b 00                	mov    (%eax),%eax
    12ae:	8b 10                	mov    (%eax),%edx
    12b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12b3:	89 10                	mov    %edx,(%eax)
    12b5:	eb 0a                	jmp    12c1 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    12b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ba:	8b 10                	mov    (%eax),%edx
    12bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12bf:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    12c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12c4:	8b 40 04             	mov    0x4(%eax),%eax
    12c7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    12ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12d1:	01 d0                	add    %edx,%eax
    12d3:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    12d6:	75 20                	jne    12f8 <free+0xcf>
    p->s.size += bp->s.size;
    12d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12db:	8b 50 04             	mov    0x4(%eax),%edx
    12de:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12e1:	8b 40 04             	mov    0x4(%eax),%eax
    12e4:	01 c2                	add    %eax,%edx
    12e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12e9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    12ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12ef:	8b 10                	mov    (%eax),%edx
    12f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12f4:	89 10                	mov    %edx,(%eax)
    12f6:	eb 08                	jmp    1300 <free+0xd7>
  } else
    p->s.ptr = bp;
    12f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12fb:	8b 55 f8             	mov    -0x8(%ebp),%edx
    12fe:	89 10                	mov    %edx,(%eax)
  freep = p;
    1300:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1303:	a3 ec 26 00 00       	mov    %eax,0x26ec
}
    1308:	90                   	nop
    1309:	c9                   	leave  
    130a:	c3                   	ret    

0000130b <morecore>:

static Header*
morecore(uint nu)
{
    130b:	55                   	push   %ebp
    130c:	89 e5                	mov    %esp,%ebp
    130e:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1311:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1318:	77 07                	ja     1321 <morecore+0x16>
    nu = 4096;
    131a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1321:	8b 45 08             	mov    0x8(%ebp),%eax
    1324:	c1 e0 03             	shl    $0x3,%eax
    1327:	83 ec 0c             	sub    $0xc,%esp
    132a:	50                   	push   %eax
    132b:	e8 5d fc ff ff       	call   f8d <sbrk>
    1330:	83 c4 10             	add    $0x10,%esp
    1333:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1336:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    133a:	75 07                	jne    1343 <morecore+0x38>
    return 0;
    133c:	b8 00 00 00 00       	mov    $0x0,%eax
    1341:	eb 26                	jmp    1369 <morecore+0x5e>
  hp = (Header*)p;
    1343:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1346:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1349:	8b 45 f0             	mov    -0x10(%ebp),%eax
    134c:	8b 55 08             	mov    0x8(%ebp),%edx
    134f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1352:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1355:	83 c0 08             	add    $0x8,%eax
    1358:	83 ec 0c             	sub    $0xc,%esp
    135b:	50                   	push   %eax
    135c:	e8 c8 fe ff ff       	call   1229 <free>
    1361:	83 c4 10             	add    $0x10,%esp
  return freep;
    1364:	a1 ec 26 00 00       	mov    0x26ec,%eax
}
    1369:	c9                   	leave  
    136a:	c3                   	ret    

0000136b <malloc>:

void*
malloc(uint nbytes)
{
    136b:	55                   	push   %ebp
    136c:	89 e5                	mov    %esp,%ebp
    136e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1371:	8b 45 08             	mov    0x8(%ebp),%eax
    1374:	83 c0 07             	add    $0x7,%eax
    1377:	c1 e8 03             	shr    $0x3,%eax
    137a:	83 c0 01             	add    $0x1,%eax
    137d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1380:	a1 ec 26 00 00       	mov    0x26ec,%eax
    1385:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1388:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    138c:	75 23                	jne    13b1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    138e:	c7 45 f0 e4 26 00 00 	movl   $0x26e4,-0x10(%ebp)
    1395:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1398:	a3 ec 26 00 00       	mov    %eax,0x26ec
    139d:	a1 ec 26 00 00       	mov    0x26ec,%eax
    13a2:	a3 e4 26 00 00       	mov    %eax,0x26e4
    base.s.size = 0;
    13a7:	c7 05 e8 26 00 00 00 	movl   $0x0,0x26e8
    13ae:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13b4:	8b 00                	mov    (%eax),%eax
    13b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    13b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13bc:	8b 40 04             	mov    0x4(%eax),%eax
    13bf:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    13c2:	77 4d                	ja     1411 <malloc+0xa6>
      if(p->s.size == nunits)
    13c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c7:	8b 40 04             	mov    0x4(%eax),%eax
    13ca:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    13cd:	75 0c                	jne    13db <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    13cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13d2:	8b 10                	mov    (%eax),%edx
    13d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13d7:	89 10                	mov    %edx,(%eax)
    13d9:	eb 26                	jmp    1401 <malloc+0x96>
      else {
        p->s.size -= nunits;
    13db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13de:	8b 40 04             	mov    0x4(%eax),%eax
    13e1:	2b 45 ec             	sub    -0x14(%ebp),%eax
    13e4:	89 c2                	mov    %eax,%edx
    13e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    13ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13ef:	8b 40 04             	mov    0x4(%eax),%eax
    13f2:	c1 e0 03             	shl    $0x3,%eax
    13f5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    13f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13fb:	8b 55 ec             	mov    -0x14(%ebp),%edx
    13fe:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1401:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1404:	a3 ec 26 00 00       	mov    %eax,0x26ec
      return (void*)(p + 1);
    1409:	8b 45 f4             	mov    -0xc(%ebp),%eax
    140c:	83 c0 08             	add    $0x8,%eax
    140f:	eb 3b                	jmp    144c <malloc+0xe1>
    }
    if(p == freep)
    1411:	a1 ec 26 00 00       	mov    0x26ec,%eax
    1416:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1419:	75 1e                	jne    1439 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    141b:	83 ec 0c             	sub    $0xc,%esp
    141e:	ff 75 ec             	pushl  -0x14(%ebp)
    1421:	e8 e5 fe ff ff       	call   130b <morecore>
    1426:	83 c4 10             	add    $0x10,%esp
    1429:	89 45 f4             	mov    %eax,-0xc(%ebp)
    142c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1430:	75 07                	jne    1439 <malloc+0xce>
        return 0;
    1432:	b8 00 00 00 00       	mov    $0x0,%eax
    1437:	eb 13                	jmp    144c <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1439:	8b 45 f4             	mov    -0xc(%ebp),%eax
    143c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    143f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1442:	8b 00                	mov    (%eax),%eax
    1444:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1447:	e9 6d ff ff ff       	jmp    13b9 <malloc+0x4e>
  }
}
    144c:	c9                   	leave  
    144d:	c3                   	ret    

0000144e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
    144e:	55                   	push   %ebp
    144f:	89 e5                	mov    %esp,%ebp
    1451:	53                   	push   %ebx
    1452:	83 ec 14             	sub    $0x14,%esp
    1455:	8b 45 10             	mov    0x10(%ebp),%eax
    1458:	89 45 f0             	mov    %eax,-0x10(%ebp)
    145b:	8b 45 14             	mov    0x14(%ebp),%eax
    145e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
    1461:	8b 45 18             	mov    0x18(%ebp),%eax
    1464:	ba 00 00 00 00       	mov    $0x0,%edx
    1469:	39 55 f4             	cmp    %edx,-0xc(%ebp)
    146c:	72 55                	jb     14c3 <printnum+0x75>
    146e:	39 55 f4             	cmp    %edx,-0xc(%ebp)
    1471:	77 05                	ja     1478 <printnum+0x2a>
    1473:	39 45 f0             	cmp    %eax,-0x10(%ebp)
    1476:	72 4b                	jb     14c3 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
    1478:	8b 45 1c             	mov    0x1c(%ebp),%eax
    147b:	8d 58 ff             	lea    -0x1(%eax),%ebx
    147e:	8b 45 18             	mov    0x18(%ebp),%eax
    1481:	ba 00 00 00 00       	mov    $0x0,%edx
    1486:	52                   	push   %edx
    1487:	50                   	push   %eax
    1488:	ff 75 f4             	pushl  -0xc(%ebp)
    148b:	ff 75 f0             	pushl  -0x10(%ebp)
    148e:	e8 9d 05 00 00       	call   1a30 <__udivdi3>
    1493:	83 c4 10             	add    $0x10,%esp
    1496:	83 ec 04             	sub    $0x4,%esp
    1499:	ff 75 20             	pushl  0x20(%ebp)
    149c:	53                   	push   %ebx
    149d:	ff 75 18             	pushl  0x18(%ebp)
    14a0:	52                   	push   %edx
    14a1:	50                   	push   %eax
    14a2:	ff 75 0c             	pushl  0xc(%ebp)
    14a5:	ff 75 08             	pushl  0x8(%ebp)
    14a8:	e8 a1 ff ff ff       	call   144e <printnum>
    14ad:	83 c4 20             	add    $0x20,%esp
    14b0:	eb 1b                	jmp    14cd <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
    14b2:	83 ec 08             	sub    $0x8,%esp
    14b5:	ff 75 0c             	pushl  0xc(%ebp)
    14b8:	ff 75 20             	pushl  0x20(%ebp)
    14bb:	8b 45 08             	mov    0x8(%ebp),%eax
    14be:	ff d0                	call   *%eax
    14c0:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
    14c3:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
    14c7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
    14cb:	7f e5                	jg     14b2 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
    14cd:	8b 4d 18             	mov    0x18(%ebp),%ecx
    14d0:	bb 00 00 00 00       	mov    $0x0,%ebx
    14d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    14db:	53                   	push   %ebx
    14dc:	51                   	push   %ecx
    14dd:	52                   	push   %edx
    14de:	50                   	push   %eax
    14df:	e8 6c 06 00 00       	call   1b50 <__umoddi3>
    14e4:	83 c4 10             	add    $0x10,%esp
    14e7:	05 40 1e 00 00       	add    $0x1e40,%eax
    14ec:	0f b6 00             	movzbl (%eax),%eax
    14ef:	0f be c0             	movsbl %al,%eax
    14f2:	83 ec 08             	sub    $0x8,%esp
    14f5:	ff 75 0c             	pushl  0xc(%ebp)
    14f8:	50                   	push   %eax
    14f9:	8b 45 08             	mov    0x8(%ebp),%eax
    14fc:	ff d0                	call   *%eax
    14fe:	83 c4 10             	add    $0x10,%esp
}
    1501:	90                   	nop
    1502:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1505:	c9                   	leave  
    1506:	c3                   	ret    

00001507 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
    1507:	55                   	push   %ebp
    1508:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
    150a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
    150e:	7e 14                	jle    1524 <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
    1510:	8b 45 08             	mov    0x8(%ebp),%eax
    1513:	8b 00                	mov    (%eax),%eax
    1515:	8d 48 08             	lea    0x8(%eax),%ecx
    1518:	8b 55 08             	mov    0x8(%ebp),%edx
    151b:	89 0a                	mov    %ecx,(%edx)
    151d:	8b 50 04             	mov    0x4(%eax),%edx
    1520:	8b 00                	mov    (%eax),%eax
    1522:	eb 30                	jmp    1554 <getuint+0x4d>
  else if (lflag)
    1524:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1528:	74 16                	je     1540 <getuint+0x39>
    return va_arg(*ap, unsigned long);
    152a:	8b 45 08             	mov    0x8(%ebp),%eax
    152d:	8b 00                	mov    (%eax),%eax
    152f:	8d 48 04             	lea    0x4(%eax),%ecx
    1532:	8b 55 08             	mov    0x8(%ebp),%edx
    1535:	89 0a                	mov    %ecx,(%edx)
    1537:	8b 00                	mov    (%eax),%eax
    1539:	ba 00 00 00 00       	mov    $0x0,%edx
    153e:	eb 14                	jmp    1554 <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
    1540:	8b 45 08             	mov    0x8(%ebp),%eax
    1543:	8b 00                	mov    (%eax),%eax
    1545:	8d 48 04             	lea    0x4(%eax),%ecx
    1548:	8b 55 08             	mov    0x8(%ebp),%edx
    154b:	89 0a                	mov    %ecx,(%edx)
    154d:	8b 00                	mov    (%eax),%eax
    154f:	ba 00 00 00 00       	mov    $0x0,%edx
}
    1554:	5d                   	pop    %ebp
    1555:	c3                   	ret    

00001556 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
    1556:	55                   	push   %ebp
    1557:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
    1559:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
    155d:	7e 14                	jle    1573 <getint+0x1d>
    return va_arg(*ap, long long);
    155f:	8b 45 08             	mov    0x8(%ebp),%eax
    1562:	8b 00                	mov    (%eax),%eax
    1564:	8d 48 08             	lea    0x8(%eax),%ecx
    1567:	8b 55 08             	mov    0x8(%ebp),%edx
    156a:	89 0a                	mov    %ecx,(%edx)
    156c:	8b 50 04             	mov    0x4(%eax),%edx
    156f:	8b 00                	mov    (%eax),%eax
    1571:	eb 28                	jmp    159b <getint+0x45>
  else if (lflag)
    1573:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1577:	74 12                	je     158b <getint+0x35>
    return va_arg(*ap, long);
    1579:	8b 45 08             	mov    0x8(%ebp),%eax
    157c:	8b 00                	mov    (%eax),%eax
    157e:	8d 48 04             	lea    0x4(%eax),%ecx
    1581:	8b 55 08             	mov    0x8(%ebp),%edx
    1584:	89 0a                	mov    %ecx,(%edx)
    1586:	8b 00                	mov    (%eax),%eax
    1588:	99                   	cltd   
    1589:	eb 10                	jmp    159b <getint+0x45>
  else
    return va_arg(*ap, int);
    158b:	8b 45 08             	mov    0x8(%ebp),%eax
    158e:	8b 00                	mov    (%eax),%eax
    1590:	8d 48 04             	lea    0x4(%eax),%ecx
    1593:	8b 55 08             	mov    0x8(%ebp),%edx
    1596:	89 0a                	mov    %ecx,(%edx)
    1598:	8b 00                	mov    (%eax),%eax
    159a:	99                   	cltd   
}
    159b:	5d                   	pop    %ebp
    159c:	c3                   	ret    

0000159d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
    159d:	55                   	push   %ebp
    159e:	89 e5                	mov    %esp,%ebp
    15a0:	56                   	push   %esi
    15a1:	53                   	push   %ebx
    15a2:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
    15a5:	eb 17                	jmp    15be <vprintfmt+0x21>
      if (ch == '\0')
    15a7:	85 db                	test   %ebx,%ebx
    15a9:	0f 84 a0 03 00 00    	je     194f <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
    15af:	83 ec 08             	sub    $0x8,%esp
    15b2:	ff 75 0c             	pushl  0xc(%ebp)
    15b5:	53                   	push   %ebx
    15b6:	8b 45 08             	mov    0x8(%ebp),%eax
    15b9:	ff d0                	call   *%eax
    15bb:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
    15be:	8b 45 10             	mov    0x10(%ebp),%eax
    15c1:	8d 50 01             	lea    0x1(%eax),%edx
    15c4:	89 55 10             	mov    %edx,0x10(%ebp)
    15c7:	0f b6 00             	movzbl (%eax),%eax
    15ca:	0f b6 d8             	movzbl %al,%ebx
    15cd:	83 fb 25             	cmp    $0x25,%ebx
    15d0:	75 d5                	jne    15a7 <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
    15d2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
    15d6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
    15dd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
    15e4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
    15eb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
    15f2:	8b 45 10             	mov    0x10(%ebp),%eax
    15f5:	8d 50 01             	lea    0x1(%eax),%edx
    15f8:	89 55 10             	mov    %edx,0x10(%ebp)
    15fb:	0f b6 00             	movzbl (%eax),%eax
    15fe:	0f b6 d8             	movzbl %al,%ebx
    1601:	8d 43 dd             	lea    -0x23(%ebx),%eax
    1604:	83 f8 55             	cmp    $0x55,%eax
    1607:	0f 87 15 03 00 00    	ja     1922 <vprintfmt+0x385>
    160d:	8b 04 85 64 1e 00 00 	mov    0x1e64(,%eax,4),%eax
    1614:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
    1616:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
    161a:	eb d6                	jmp    15f2 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
    161c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
    1620:	eb d0                	jmp    15f2 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
    1622:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
    1629:	8b 55 e0             	mov    -0x20(%ebp),%edx
    162c:	89 d0                	mov    %edx,%eax
    162e:	c1 e0 02             	shl    $0x2,%eax
    1631:	01 d0                	add    %edx,%eax
    1633:	01 c0                	add    %eax,%eax
    1635:	01 d8                	add    %ebx,%eax
    1637:	83 e8 30             	sub    $0x30,%eax
    163a:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
    163d:	8b 45 10             	mov    0x10(%ebp),%eax
    1640:	0f b6 00             	movzbl (%eax),%eax
    1643:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
    1646:	83 fb 2f             	cmp    $0x2f,%ebx
    1649:	7e 39                	jle    1684 <vprintfmt+0xe7>
    164b:	83 fb 39             	cmp    $0x39,%ebx
    164e:	7f 34                	jg     1684 <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
    1650:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
    1654:	eb d3                	jmp    1629 <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
    1656:	8b 45 14             	mov    0x14(%ebp),%eax
    1659:	8d 50 04             	lea    0x4(%eax),%edx
    165c:	89 55 14             	mov    %edx,0x14(%ebp)
    165f:	8b 00                	mov    (%eax),%eax
    1661:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
    1664:	eb 1f                	jmp    1685 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
    1666:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    166a:	79 86                	jns    15f2 <vprintfmt+0x55>
        width = 0;
    166c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
    1673:	e9 7a ff ff ff       	jmp    15f2 <vprintfmt+0x55>

    case '#':
      altflag = 1;
    1678:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
    167f:	e9 6e ff ff ff       	jmp    15f2 <vprintfmt+0x55>
      goto process_precision;
    1684:	90                   	nop

process_precision:
      if (width < 0)
    1685:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1689:	0f 89 63 ff ff ff    	jns    15f2 <vprintfmt+0x55>
        width = precision, precision = -1;
    168f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1692:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1695:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
    169c:	e9 51 ff ff ff       	jmp    15f2 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
    16a1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
    16a5:	e9 48 ff ff ff       	jmp    15f2 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
    16aa:	8b 45 14             	mov    0x14(%ebp),%eax
    16ad:	8d 50 04             	lea    0x4(%eax),%edx
    16b0:	89 55 14             	mov    %edx,0x14(%ebp)
    16b3:	8b 00                	mov    (%eax),%eax
    16b5:	83 ec 08             	sub    $0x8,%esp
    16b8:	ff 75 0c             	pushl  0xc(%ebp)
    16bb:	50                   	push   %eax
    16bc:	8b 45 08             	mov    0x8(%ebp),%eax
    16bf:	ff d0                	call   *%eax
    16c1:	83 c4 10             	add    $0x10,%esp
      break;
    16c4:	e9 81 02 00 00       	jmp    194a <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
    16c9:	8b 45 14             	mov    0x14(%ebp),%eax
    16cc:	8d 50 04             	lea    0x4(%eax),%edx
    16cf:	89 55 14             	mov    %edx,0x14(%ebp)
    16d2:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
    16d4:	85 db                	test   %ebx,%ebx
    16d6:	79 02                	jns    16da <vprintfmt+0x13d>
        err = -err;
    16d8:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
    16da:	83 fb 0f             	cmp    $0xf,%ebx
    16dd:	7f 0b                	jg     16ea <vprintfmt+0x14d>
    16df:	8b 34 9d 00 1e 00 00 	mov    0x1e00(,%ebx,4),%esi
    16e6:	85 f6                	test   %esi,%esi
    16e8:	75 19                	jne    1703 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
    16ea:	53                   	push   %ebx
    16eb:	68 51 1e 00 00       	push   $0x1e51
    16f0:	ff 75 0c             	pushl  0xc(%ebp)
    16f3:	ff 75 08             	pushl  0x8(%ebp)
    16f6:	e8 5c 02 00 00       	call   1957 <printfmt>
    16fb:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
    16fe:	e9 47 02 00 00       	jmp    194a <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
    1703:	56                   	push   %esi
    1704:	68 5a 1e 00 00       	push   $0x1e5a
    1709:	ff 75 0c             	pushl  0xc(%ebp)
    170c:	ff 75 08             	pushl  0x8(%ebp)
    170f:	e8 43 02 00 00       	call   1957 <printfmt>
    1714:	83 c4 10             	add    $0x10,%esp
      break;
    1717:	e9 2e 02 00 00       	jmp    194a <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
    171c:	8b 45 14             	mov    0x14(%ebp),%eax
    171f:	8d 50 04             	lea    0x4(%eax),%edx
    1722:	89 55 14             	mov    %edx,0x14(%ebp)
    1725:	8b 30                	mov    (%eax),%esi
    1727:	85 f6                	test   %esi,%esi
    1729:	75 05                	jne    1730 <vprintfmt+0x193>
        p = "(null)";
    172b:	be 5d 1e 00 00       	mov    $0x1e5d,%esi
      if (width > 0 && padc != '-')
    1730:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1734:	7e 6f                	jle    17a5 <vprintfmt+0x208>
    1736:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
    173a:	74 69                	je     17a5 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
    173c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    173f:	83 ec 08             	sub    $0x8,%esp
    1742:	50                   	push   %eax
    1743:	56                   	push   %esi
    1744:	e8 f1 f5 ff ff       	call   d3a <strnlen>
    1749:	83 c4 10             	add    $0x10,%esp
    174c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
    174f:	eb 17                	jmp    1768 <vprintfmt+0x1cb>
          putch(padc, putdat);
    1751:	0f be 45 db          	movsbl -0x25(%ebp),%eax
    1755:	83 ec 08             	sub    $0x8,%esp
    1758:	ff 75 0c             	pushl  0xc(%ebp)
    175b:	50                   	push   %eax
    175c:	8b 45 08             	mov    0x8(%ebp),%eax
    175f:	ff d0                	call   *%eax
    1761:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
    1764:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
    1768:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    176c:	7f e3                	jg     1751 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
    176e:	eb 35                	jmp    17a5 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
    1770:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
    1774:	74 1c                	je     1792 <vprintfmt+0x1f5>
    1776:	83 fb 1f             	cmp    $0x1f,%ebx
    1779:	7e 05                	jle    1780 <vprintfmt+0x1e3>
    177b:	83 fb 7e             	cmp    $0x7e,%ebx
    177e:	7e 12                	jle    1792 <vprintfmt+0x1f5>
          putch('?', putdat);
    1780:	83 ec 08             	sub    $0x8,%esp
    1783:	ff 75 0c             	pushl  0xc(%ebp)
    1786:	6a 3f                	push   $0x3f
    1788:	8b 45 08             	mov    0x8(%ebp),%eax
    178b:	ff d0                	call   *%eax
    178d:	83 c4 10             	add    $0x10,%esp
    1790:	eb 0f                	jmp    17a1 <vprintfmt+0x204>
        else
          putch(ch, putdat);
    1792:	83 ec 08             	sub    $0x8,%esp
    1795:	ff 75 0c             	pushl  0xc(%ebp)
    1798:	53                   	push   %ebx
    1799:	8b 45 08             	mov    0x8(%ebp),%eax
    179c:	ff d0                	call   *%eax
    179e:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
    17a1:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
    17a5:	89 f0                	mov    %esi,%eax
    17a7:	8d 70 01             	lea    0x1(%eax),%esi
    17aa:	0f b6 00             	movzbl (%eax),%eax
    17ad:	0f be d8             	movsbl %al,%ebx
    17b0:	85 db                	test   %ebx,%ebx
    17b2:	74 26                	je     17da <vprintfmt+0x23d>
    17b4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    17b8:	78 b6                	js     1770 <vprintfmt+0x1d3>
    17ba:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
    17be:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    17c2:	79 ac                	jns    1770 <vprintfmt+0x1d3>
      for (; width > 0; width--)
    17c4:	eb 14                	jmp    17da <vprintfmt+0x23d>
        putch(' ', putdat);
    17c6:	83 ec 08             	sub    $0x8,%esp
    17c9:	ff 75 0c             	pushl  0xc(%ebp)
    17cc:	6a 20                	push   $0x20
    17ce:	8b 45 08             	mov    0x8(%ebp),%eax
    17d1:	ff d0                	call   *%eax
    17d3:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
    17d6:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
    17da:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    17de:	7f e6                	jg     17c6 <vprintfmt+0x229>
      break;
    17e0:	e9 65 01 00 00       	jmp    194a <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
    17e5:	83 ec 08             	sub    $0x8,%esp
    17e8:	ff 75 e8             	pushl  -0x18(%ebp)
    17eb:	8d 45 14             	lea    0x14(%ebp),%eax
    17ee:	50                   	push   %eax
    17ef:	e8 62 fd ff ff       	call   1556 <getint>
    17f4:	83 c4 10             	add    $0x10,%esp
    17f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
    17fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1800:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1803:	85 d2                	test   %edx,%edx
    1805:	79 23                	jns    182a <vprintfmt+0x28d>
        putch('-', putdat);
    1807:	83 ec 08             	sub    $0x8,%esp
    180a:	ff 75 0c             	pushl  0xc(%ebp)
    180d:	6a 2d                	push   $0x2d
    180f:	8b 45 08             	mov    0x8(%ebp),%eax
    1812:	ff d0                	call   *%eax
    1814:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
    1817:	8b 45 f0             	mov    -0x10(%ebp),%eax
    181a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    181d:	f7 d8                	neg    %eax
    181f:	83 d2 00             	adc    $0x0,%edx
    1822:	f7 da                	neg    %edx
    1824:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1827:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
    182a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
    1831:	e9 b6 00 00 00       	jmp    18ec <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
    1836:	83 ec 08             	sub    $0x8,%esp
    1839:	ff 75 e8             	pushl  -0x18(%ebp)
    183c:	8d 45 14             	lea    0x14(%ebp),%eax
    183f:	50                   	push   %eax
    1840:	e8 c2 fc ff ff       	call   1507 <getuint>
    1845:	83 c4 10             	add    $0x10,%esp
    1848:	89 45 f0             	mov    %eax,-0x10(%ebp)
    184b:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
    184e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
    1855:	e9 92 00 00 00       	jmp    18ec <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
    185a:	83 ec 08             	sub    $0x8,%esp
    185d:	ff 75 0c             	pushl  0xc(%ebp)
    1860:	6a 58                	push   $0x58
    1862:	8b 45 08             	mov    0x8(%ebp),%eax
    1865:	ff d0                	call   *%eax
    1867:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
    186a:	83 ec 08             	sub    $0x8,%esp
    186d:	ff 75 0c             	pushl  0xc(%ebp)
    1870:	6a 58                	push   $0x58
    1872:	8b 45 08             	mov    0x8(%ebp),%eax
    1875:	ff d0                	call   *%eax
    1877:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
    187a:	83 ec 08             	sub    $0x8,%esp
    187d:	ff 75 0c             	pushl  0xc(%ebp)
    1880:	6a 58                	push   $0x58
    1882:	8b 45 08             	mov    0x8(%ebp),%eax
    1885:	ff d0                	call   *%eax
    1887:	83 c4 10             	add    $0x10,%esp
      break;
    188a:	e9 bb 00 00 00       	jmp    194a <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
    188f:	83 ec 08             	sub    $0x8,%esp
    1892:	ff 75 0c             	pushl  0xc(%ebp)
    1895:	6a 30                	push   $0x30
    1897:	8b 45 08             	mov    0x8(%ebp),%eax
    189a:	ff d0                	call   *%eax
    189c:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
    189f:	83 ec 08             	sub    $0x8,%esp
    18a2:	ff 75 0c             	pushl  0xc(%ebp)
    18a5:	6a 78                	push   $0x78
    18a7:	8b 45 08             	mov    0x8(%ebp),%eax
    18aa:	ff d0                	call   *%eax
    18ac:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
    18af:	8b 45 14             	mov    0x14(%ebp),%eax
    18b2:	8d 50 04             	lea    0x4(%eax),%edx
    18b5:	89 55 14             	mov    %edx,0x14(%ebp)
    18b8:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
    18ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
    18c4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
    18cb:	eb 1f                	jmp    18ec <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
    18cd:	83 ec 08             	sub    $0x8,%esp
    18d0:	ff 75 e8             	pushl  -0x18(%ebp)
    18d3:	8d 45 14             	lea    0x14(%ebp),%eax
    18d6:	50                   	push   %eax
    18d7:	e8 2b fc ff ff       	call   1507 <getuint>
    18dc:	83 c4 10             	add    $0x10,%esp
    18df:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
    18e5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
    18ec:	0f be 55 db          	movsbl -0x25(%ebp),%edx
    18f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18f3:	83 ec 04             	sub    $0x4,%esp
    18f6:	52                   	push   %edx
    18f7:	ff 75 e4             	pushl  -0x1c(%ebp)
    18fa:	50                   	push   %eax
    18fb:	ff 75 f4             	pushl  -0xc(%ebp)
    18fe:	ff 75 f0             	pushl  -0x10(%ebp)
    1901:	ff 75 0c             	pushl  0xc(%ebp)
    1904:	ff 75 08             	pushl  0x8(%ebp)
    1907:	e8 42 fb ff ff       	call   144e <printnum>
    190c:	83 c4 20             	add    $0x20,%esp
      break;
    190f:	eb 39                	jmp    194a <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
    1911:	83 ec 08             	sub    $0x8,%esp
    1914:	ff 75 0c             	pushl  0xc(%ebp)
    1917:	53                   	push   %ebx
    1918:	8b 45 08             	mov    0x8(%ebp),%eax
    191b:	ff d0                	call   *%eax
    191d:	83 c4 10             	add    $0x10,%esp
      break;
    1920:	eb 28                	jmp    194a <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
    1922:	83 ec 08             	sub    $0x8,%esp
    1925:	ff 75 0c             	pushl  0xc(%ebp)
    1928:	6a 25                	push   $0x25
    192a:	8b 45 08             	mov    0x8(%ebp),%eax
    192d:	ff d0                	call   *%eax
    192f:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
    1932:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1936:	eb 04                	jmp    193c <vprintfmt+0x39f>
    1938:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    193c:	8b 45 10             	mov    0x10(%ebp),%eax
    193f:	83 e8 01             	sub    $0x1,%eax
    1942:	0f b6 00             	movzbl (%eax),%eax
    1945:	3c 25                	cmp    $0x25,%al
    1947:	75 ef                	jne    1938 <vprintfmt+0x39b>
        /* do nothing */;
      break;
    1949:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
    194a:	e9 6f fc ff ff       	jmp    15be <vprintfmt+0x21>
        return;
    194f:	90                   	nop
    }
  }
}
    1950:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1953:	5b                   	pop    %ebx
    1954:	5e                   	pop    %esi
    1955:	5d                   	pop    %ebp
    1956:	c3                   	ret    

00001957 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
    1957:	55                   	push   %ebp
    1958:	89 e5                	mov    %esp,%ebp
    195a:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
    195d:	8d 45 14             	lea    0x14(%ebp),%eax
    1960:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
    1963:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1966:	50                   	push   %eax
    1967:	ff 75 10             	pushl  0x10(%ebp)
    196a:	ff 75 0c             	pushl  0xc(%ebp)
    196d:	ff 75 08             	pushl  0x8(%ebp)
    1970:	e8 28 fc ff ff       	call   159d <vprintfmt>
    1975:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
    1978:	90                   	nop
    1979:	c9                   	leave  
    197a:	c3                   	ret    

0000197b <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
    197b:	55                   	push   %ebp
    197c:	89 e5                	mov    %esp,%ebp
  b->cnt++;
    197e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1981:	8b 40 08             	mov    0x8(%eax),%eax
    1984:	8d 50 01             	lea    0x1(%eax),%edx
    1987:	8b 45 0c             	mov    0xc(%ebp),%eax
    198a:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
    198d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1990:	8b 10                	mov    (%eax),%edx
    1992:	8b 45 0c             	mov    0xc(%ebp),%eax
    1995:	8b 40 04             	mov    0x4(%eax),%eax
    1998:	39 c2                	cmp    %eax,%edx
    199a:	73 12                	jae    19ae <sprintputch+0x33>
    *b->buf++ = ch;
    199c:	8b 45 0c             	mov    0xc(%ebp),%eax
    199f:	8b 00                	mov    (%eax),%eax
    19a1:	8d 48 01             	lea    0x1(%eax),%ecx
    19a4:	8b 55 0c             	mov    0xc(%ebp),%edx
    19a7:	89 0a                	mov    %ecx,(%edx)
    19a9:	8b 55 08             	mov    0x8(%ebp),%edx
    19ac:	88 10                	mov    %dl,(%eax)
}
    19ae:	90                   	nop
    19af:	5d                   	pop    %ebp
    19b0:	c3                   	ret    

000019b1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
    19b1:	55                   	push   %ebp
    19b2:	89 e5                	mov    %esp,%ebp
    19b4:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
    19b7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
    19bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    19c0:	8d 50 ff             	lea    -0x1(%eax),%edx
    19c3:	8b 45 08             	mov    0x8(%ebp),%eax
    19c6:	01 d0                	add    %edx,%eax
    19c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
    19d2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    19d6:	74 06                	je     19de <vsnprintf+0x2d>
    19d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    19dc:	7f 07                	jg     19e5 <vsnprintf+0x34>
    return -E_INVAL;
    19de:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
    19e3:	eb 20                	jmp    1a05 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
    19e5:	ff 75 14             	pushl  0x14(%ebp)
    19e8:	ff 75 10             	pushl  0x10(%ebp)
    19eb:	8d 45 ec             	lea    -0x14(%ebp),%eax
    19ee:	50                   	push   %eax
    19ef:	68 7b 19 00 00       	push   $0x197b
    19f4:	e8 a4 fb ff ff       	call   159d <vprintfmt>
    19f9:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
    19fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19ff:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
    1a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1a05:	c9                   	leave  
    1a06:	c3                   	ret    

00001a07 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
    1a07:	55                   	push   %ebp
    1a08:	89 e5                	mov    %esp,%ebp
    1a0a:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
    1a0d:	8d 45 14             	lea    0x14(%ebp),%eax
    1a10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
    1a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a16:	50                   	push   %eax
    1a17:	ff 75 10             	pushl  0x10(%ebp)
    1a1a:	ff 75 0c             	pushl  0xc(%ebp)
    1a1d:	ff 75 08             	pushl  0x8(%ebp)
    1a20:	e8 8c ff ff ff       	call   19b1 <vsnprintf>
    1a25:	83 c4 10             	add    $0x10,%esp
    1a28:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
    1a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1a2e:	c9                   	leave  
    1a2f:	c3                   	ret    

00001a30 <__udivdi3>:
    1a30:	55                   	push   %ebp
    1a31:	57                   	push   %edi
    1a32:	56                   	push   %esi
    1a33:	53                   	push   %ebx
    1a34:	83 ec 1c             	sub    $0x1c,%esp
    1a37:	8b 54 24 3c          	mov    0x3c(%esp),%edx
    1a3b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
    1a3f:	8b 74 24 34          	mov    0x34(%esp),%esi
    1a43:	8b 5c 24 38          	mov    0x38(%esp),%ebx
    1a47:	85 d2                	test   %edx,%edx
    1a49:	75 35                	jne    1a80 <__udivdi3+0x50>
    1a4b:	39 f3                	cmp    %esi,%ebx
    1a4d:	0f 87 bd 00 00 00    	ja     1b10 <__udivdi3+0xe0>
    1a53:	85 db                	test   %ebx,%ebx
    1a55:	89 d9                	mov    %ebx,%ecx
    1a57:	75 0b                	jne    1a64 <__udivdi3+0x34>
    1a59:	b8 01 00 00 00       	mov    $0x1,%eax
    1a5e:	31 d2                	xor    %edx,%edx
    1a60:	f7 f3                	div    %ebx
    1a62:	89 c1                	mov    %eax,%ecx
    1a64:	31 d2                	xor    %edx,%edx
    1a66:	89 f0                	mov    %esi,%eax
    1a68:	f7 f1                	div    %ecx
    1a6a:	89 c6                	mov    %eax,%esi
    1a6c:	89 e8                	mov    %ebp,%eax
    1a6e:	89 f7                	mov    %esi,%edi
    1a70:	f7 f1                	div    %ecx
    1a72:	89 fa                	mov    %edi,%edx
    1a74:	83 c4 1c             	add    $0x1c,%esp
    1a77:	5b                   	pop    %ebx
    1a78:	5e                   	pop    %esi
    1a79:	5f                   	pop    %edi
    1a7a:	5d                   	pop    %ebp
    1a7b:	c3                   	ret    
    1a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1a80:	39 f2                	cmp    %esi,%edx
    1a82:	77 7c                	ja     1b00 <__udivdi3+0xd0>
    1a84:	0f bd fa             	bsr    %edx,%edi
    1a87:	83 f7 1f             	xor    $0x1f,%edi
    1a8a:	0f 84 98 00 00 00    	je     1b28 <__udivdi3+0xf8>
    1a90:	89 f9                	mov    %edi,%ecx
    1a92:	b8 20 00 00 00       	mov    $0x20,%eax
    1a97:	29 f8                	sub    %edi,%eax
    1a99:	d3 e2                	shl    %cl,%edx
    1a9b:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a9f:	89 c1                	mov    %eax,%ecx
    1aa1:	89 da                	mov    %ebx,%edx
    1aa3:	d3 ea                	shr    %cl,%edx
    1aa5:	8b 4c 24 08          	mov    0x8(%esp),%ecx
    1aa9:	09 d1                	or     %edx,%ecx
    1aab:	89 f2                	mov    %esi,%edx
    1aad:	89 4c 24 08          	mov    %ecx,0x8(%esp)
    1ab1:	89 f9                	mov    %edi,%ecx
    1ab3:	d3 e3                	shl    %cl,%ebx
    1ab5:	89 c1                	mov    %eax,%ecx
    1ab7:	d3 ea                	shr    %cl,%edx
    1ab9:	89 f9                	mov    %edi,%ecx
    1abb:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    1abf:	d3 e6                	shl    %cl,%esi
    1ac1:	89 eb                	mov    %ebp,%ebx
    1ac3:	89 c1                	mov    %eax,%ecx
    1ac5:	d3 eb                	shr    %cl,%ebx
    1ac7:	09 de                	or     %ebx,%esi
    1ac9:	89 f0                	mov    %esi,%eax
    1acb:	f7 74 24 08          	divl   0x8(%esp)
    1acf:	89 d6                	mov    %edx,%esi
    1ad1:	89 c3                	mov    %eax,%ebx
    1ad3:	f7 64 24 0c          	mull   0xc(%esp)
    1ad7:	39 d6                	cmp    %edx,%esi
    1ad9:	72 0c                	jb     1ae7 <__udivdi3+0xb7>
    1adb:	89 f9                	mov    %edi,%ecx
    1add:	d3 e5                	shl    %cl,%ebp
    1adf:	39 c5                	cmp    %eax,%ebp
    1ae1:	73 5d                	jae    1b40 <__udivdi3+0x110>
    1ae3:	39 d6                	cmp    %edx,%esi
    1ae5:	75 59                	jne    1b40 <__udivdi3+0x110>
    1ae7:	8d 43 ff             	lea    -0x1(%ebx),%eax
    1aea:	31 ff                	xor    %edi,%edi
    1aec:	89 fa                	mov    %edi,%edx
    1aee:	83 c4 1c             	add    $0x1c,%esp
    1af1:	5b                   	pop    %ebx
    1af2:	5e                   	pop    %esi
    1af3:	5f                   	pop    %edi
    1af4:	5d                   	pop    %ebp
    1af5:	c3                   	ret    
    1af6:	8d 76 00             	lea    0x0(%esi),%esi
    1af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1b00:	31 ff                	xor    %edi,%edi
    1b02:	31 c0                	xor    %eax,%eax
    1b04:	89 fa                	mov    %edi,%edx
    1b06:	83 c4 1c             	add    $0x1c,%esp
    1b09:	5b                   	pop    %ebx
    1b0a:	5e                   	pop    %esi
    1b0b:	5f                   	pop    %edi
    1b0c:	5d                   	pop    %ebp
    1b0d:	c3                   	ret    
    1b0e:	66 90                	xchg   %ax,%ax
    1b10:	31 ff                	xor    %edi,%edi
    1b12:	89 e8                	mov    %ebp,%eax
    1b14:	89 f2                	mov    %esi,%edx
    1b16:	f7 f3                	div    %ebx
    1b18:	89 fa                	mov    %edi,%edx
    1b1a:	83 c4 1c             	add    $0x1c,%esp
    1b1d:	5b                   	pop    %ebx
    1b1e:	5e                   	pop    %esi
    1b1f:	5f                   	pop    %edi
    1b20:	5d                   	pop    %ebp
    1b21:	c3                   	ret    
    1b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1b28:	39 f2                	cmp    %esi,%edx
    1b2a:	72 06                	jb     1b32 <__udivdi3+0x102>
    1b2c:	31 c0                	xor    %eax,%eax
    1b2e:	39 eb                	cmp    %ebp,%ebx
    1b30:	77 d2                	ja     1b04 <__udivdi3+0xd4>
    1b32:	b8 01 00 00 00       	mov    $0x1,%eax
    1b37:	eb cb                	jmp    1b04 <__udivdi3+0xd4>
    1b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1b40:	89 d8                	mov    %ebx,%eax
    1b42:	31 ff                	xor    %edi,%edi
    1b44:	eb be                	jmp    1b04 <__udivdi3+0xd4>
    1b46:	66 90                	xchg   %ax,%ax
    1b48:	66 90                	xchg   %ax,%ax
    1b4a:	66 90                	xchg   %ax,%ax
    1b4c:	66 90                	xchg   %ax,%ax
    1b4e:	66 90                	xchg   %ax,%ax

00001b50 <__umoddi3>:
    1b50:	55                   	push   %ebp
    1b51:	57                   	push   %edi
    1b52:	56                   	push   %esi
    1b53:	53                   	push   %ebx
    1b54:	83 ec 1c             	sub    $0x1c,%esp
    1b57:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
    1b5b:	8b 74 24 30          	mov    0x30(%esp),%esi
    1b5f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
    1b63:	8b 7c 24 38          	mov    0x38(%esp),%edi
    1b67:	85 ed                	test   %ebp,%ebp
    1b69:	89 f0                	mov    %esi,%eax
    1b6b:	89 da                	mov    %ebx,%edx
    1b6d:	75 19                	jne    1b88 <__umoddi3+0x38>
    1b6f:	39 df                	cmp    %ebx,%edi
    1b71:	0f 86 b1 00 00 00    	jbe    1c28 <__umoddi3+0xd8>
    1b77:	f7 f7                	div    %edi
    1b79:	89 d0                	mov    %edx,%eax
    1b7b:	31 d2                	xor    %edx,%edx
    1b7d:	83 c4 1c             	add    $0x1c,%esp
    1b80:	5b                   	pop    %ebx
    1b81:	5e                   	pop    %esi
    1b82:	5f                   	pop    %edi
    1b83:	5d                   	pop    %ebp
    1b84:	c3                   	ret    
    1b85:	8d 76 00             	lea    0x0(%esi),%esi
    1b88:	39 dd                	cmp    %ebx,%ebp
    1b8a:	77 f1                	ja     1b7d <__umoddi3+0x2d>
    1b8c:	0f bd cd             	bsr    %ebp,%ecx
    1b8f:	83 f1 1f             	xor    $0x1f,%ecx
    1b92:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1b96:	0f 84 b4 00 00 00    	je     1c50 <__umoddi3+0x100>
    1b9c:	b8 20 00 00 00       	mov    $0x20,%eax
    1ba1:	89 c2                	mov    %eax,%edx
    1ba3:	8b 44 24 04          	mov    0x4(%esp),%eax
    1ba7:	29 c2                	sub    %eax,%edx
    1ba9:	89 c1                	mov    %eax,%ecx
    1bab:	89 f8                	mov    %edi,%eax
    1bad:	d3 e5                	shl    %cl,%ebp
    1baf:	89 d1                	mov    %edx,%ecx
    1bb1:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1bb5:	d3 e8                	shr    %cl,%eax
    1bb7:	09 c5                	or     %eax,%ebp
    1bb9:	8b 44 24 04          	mov    0x4(%esp),%eax
    1bbd:	89 c1                	mov    %eax,%ecx
    1bbf:	d3 e7                	shl    %cl,%edi
    1bc1:	89 d1                	mov    %edx,%ecx
    1bc3:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1bc7:	89 df                	mov    %ebx,%edi
    1bc9:	d3 ef                	shr    %cl,%edi
    1bcb:	89 c1                	mov    %eax,%ecx
    1bcd:	89 f0                	mov    %esi,%eax
    1bcf:	d3 e3                	shl    %cl,%ebx
    1bd1:	89 d1                	mov    %edx,%ecx
    1bd3:	89 fa                	mov    %edi,%edx
    1bd5:	d3 e8                	shr    %cl,%eax
    1bd7:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
    1bdc:	09 d8                	or     %ebx,%eax
    1bde:	f7 f5                	div    %ebp
    1be0:	d3 e6                	shl    %cl,%esi
    1be2:	89 d1                	mov    %edx,%ecx
    1be4:	f7 64 24 08          	mull   0x8(%esp)
    1be8:	39 d1                	cmp    %edx,%ecx
    1bea:	89 c3                	mov    %eax,%ebx
    1bec:	89 d7                	mov    %edx,%edi
    1bee:	72 06                	jb     1bf6 <__umoddi3+0xa6>
    1bf0:	75 0e                	jne    1c00 <__umoddi3+0xb0>
    1bf2:	39 c6                	cmp    %eax,%esi
    1bf4:	73 0a                	jae    1c00 <__umoddi3+0xb0>
    1bf6:	2b 44 24 08          	sub    0x8(%esp),%eax
    1bfa:	19 ea                	sbb    %ebp,%edx
    1bfc:	89 d7                	mov    %edx,%edi
    1bfe:	89 c3                	mov    %eax,%ebx
    1c00:	89 ca                	mov    %ecx,%edx
    1c02:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    1c07:	29 de                	sub    %ebx,%esi
    1c09:	19 fa                	sbb    %edi,%edx
    1c0b:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    1c0f:	89 d0                	mov    %edx,%eax
    1c11:	d3 e0                	shl    %cl,%eax
    1c13:	89 d9                	mov    %ebx,%ecx
    1c15:	d3 ee                	shr    %cl,%esi
    1c17:	d3 ea                	shr    %cl,%edx
    1c19:	09 f0                	or     %esi,%eax
    1c1b:	83 c4 1c             	add    $0x1c,%esp
    1c1e:	5b                   	pop    %ebx
    1c1f:	5e                   	pop    %esi
    1c20:	5f                   	pop    %edi
    1c21:	5d                   	pop    %ebp
    1c22:	c3                   	ret    
    1c23:	90                   	nop
    1c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1c28:	85 ff                	test   %edi,%edi
    1c2a:	89 f9                	mov    %edi,%ecx
    1c2c:	75 0b                	jne    1c39 <__umoddi3+0xe9>
    1c2e:	b8 01 00 00 00       	mov    $0x1,%eax
    1c33:	31 d2                	xor    %edx,%edx
    1c35:	f7 f7                	div    %edi
    1c37:	89 c1                	mov    %eax,%ecx
    1c39:	89 d8                	mov    %ebx,%eax
    1c3b:	31 d2                	xor    %edx,%edx
    1c3d:	f7 f1                	div    %ecx
    1c3f:	89 f0                	mov    %esi,%eax
    1c41:	f7 f1                	div    %ecx
    1c43:	e9 31 ff ff ff       	jmp    1b79 <__umoddi3+0x29>
    1c48:	90                   	nop
    1c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1c50:	39 dd                	cmp    %ebx,%ebp
    1c52:	72 08                	jb     1c5c <__umoddi3+0x10c>
    1c54:	39 f7                	cmp    %esi,%edi
    1c56:	0f 87 21 ff ff ff    	ja     1b7d <__umoddi3+0x2d>
    1c5c:	89 da                	mov    %ebx,%edx
    1c5e:	89 f0                	mov    %esi,%eax
    1c60:	29 f8                	sub    %edi,%eax
    1c62:	19 ea                	sbb    %ebp,%edx
    1c64:	e9 14 ff ff ff       	jmp    1b7d <__umoddi3+0x2d>
