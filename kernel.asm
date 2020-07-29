
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 80 12 00       	mov    $0x128000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc e0 aa 12 80       	mov    $0x8012aae0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 d4 46 10 80       	mov    $0x801046d4,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <hex_to_int>:
#include "string.h"
#include "arp_frame.h"

#define BROADCAST_MAC "FF:FF:FF:FF:FF:FF"

int hex_to_int (char ch) {
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 14             	sub    $0x14,%esp
8010003a:	8b 45 08             	mov    0x8(%ebp),%eax
8010003d:	88 45 ec             	mov    %al,-0x14(%ebp)

	uint i = 0;
80100040:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)

	if (ch >= '0' && ch <= '9') {
80100047:	80 7d ec 2f          	cmpb   $0x2f,-0x14(%ebp)
8010004b:	7e 12                	jle    8010005f <hex_to_int+0x2b>
8010004d:	80 7d ec 39          	cmpb   $0x39,-0x14(%ebp)
80100051:	7f 0c                	jg     8010005f <hex_to_int+0x2b>
		i = ch - '0';
80100053:	0f be 45 ec          	movsbl -0x14(%ebp),%eax
80100057:	83 e8 30             	sub    $0x30,%eax
8010005a:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010005d:	eb 2e                	jmp    8010008d <hex_to_int+0x59>
	}
	else if (ch >= 'A' && ch <= 'F') {
8010005f:	80 7d ec 40          	cmpb   $0x40,-0x14(%ebp)
80100063:	7e 12                	jle    80100077 <hex_to_int+0x43>
80100065:	80 7d ec 46          	cmpb   $0x46,-0x14(%ebp)
80100069:	7f 0c                	jg     80100077 <hex_to_int+0x43>
		i = 10 + (ch - 'A');
8010006b:	0f be 45 ec          	movsbl -0x14(%ebp),%eax
8010006f:	83 e8 37             	sub    $0x37,%eax
80100072:	89 45 fc             	mov    %eax,-0x4(%ebp)
80100075:	eb 16                	jmp    8010008d <hex_to_int+0x59>
	}
	else if (ch >= 'a' && ch <= 'f') {
80100077:	80 7d ec 60          	cmpb   $0x60,-0x14(%ebp)
8010007b:	7e 10                	jle    8010008d <hex_to_int+0x59>
8010007d:	80 7d ec 66          	cmpb   $0x66,-0x14(%ebp)
80100081:	7f 0a                	jg     8010008d <hex_to_int+0x59>
		i = 10 + (ch - 'a');
80100083:	0f be 45 ec          	movsbl -0x14(%ebp),%eax
80100087:	83 e8 57             	sub    $0x57,%eax
8010008a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	}

	return i;
8010008d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80100090:	c9                   	leave  
80100091:	c3                   	ret    

80100092 <pack_mac>:

/**
 * Pack the XX:Xx:XX:XX:XX:XX representation of MAC address
 * into I:I:I:I:I:I
 */
void pack_mac(uchar* dest, char* src) {
80100092:	55                   	push   %ebp
80100093:	89 e5                	mov    %esp,%ebp
80100095:	53                   	push   %ebx
80100096:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0, j = 0; i < 17; i += 3) {
80100099:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801000a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801000a7:	eb 5d                	jmp    80100106 <pack_mac+0x74>
		uint i1 = hex_to_int(src[i]);
801000a9:	8b 55 f8             	mov    -0x8(%ebp),%edx
801000ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801000af:	01 d0                	add    %edx,%eax
801000b1:	0f b6 00             	movzbl (%eax),%eax
801000b4:	0f be c0             	movsbl %al,%eax
801000b7:	50                   	push   %eax
801000b8:	e8 77 ff ff ff       	call   80100034 <hex_to_int>
801000bd:	83 c4 04             	add    $0x4,%esp
801000c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		uint i2 = hex_to_int(src[i+1]);
801000c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
801000c6:	8d 50 01             	lea    0x1(%eax),%edx
801000c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801000cc:	01 d0                	add    %edx,%eax
801000ce:	0f b6 00             	movzbl (%eax),%eax
801000d1:	0f be c0             	movsbl %al,%eax
801000d4:	50                   	push   %eax
801000d5:	e8 5a ff ff ff       	call   80100034 <hex_to_int>
801000da:	83 c4 04             	add    $0x4,%esp
801000dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
		dest[j++] = (i1<<4) + i2;
801000e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801000e3:	c1 e0 04             	shl    $0x4,%eax
801000e6:	89 c1                	mov    %eax,%ecx
801000e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801000eb:	89 c3                	mov    %eax,%ebx
801000ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f0:	8d 50 01             	lea    0x1(%eax),%edx
801000f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
801000f6:	89 c2                	mov    %eax,%edx
801000f8:	8b 45 08             	mov    0x8(%ebp),%eax
801000fb:	01 d0                	add    %edx,%eax
801000fd:	8d 14 19             	lea    (%ecx,%ebx,1),%edx
80100100:	88 10                	mov    %dl,(%eax)
	for (int i = 0, j = 0; i < 17; i += 3) {
80100102:	83 45 f8 03          	addl   $0x3,-0x8(%ebp)
80100106:	83 7d f8 10          	cmpl   $0x10,-0x8(%ebp)
8010010a:	7e 9d                	jle    801000a9 <pack_mac+0x17>
	}
}
8010010c:	90                   	nop
8010010d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100110:	c9                   	leave  
80100111:	c3                   	ret    

80100112 <get_ip>:

uint32_t get_ip (const char* ip, uint len) {
80100112:	55                   	push   %ebp
80100113:	89 e5                	mov    %esp,%ebp
80100115:	83 ec 38             	sub    $0x38,%esp
    uint ipv4  = 0;
80100118:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    char arr[4];
    int n1 = 0;
8010011f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

     uint ip_vals[4];
     int n2 = 0;
80100126:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

     for (int i =0; i<len; i++) {
8010012d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100134:	eb 60                	jmp    80100196 <get_ip+0x84>
        char ch = ip[i];
80100136:	8b 55 ec             	mov    -0x14(%ebp),%edx
80100139:	8b 45 08             	mov    0x8(%ebp),%eax
8010013c:	01 d0                	add    %edx,%eax
8010013e:	0f b6 00             	movzbl (%eax),%eax
80100141:	88 45 e7             	mov    %al,-0x19(%ebp)
        if (ch == '.') {
80100144:	80 7d e7 2e          	cmpb   $0x2e,-0x19(%ebp)
80100148:	75 37                	jne    80100181 <get_ip+0x6f>
            arr[n1++] = '\0';
8010014a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014d:	8d 50 01             	lea    0x1(%eax),%edx
80100150:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100153:	c6 44 05 e3 00       	movb   $0x0,-0x1d(%ebp,%eax,1)
            n1 = 0;
80100158:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            ip_vals[n2++] = atoi(arr);
8010015f:	83 ec 0c             	sub    $0xc,%esp
80100162:	8d 45 e3             	lea    -0x1d(%ebp),%eax
80100165:	50                   	push   %eax
80100166:	e8 84 8e 00 00       	call   80108fef <atoi>
8010016b:	83 c4 10             	add    $0x10,%esp
8010016e:	89 c1                	mov    %eax,%ecx
80100170:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100173:	8d 50 01             	lea    0x1(%eax),%edx
80100176:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100179:	89 ca                	mov    %ecx,%edx
8010017b:	89 54 85 d0          	mov    %edx,-0x30(%ebp,%eax,4)
8010017f:	eb 11                	jmp    80100192 <get_ip+0x80>
       	    //cprintf("Check ipval:%d , arr:%s",ip_vals[n2],arr);
	} else {

		arr[n1++] = ch;
80100181:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100184:	8d 50 01             	lea    0x1(%eax),%edx
80100187:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010018a:	0f b6 55 e7          	movzbl -0x19(%ebp),%edx
8010018e:	88 54 05 e3          	mov    %dl,-0x1d(%ebp,%eax,1)
     for (int i =0; i<len; i++) {
80100192:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100196:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100199:	39 45 0c             	cmp    %eax,0xc(%ebp)
8010019c:	77 98                	ja     80100136 <get_ip+0x24>
	}
    }

        arr[n1++] = '\0';
8010019e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001a1:	8d 50 01             	lea    0x1(%eax),%edx
801001a4:	89 55 f4             	mov    %edx,-0xc(%ebp)
801001a7:	c6 44 05 e3 00       	movb   $0x0,-0x1d(%ebp,%eax,1)
        n1 = 0;
801001ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
        ip_vals[n2++] = atoi(arr);
801001b3:	83 ec 0c             	sub    $0xc,%esp
801001b6:	8d 45 e3             	lea    -0x1d(%ebp),%eax
801001b9:	50                   	push   %eax
801001ba:	e8 30 8e 00 00       	call   80108fef <atoi>
801001bf:	83 c4 10             	add    $0x10,%esp
801001c2:	89 c1                	mov    %eax,%ecx
801001c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801001c7:	8d 50 01             	lea    0x1(%eax),%edx
801001ca:	89 55 f0             	mov    %edx,-0x10(%ebp)
801001cd:	89 ca                	mov    %ecx,%edx
801001cf:	89 54 85 d0          	mov    %edx,-0x30(%ebp,%eax,4)
        //cprintf("Final Check ipval:%d , arr:%s",ip_vals[n2],arr);

//	ipv4 = (ip_vals[0]<<24) + (ip_vals[1]<<16) + (ip_vals[2]<<8) + ip_vals[3];
	ipv4 = (ip_vals[3]<<24) + (ip_vals[2]<<16) + (ip_vals[1]<<8) + ip_vals[0];
801001d3:	8b 45 dc             	mov    -0x24(%ebp),%eax
801001d6:	c1 e0 18             	shl    $0x18,%eax
801001d9:	89 c2                	mov    %eax,%edx
801001db:	8b 45 d8             	mov    -0x28(%ebp),%eax
801001de:	c1 e0 10             	shl    $0x10,%eax
801001e1:	01 c2                	add    %eax,%edx
801001e3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801001e6:	c1 e0 08             	shl    $0x8,%eax
801001e9:	01 c2                	add    %eax,%edx
801001eb:	8b 45 d0             	mov    -0x30(%ebp),%eax
801001ee:	01 d0                	add    %edx,%eax
801001f0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return ipv4;
801001f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
}
801001f6:	c9                   	leave  
801001f7:	c3                   	ret    

801001f8 <htons>:
uint16_t htons(uint16_t v) {
801001f8:	55                   	push   %ebp
801001f9:	89 e5                	mov    %esp,%ebp
801001fb:	83 ec 04             	sub    $0x4,%esp
801001fe:	8b 45 08             	mov    0x8(%ebp),%eax
80100201:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  return (v >> 8) | (v << 8);
80100205:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80100209:	66 c1 e8 08          	shr    $0x8,%ax
8010020d:	89 c2                	mov    %eax,%edx
8010020f:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80100213:	c1 e0 08             	shl    $0x8,%eax
80100216:	09 d0                	or     %edx,%eax
}
80100218:	c9                   	leave  
80100219:	c3                   	ret    

8010021a <htonl>:
uint32_t htonl(uint32_t v) {
8010021a:	55                   	push   %ebp
8010021b:	89 e5                	mov    %esp,%ebp
8010021d:	53                   	push   %ebx
  return htons(v >> 16) | (htons((uint16_t) v) << 16);
8010021e:	8b 45 08             	mov    0x8(%ebp),%eax
80100221:	c1 e8 10             	shr    $0x10,%eax
80100224:	0f b7 c0             	movzwl %ax,%eax
80100227:	50                   	push   %eax
80100228:	e8 cb ff ff ff       	call   801001f8 <htons>
8010022d:	83 c4 04             	add    $0x4,%esp
80100230:	0f b7 d8             	movzwl %ax,%ebx
80100233:	8b 45 08             	mov    0x8(%ebp),%eax
80100236:	0f b7 c0             	movzwl %ax,%eax
80100239:	50                   	push   %eax
8010023a:	e8 b9 ff ff ff       	call   801001f8 <htons>
8010023f:	83 c4 04             	add    $0x4,%esp
80100242:	0f b7 c0             	movzwl %ax,%eax
80100245:	c1 e0 10             	shl    $0x10,%eax
80100248:	09 d8                	or     %ebx,%eax
}
8010024a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010024d:	c9                   	leave  
8010024e:	c3                   	ret    

8010024f <create_eth_arp_frame>:

int create_eth_arp_frame(uint8_t* smac, const char *srcIpAddr, uint8_t *dmac, const char* ipAddr, bool is_reply, uint8_t* macMsg, struct ethr_hdr *eth) {
8010024f:	55                   	push   %ebp
80100250:	89 e5                	mov    %esp,%ebp
80100252:	57                   	push   %edi
80100253:	56                   	push   %esi
80100254:	53                   	push   %ebx
80100255:	83 ec 1c             	sub    $0x1c,%esp
80100258:	8b 45 18             	mov    0x18(%ebp),%eax
8010025b:	88 45 e4             	mov    %al,-0x1c(%ebp)
        if (dmac) {
8010025e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100262:	74 16                	je     8010027a <create_eth_arp_frame+0x2b>
          memmove(eth->dmac, dmac, 6);
80100264:	8b 45 20             	mov    0x20(%ebp),%eax
80100267:	83 ec 04             	sub    $0x4,%esp
8010026a:	6a 06                	push   $0x6
8010026c:	ff 75 10             	pushl  0x10(%ebp)
8010026f:	50                   	push   %eax
80100270:	e8 7d 66 00 00       	call   801068f2 <memmove>
80100275:	83 c4 10             	add    $0x10,%esp
80100278:	eb 14                	jmp    8010028e <create_eth_arp_frame+0x3f>
        } else {
	  pack_mac(eth->dmac, BROADCAST_MAC);
8010027a:	8b 45 20             	mov    0x20(%ebp),%eax
8010027d:	83 ec 08             	sub    $0x8,%esp
80100280:	68 e0 af 10 80       	push   $0x8010afe0
80100285:	50                   	push   %eax
80100286:	e8 07 fe ff ff       	call   80100092 <pack_mac>
8010028b:	83 c4 10             	add    $0x10,%esp
        }

	cprintf("Create ARP frame, sending to %x:%x:%x:%x:%x:%x\n", eth->dmac[0], eth->dmac[1], eth->dmac[2], eth->dmac[3], eth->dmac[4], eth->dmac[5]);
8010028e:	8b 45 20             	mov    0x20(%ebp),%eax
80100291:	0f b6 40 05          	movzbl 0x5(%eax),%eax
80100295:	0f b6 f8             	movzbl %al,%edi
80100298:	8b 45 20             	mov    0x20(%ebp),%eax
8010029b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
8010029f:	0f b6 f0             	movzbl %al,%esi
801002a2:	8b 45 20             	mov    0x20(%ebp),%eax
801002a5:	0f b6 40 03          	movzbl 0x3(%eax),%eax
801002a9:	0f b6 d8             	movzbl %al,%ebx
801002ac:	8b 45 20             	mov    0x20(%ebp),%eax
801002af:	0f b6 40 02          	movzbl 0x2(%eax),%eax
801002b3:	0f b6 c8             	movzbl %al,%ecx
801002b6:	8b 45 20             	mov    0x20(%ebp),%eax
801002b9:	0f b6 40 01          	movzbl 0x1(%eax),%eax
801002bd:	0f b6 d0             	movzbl %al,%edx
801002c0:	8b 45 20             	mov    0x20(%ebp),%eax
801002c3:	0f b6 00             	movzbl (%eax),%eax
801002c6:	0f b6 c0             	movzbl %al,%eax
801002c9:	83 ec 04             	sub    $0x4,%esp
801002cc:	57                   	push   %edi
801002cd:	56                   	push   %esi
801002ce:	53                   	push   %ebx
801002cf:	51                   	push   %ecx
801002d0:	52                   	push   %edx
801002d1:	50                   	push   %eax
801002d2:	68 f4 af 10 80       	push   $0x8010aff4
801002d7:	e8 3c 0b 00 00       	call   80100e18 <cprintf>
801002dc:	83 c4 20             	add    $0x20,%esp

	memmove(eth->smac, smac, 6);
801002df:	8b 45 20             	mov    0x20(%ebp),%eax
801002e2:	83 c0 06             	add    $0x6,%eax
801002e5:	83 ec 04             	sub    $0x4,%esp
801002e8:	6a 06                	push   $0x6
801002ea:	ff 75 08             	pushl  0x8(%ebp)
801002ed:	50                   	push   %eax
801002ee:	e8 ff 65 00 00       	call   801068f2 <memmove>
801002f3:	83 c4 10             	add    $0x10,%esp

	//ether type = 0x0806 for ARP
	eth->ethr_type = htons(0x0806);
801002f6:	83 ec 0c             	sub    $0xc,%esp
801002f9:	68 06 08 00 00       	push   $0x806
801002fe:	e8 f5 fe ff ff       	call   801001f8 <htons>
80100303:	83 c4 10             	add    $0x10,%esp
80100306:	89 c2                	mov    %eax,%edx
80100308:	8b 45 20             	mov    0x20(%ebp),%eax
8010030b:	66 89 50 0c          	mov    %dx,0xc(%eax)

	/** ARP packet filling **/
	eth->hwtype = htons(1);
8010030f:	83 ec 0c             	sub    $0xc,%esp
80100312:	6a 01                	push   $0x1
80100314:	e8 df fe ff ff       	call   801001f8 <htons>
80100319:	83 c4 10             	add    $0x10,%esp
8010031c:	89 c2                	mov    %eax,%edx
8010031e:	8b 45 20             	mov    0x20(%ebp),%eax
80100321:	66 89 50 0e          	mov    %dx,0xe(%eax)
	eth->protype = htons(0x0800);
80100325:	83 ec 0c             	sub    $0xc,%esp
80100328:	68 00 08 00 00       	push   $0x800
8010032d:	e8 c6 fe ff ff       	call   801001f8 <htons>
80100332:	83 c4 10             	add    $0x10,%esp
80100335:	89 c2                	mov    %eax,%edx
80100337:	8b 45 20             	mov    0x20(%ebp),%eax
8010033a:	66 89 50 10          	mov    %dx,0x10(%eax)

	eth->hwsize = 0x06;
8010033e:	8b 45 20             	mov    0x20(%ebp),%eax
80100341:	c6 40 12 06          	movb   $0x6,0x12(%eax)
	eth->prosize = 0x04;
80100345:	8b 45 20             	mov    0x20(%ebp),%eax
80100348:	c6 40 13 04          	movb   $0x4,0x13(%eax)

	//arp request
	eth->opcode = is_reply ? htons(2) : htons(1);
8010034c:	80 7d e4 00          	cmpb   $0x0,-0x1c(%ebp)
80100350:	74 11                	je     80100363 <create_eth_arp_frame+0x114>
80100352:	83 ec 0c             	sub    $0xc,%esp
80100355:	6a 02                	push   $0x2
80100357:	e8 9c fe ff ff       	call   801001f8 <htons>
8010035c:	83 c4 10             	add    $0x10,%esp
8010035f:	89 c2                	mov    %eax,%edx
80100361:	eb 0f                	jmp    80100372 <create_eth_arp_frame+0x123>
80100363:	83 ec 0c             	sub    $0xc,%esp
80100366:	6a 01                	push   $0x1
80100368:	e8 8b fe ff ff       	call   801001f8 <htons>
8010036d:	83 c4 10             	add    $0x10,%esp
80100370:	89 c2                	mov    %eax,%edx
80100372:	8b 45 20             	mov    0x20(%ebp),%eax
80100375:	66 89 50 14          	mov    %dx,0x14(%eax)

	/** ARP packet internal data filling **/
	memmove(eth->arp_smac, smac, 6);
80100379:	8b 45 20             	mov    0x20(%ebp),%eax
8010037c:	83 c0 16             	add    $0x16,%eax
8010037f:	83 ec 04             	sub    $0x4,%esp
80100382:	6a 06                	push   $0x6
80100384:	ff 75 08             	pushl  0x8(%ebp)
80100387:	50                   	push   %eax
80100388:	e8 65 65 00 00       	call   801068f2 <memmove>
8010038d:	83 c4 10             	add    $0x10,%esp
	memmove(eth->arp_dmac, macMsg, 6); // not needed for the request
80100390:	8b 45 20             	mov    0x20(%ebp),%eax
80100393:	83 c0 20             	add    $0x20,%eax
80100396:	83 ec 04             	sub    $0x4,%esp
80100399:	6a 06                	push   $0x6
8010039b:	ff 75 1c             	pushl  0x1c(%ebp)
8010039e:	50                   	push   %eax
8010039f:	e8 4e 65 00 00       	call   801068f2 <memmove>
801003a4:	83 c4 10             	add    $0x10,%esp

	eth->sip = get_ip(srcIpAddr, strlen(srcIpAddr));
801003a7:	83 ec 0c             	sub    $0xc,%esp
801003aa:	ff 75 0c             	pushl  0xc(%ebp)
801003ad:	e8 fe 66 00 00       	call   80106ab0 <strlen>
801003b2:	83 c4 10             	add    $0x10,%esp
801003b5:	83 ec 08             	sub    $0x8,%esp
801003b8:	50                   	push   %eax
801003b9:	ff 75 0c             	pushl  0xc(%ebp)
801003bc:	e8 51 fd ff ff       	call   80100112 <get_ip>
801003c1:	83 c4 10             	add    $0x10,%esp
801003c4:	89 c2                	mov    %eax,%edx
801003c6:	8b 45 20             	mov    0x20(%ebp),%eax
801003c9:	89 50 1c             	mov    %edx,0x1c(%eax)

	*(uint32_t*)(&eth->dip) = get_ip(ipAddr, strlen(ipAddr));
801003cc:	83 ec 0c             	sub    $0xc,%esp
801003cf:	ff 75 14             	pushl  0x14(%ebp)
801003d2:	e8 d9 66 00 00       	call   80106ab0 <strlen>
801003d7:	83 c4 10             	add    $0x10,%esp
801003da:	89 c2                	mov    %eax,%edx
801003dc:	8b 45 20             	mov    0x20(%ebp),%eax
801003df:	8d 58 26             	lea    0x26(%eax),%ebx
801003e2:	83 ec 08             	sub    $0x8,%esp
801003e5:	52                   	push   %edx
801003e6:	ff 75 14             	pushl  0x14(%ebp)
801003e9:	e8 24 fd ff ff       	call   80100112 <get_ip>
801003ee:	83 c4 10             	add    $0x10,%esp
801003f1:	89 03                	mov    %eax,(%ebx)

	return 0;
801003f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801003f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801003fb:	5b                   	pop    %ebx
801003fc:	5e                   	pop    %esi
801003fd:	5f                   	pop    %edi
801003fe:	5d                   	pop    %ebp
801003ff:	c3                   	ret    

80100400 <int_to_hex>:


char int_to_hex (uint n) {
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	83 ec 10             	sub    $0x10,%esp

    char ch = '0';
80100406:	c6 45 ff 30          	movb   $0x30,-0x1(%ebp)

    if (n >= 0 && n <= 9) {
8010040a:	83 7d 08 09          	cmpl   $0x9,0x8(%ebp)
8010040e:	77 0b                	ja     8010041b <int_to_hex+0x1b>
        ch = '0' + n;
80100410:	8b 45 08             	mov    0x8(%ebp),%eax
80100413:	83 c0 30             	add    $0x30,%eax
80100416:	88 45 ff             	mov    %al,-0x1(%ebp)
80100419:	eb 15                	jmp    80100430 <int_to_hex+0x30>
    }
    else if (n >= 10 && n <= 15) {
8010041b:	83 7d 08 09          	cmpl   $0x9,0x8(%ebp)
8010041f:	76 0f                	jbe    80100430 <int_to_hex+0x30>
80100421:	83 7d 08 0f          	cmpl   $0xf,0x8(%ebp)
80100425:	77 09                	ja     80100430 <int_to_hex+0x30>
        ch = 'A' + (n - 10);
80100427:	8b 45 08             	mov    0x8(%ebp),%eax
8010042a:	83 c0 37             	add    $0x37,%eax
8010042d:	88 45 ff             	mov    %al,-0x1(%ebp)
    }

    return ch;
80100430:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax

}
80100434:	c9                   	leave  
80100435:	c3                   	ret    

80100436 <unpack_mac>:
// parse the mac address
void unpack_mac(uint8_t* mac, char* mac_str) {
80100436:	55                   	push   %ebp
80100437:	89 e5                	mov    %esp,%ebp
80100439:	53                   	push   %ebx
8010043a:	83 ec 20             	sub    $0x20,%esp

    int c = 0;
8010043d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    for (int i = 0; i < 6; i++) {
80100444:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010044b:	eb 79                	jmp    801004c6 <unpack_mac+0x90>
        uint m = mac[i];
8010044d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100450:	8b 45 08             	mov    0x8(%ebp),%eax
80100453:	01 d0                	add    %edx,%eax
80100455:	0f b6 00             	movzbl (%eax),%eax
80100458:	0f b6 c0             	movzbl %al,%eax
8010045b:	89 45 f0             	mov    %eax,-0x10(%ebp)

        uint i2 = m & 0x0f;
8010045e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100461:	83 e0 0f             	and    $0xf,%eax
80100464:	89 45 ec             	mov    %eax,-0x14(%ebp)
        uint i1 = (m & 0xf0)>>4;
80100467:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010046a:	c1 e8 04             	shr    $0x4,%eax
8010046d:	83 e0 0f             	and    $0xf,%eax
80100470:	89 45 e8             	mov    %eax,-0x18(%ebp)

        mac_str[c++] = int_to_hex(i1);
80100473:	8b 45 f8             	mov    -0x8(%ebp),%eax
80100476:	8d 50 01             	lea    0x1(%eax),%edx
80100479:	89 55 f8             	mov    %edx,-0x8(%ebp)
8010047c:	89 c2                	mov    %eax,%edx
8010047e:	8b 45 0c             	mov    0xc(%ebp),%eax
80100481:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80100484:	ff 75 e8             	pushl  -0x18(%ebp)
80100487:	e8 74 ff ff ff       	call   80100400 <int_to_hex>
8010048c:	83 c4 04             	add    $0x4,%esp
8010048f:	88 03                	mov    %al,(%ebx)
        mac_str[c++] = int_to_hex(i2);
80100491:	8b 45 f8             	mov    -0x8(%ebp),%eax
80100494:	8d 50 01             	lea    0x1(%eax),%edx
80100497:	89 55 f8             	mov    %edx,-0x8(%ebp)
8010049a:	89 c2                	mov    %eax,%edx
8010049c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010049f:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801004a2:	ff 75 ec             	pushl  -0x14(%ebp)
801004a5:	e8 56 ff ff ff       	call   80100400 <int_to_hex>
801004aa:	83 c4 04             	add    $0x4,%esp
801004ad:	88 03                	mov    %al,(%ebx)

        mac_str[c++] = ':';
801004af:	8b 45 f8             	mov    -0x8(%ebp),%eax
801004b2:	8d 50 01             	lea    0x1(%eax),%edx
801004b5:	89 55 f8             	mov    %edx,-0x8(%ebp)
801004b8:	89 c2                	mov    %eax,%edx
801004ba:	8b 45 0c             	mov    0xc(%ebp),%eax
801004bd:	01 d0                	add    %edx,%eax
801004bf:	c6 00 3a             	movb   $0x3a,(%eax)
    for (int i = 0; i < 6; i++) {
801004c2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801004c6:	83 7d f4 05          	cmpl   $0x5,-0xc(%ebp)
801004ca:	7e 81                	jle    8010044d <unpack_mac+0x17>
    }

    mac_str[c-1] = '\0';
801004cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
801004cf:	8d 50 ff             	lea    -0x1(%eax),%edx
801004d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801004d5:	01 d0                	add    %edx,%eax
801004d7:	c6 00 00             	movb   $0x0,(%eax)

}
801004da:	90                   	nop
801004db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801004de:	c9                   	leave  
801004df:	c3                   	ret    

801004e0 <parse_ip>:

// parse the ip value
void parse_ip (uint32_t ip, char* ip_str) {
801004e0:	55                   	push   %ebp
801004e1:	89 e5                	mov    %esp,%ebp
801004e3:	83 ec 30             	sub    $0x30,%esp

    uint32_t v = 0xFF;
801004e6:	c7 45 fc ff 00 00 00 	movl   $0xff,-0x4(%ebp)
    uint32_t ip_vals[4];

    for (int i = 0; i < 4; i++) {
801004ed:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801004f4:	eb 21                	jmp    80100517 <parse_ip+0x37>
        ip_vals[i] = (ip & v) >> (8 * i);
801004f6:	8b 45 08             	mov    0x8(%ebp),%eax
801004f9:	23 45 fc             	and    -0x4(%ebp),%eax
801004fc:	89 c2                	mov    %eax,%edx
801004fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
80100501:	c1 e0 03             	shl    $0x3,%eax
80100504:	89 c1                	mov    %eax,%ecx
80100506:	d3 ea                	shr    %cl,%edx
80100508:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010050b:	89 54 85 d8          	mov    %edx,-0x28(%ebp,%eax,4)
        v  = v<<8;
8010050f:	c1 65 fc 08          	shll   $0x8,-0x4(%ebp)
    for (int i = 0; i < 4; i++) {
80100513:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80100517:	83 7d f8 03          	cmpl   $0x3,-0x8(%ebp)
8010051b:	7e d9                	jle    801004f6 <parse_ip+0x16>
    }

    int c = 0;
8010051d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    for (int i = 0; i < 4; i++) {
80100524:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010052b:	e9 d6 00 00 00       	jmp    80100606 <parse_ip+0x126>
        uint32_t ip1 = ip_vals[i];
80100530:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100533:	8b 44 85 d8          	mov    -0x28(%ebp,%eax,4),%eax
80100537:	89 45 ec             	mov    %eax,-0x14(%ebp)

        if (ip1 == 0) {
8010053a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010053e:	75 2b                	jne    8010056b <parse_ip+0x8b>
            ip_str[c++] = '0';
80100540:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100543:	8d 50 01             	lea    0x1(%eax),%edx
80100546:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100549:	89 c2                	mov    %eax,%edx
8010054b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010054e:	01 d0                	add    %edx,%eax
80100550:	c6 00 30             	movb   $0x30,(%eax)
            ip_str[c++] = '.';
80100553:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100556:	8d 50 01             	lea    0x1(%eax),%edx
80100559:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010055c:	89 c2                	mov    %eax,%edx
8010055e:	8b 45 0c             	mov    0xc(%ebp),%eax
80100561:	01 d0                	add    %edx,%eax
80100563:	c6 00 2e             	movb   $0x2e,(%eax)
80100566:	e9 97 00 00 00       	jmp    80100602 <parse_ip+0x122>
        }
        else {
            //unsigned int n_digits = 0;
            char arr[3];
            int j = 0;
8010056b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)

            while (ip1 > 0 && j < 3) {
80100572:	eb 42                	jmp    801005b6 <parse_ip+0xd6>
                arr[j++] = (ip1 % 10) + '0';
80100574:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80100577:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
8010057c:	89 c8                	mov    %ecx,%eax
8010057e:	f7 e2                	mul    %edx
80100580:	c1 ea 03             	shr    $0x3,%edx
80100583:	89 d0                	mov    %edx,%eax
80100585:	c1 e0 02             	shl    $0x2,%eax
80100588:	01 d0                	add    %edx,%eax
8010058a:	01 c0                	add    %eax,%eax
8010058c:	29 c1                	sub    %eax,%ecx
8010058e:	89 ca                	mov    %ecx,%edx
80100590:	89 d0                	mov    %edx,%eax
80100592:	8d 48 30             	lea    0x30(%eax),%ecx
80100595:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100598:	8d 50 01             	lea    0x1(%eax),%edx
8010059b:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010059e:	89 ca                	mov    %ecx,%edx
801005a0:	88 54 05 d5          	mov    %dl,-0x2b(%ebp,%eax,1)
                ip1 /= 10;
801005a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801005a7:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801005ac:	f7 e2                	mul    %edx
801005ae:	89 d0                	mov    %edx,%eax
801005b0:	c1 e8 03             	shr    $0x3,%eax
801005b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
            while (ip1 > 0 && j < 3) {
801005b6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801005ba:	74 06                	je     801005c2 <parse_ip+0xe2>
801005bc:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
801005c0:	7e b2                	jle    80100574 <parse_ip+0x94>
            }

            for (j = j-1; j >= 0; j--) {
801005c2:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
801005c6:	eb 21                	jmp    801005e9 <parse_ip+0x109>
                ip_str[c++] = arr[j];
801005c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005cb:	8d 50 01             	lea    0x1(%eax),%edx
801005ce:	89 55 f4             	mov    %edx,-0xc(%ebp)
801005d1:	89 c2                	mov    %eax,%edx
801005d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801005d6:	01 c2                	add    %eax,%edx
801005d8:	8d 4d d5             	lea    -0x2b(%ebp),%ecx
801005db:	8b 45 e8             	mov    -0x18(%ebp),%eax
801005de:	01 c8                	add    %ecx,%eax
801005e0:	0f b6 00             	movzbl (%eax),%eax
801005e3:	88 02                	mov    %al,(%edx)
            for (j = j-1; j >= 0; j--) {
801005e5:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
801005e9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801005ed:	79 d9                	jns    801005c8 <parse_ip+0xe8>
            }

            ip_str[c++] = '.';
801005ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005f2:	8d 50 01             	lea    0x1(%eax),%edx
801005f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
801005f8:	89 c2                	mov    %eax,%edx
801005fa:	8b 45 0c             	mov    0xc(%ebp),%eax
801005fd:	01 d0                	add    %edx,%eax
801005ff:	c6 00 2e             	movb   $0x2e,(%eax)
    for (int i = 0; i < 4; i++) {
80100602:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80100606:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
8010060a:	0f 8e 20 ff ff ff    	jle    80100530 <parse_ip+0x50>
        }
    }

    ip_str[c-1] = '\0';
80100610:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100613:	8d 50 ff             	lea    -0x1(%eax),%edx
80100616:	8b 45 0c             	mov    0xc(%ebp),%eax
80100619:	01 d0                	add    %edx,%eax
8010061b:	c6 00 00             	movb   $0x0,(%eax)

}
8010061e:	90                   	nop
8010061f:	c9                   	leave  
80100620:	c3                   	ret    

80100621 <parse_arp_packet>:

// ethernet packet arrived; parse and get the MAC address
int parse_arp_packet(const struct ethr_hdr *eth, const char *my_ip, bool expected_reply, uint8_t *received_from_mac, char *received_from_ip, uint8_t *mac_msg) {
80100621:	55                   	push   %ebp
80100622:	89 e5                	mov    %esp,%ebp
80100624:	83 ec 38             	sub    $0x38,%esp
80100627:	8b 45 10             	mov    0x10(%ebp),%eax
8010062a:	88 45 d4             	mov    %al,-0x2c(%ebp)
        uint16_t expected_opcode = expected_reply ? 0x0200 : 0x0100;
8010062d:	80 7d d4 00          	cmpb   $0x0,-0x2c(%ebp)
80100631:	74 07                	je     8010063a <parse_arp_packet+0x19>
80100633:	b8 00 02 00 00       	mov    $0x200,%eax
80100638:	eb 05                	jmp    8010063f <parse_arp_packet+0x1e>
8010063a:	b8 00 01 00 00       	mov    $0x100,%eax
8010063f:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

	if (eth->ethr_type != 0x0608) {
80100643:	8b 45 08             	mov    0x8(%ebp),%eax
80100646:	0f b7 40 0c          	movzwl 0xc(%eax),%eax
8010064a:	66 3d 08 06          	cmp    $0x608,%ax
8010064e:	74 25                	je     80100675 <parse_arp_packet+0x54>
		cprintf("Not an ARP packet: %x\n", eth->ethr_type);
80100650:	8b 45 08             	mov    0x8(%ebp),%eax
80100653:	0f b7 40 0c          	movzwl 0xc(%eax),%eax
80100657:	0f b7 c0             	movzwl %ax,%eax
8010065a:	83 ec 08             	sub    $0x8,%esp
8010065d:	50                   	push   %eax
8010065e:	68 24 b0 10 80       	push   $0x8010b024
80100663:	e8 b0 07 00 00       	call   80100e18 <cprintf>
80100668:	83 c4 10             	add    $0x10,%esp
		return -1;
8010066b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100670:	e9 ff 00 00 00       	jmp    80100774 <parse_arp_packet+0x153>
	}

	if (eth->protype != 0x0008) {
80100675:	8b 45 08             	mov    0x8(%ebp),%eax
80100678:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010067c:	66 83 f8 08          	cmp    $0x8,%ax
80100680:	74 1a                	je     8010069c <parse_arp_packet+0x7b>
		cprintf("Not IPV4 protocol\n");
80100682:	83 ec 0c             	sub    $0xc,%esp
80100685:	68 3b b0 10 80       	push   $0x8010b03b
8010068a:	e8 89 07 00 00       	call   80100e18 <cprintf>
8010068f:	83 c4 10             	add    $0x10,%esp
		return -1;
80100692:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100697:	e9 d8 00 00 00       	jmp    80100774 <parse_arp_packet+0x153>
	}

	if (eth->opcode != expected_opcode) {
8010069c:	8b 45 08             	mov    0x8(%ebp),%eax
8010069f:	0f b7 40 14          	movzwl 0x14(%eax),%eax
801006a3:	66 39 45 f6          	cmp    %ax,-0xa(%ebp)
801006a7:	74 25                	je     801006ce <parse_arp_packet+0xad>
		cprintf("Wrong opcode: %x\n", eth->opcode);
801006a9:	8b 45 08             	mov    0x8(%ebp),%eax
801006ac:	0f b7 40 14          	movzwl 0x14(%eax),%eax
801006b0:	0f b7 c0             	movzwl %ax,%eax
801006b3:	83 ec 08             	sub    $0x8,%esp
801006b6:	50                   	push   %eax
801006b7:	68 4e b0 10 80       	push   $0x8010b04e
801006bc:	e8 57 07 00 00       	call   80100e18 <cprintf>
801006c1:	83 c4 10             	add    $0x10,%esp
		return -1;
801006c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801006c9:	e9 a6 00 00 00       	jmp    80100774 <parse_arp_packet+0x153>
        */

	//parse sip; it should be equal to the one we sent
	char dst_ip[16];

	parse_ip(*(uint32_t*)(&eth->dip), dst_ip);
801006ce:	8b 45 08             	mov    0x8(%ebp),%eax
801006d1:	83 c0 26             	add    $0x26,%eax
801006d4:	8b 00                	mov    (%eax),%eax
801006d6:	83 ec 08             	sub    $0x8,%esp
801006d9:	8d 55 e6             	lea    -0x1a(%ebp),%edx
801006dc:	52                   	push   %edx
801006dd:	50                   	push   %eax
801006de:	e8 fd fd ff ff       	call   801004e0 <parse_ip>
801006e3:	83 c4 10             	add    $0x10,%esp

	if (strcmp(my_ip, (const char*)dst_ip)) {
801006e6:	83 ec 08             	sub    $0x8,%esp
801006e9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
801006ec:	50                   	push   %eax
801006ed:	ff 75 0c             	pushl  0xc(%ebp)
801006f0:	e8 e2 63 00 00       	call   80106ad7 <strcmp>
801006f5:	83 c4 10             	add    $0x10,%esp
801006f8:	85 c0                	test   %eax,%eax
801006fa:	74 1e                	je     8010071a <parse_arp_packet+0xf9>
	    cprintf("Not the intended recipient! Expected %s, got %s\n", my_ip, dst_ip);
801006fc:	83 ec 04             	sub    $0x4,%esp
801006ff:	8d 45 e6             	lea    -0x1a(%ebp),%eax
80100702:	50                   	push   %eax
80100703:	ff 75 0c             	pushl  0xc(%ebp)
80100706:	68 60 b0 10 80       	push   $0x8010b060
8010070b:	e8 08 07 00 00       	call   80100e18 <cprintf>
80100710:	83 c4 10             	add    $0x10,%esp
	    return -1;
80100713:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100718:	eb 5a                	jmp    80100774 <parse_arp_packet+0x153>
	}

        if (received_from_ip) {
8010071a:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
8010071e:	74 15                	je     80100735 <parse_arp_packet+0x114>
	  parse_ip(eth->sip, received_from_ip);
80100720:	8b 45 08             	mov    0x8(%ebp),%eax
80100723:	8b 40 1c             	mov    0x1c(%eax),%eax
80100726:	83 ec 08             	sub    $0x8,%esp
80100729:	ff 75 18             	pushl  0x18(%ebp)
8010072c:	50                   	push   %eax
8010072d:	e8 ae fd ff ff       	call   801004e0 <parse_ip>
80100732:	83 c4 10             	add    $0x10,%esp
        }

	//char mac[18];
	//unpack_mac(eth->arp_smac, mac_str);
        if (mac_msg) {
80100735:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
80100739:	74 17                	je     80100752 <parse_arp_packet+0x131>
          memmove(mac_msg, eth->arp_smac, 6);
8010073b:	8b 45 08             	mov    0x8(%ebp),%eax
8010073e:	83 c0 16             	add    $0x16,%eax
80100741:	83 ec 04             	sub    $0x4,%esp
80100744:	6a 06                	push   $0x6
80100746:	50                   	push   %eax
80100747:	ff 75 1c             	pushl  0x1c(%ebp)
8010074a:	e8 a3 61 00 00       	call   801068f2 <memmove>
8010074f:	83 c4 10             	add    $0x10,%esp
        }

        if (received_from_mac) {
80100752:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80100756:	74 17                	je     8010076f <parse_arp_packet+0x14e>
          memmove(received_from_mac, eth->smac, 6);
80100758:	8b 45 08             	mov    0x8(%ebp),%eax
8010075b:	83 c0 06             	add    $0x6,%eax
8010075e:	83 ec 04             	sub    $0x4,%esp
80100761:	6a 06                	push   $0x6
80100763:	50                   	push   %eax
80100764:	ff 75 14             	pushl  0x14(%ebp)
80100767:	e8 86 61 00 00       	call   801068f2 <memmove>
8010076c:	83 c4 10             	add    $0x10,%esp
        }

	//cprintf((char*)mac);

        return 0;
8010076f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100774:	c9                   	leave  
80100775:	c3                   	ret    

80100776 <block_until_arp_reply>:
#include "defs.h"
#include "arp_frame.h"
#include "e1000.h"
#include "nic.h"

static int block_until_arp_reply(struct ethr_hdr *arpReply) {
80100776:	55                   	push   %ebp
80100777:	89 e5                	mov    %esp,%ebp
  /**
   *TODO: repeated sleep. wake up on each network interrupt.
   *      check for ARP reply for this request.
   *      If received, unblock. else, sleep again.
   */
  return 0;
80100779:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010077e:	5d                   	pop    %ebp
8010077f:	c3                   	ret    

80100780 <send_arp>:

int send_arp(char* interface, const char *myIpAddr, uint8_t *dst_mac, char* ipAddr, bool is_reply, uint8_t *macMsg) {
80100780:	55                   	push   %ebp
80100781:	89 e5                	mov    %esp,%ebp
80100783:	53                   	push   %ebx
80100784:	83 ec 44             	sub    $0x44,%esp
80100787:	8b 45 18             	mov    0x18(%ebp),%eax
8010078a:	88 45 c4             	mov    %al,-0x3c(%ebp)
  cprintf("Create arp request for ip:%s over Interface:%s\n", ipAddr, interface);
8010078d:	83 ec 04             	sub    $0x4,%esp
80100790:	ff 75 08             	pushl  0x8(%ebp)
80100793:	ff 75 14             	pushl  0x14(%ebp)
80100796:	68 94 b0 10 80       	push   $0x8010b094
8010079b:	e8 78 06 00 00       	call   80100e18 <cprintf>
801007a0:	83 c4 10             	add    $0x10,%esp

  struct nic_device *nd;
  if(get_device(interface, &nd) < 0) {
801007a3:	83 ec 08             	sub    $0x8,%esp
801007a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801007a9:	50                   	push   %eax
801007aa:	ff 75 08             	pushl  0x8(%ebp)
801007ad:	e8 4e 02 00 00       	call   80100a00 <get_device>
801007b2:	83 c4 10             	add    $0x10,%esp
801007b5:	85 c0                	test   %eax,%eax
801007b7:	79 17                	jns    801007d0 <send_arp+0x50>
    cprintf("ERROR:send_arpRequest:Device not loaded\n");
801007b9:	83 ec 0c             	sub    $0xc,%esp
801007bc:	68 c4 b0 10 80       	push   $0x8010b0c4
801007c1:	e8 52 06 00 00       	call   80100e18 <cprintf>
801007c6:	83 c4 10             	add    $0x10,%esp
    return -1;
801007c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801007ce:	eb 4a                	jmp    8010081a <send_arp+0x9a>
  }

  struct ethr_hdr eth;
  create_eth_arp_frame(nd->mac_addr, myIpAddr, is_reply ? dst_mac : NULL, ipAddr, is_reply, macMsg, &eth);
801007d0:	0f b6 55 c4          	movzbl -0x3c(%ebp),%edx
801007d4:	80 7d c4 00          	cmpb   $0x0,-0x3c(%ebp)
801007d8:	74 05                	je     801007df <send_arp+0x5f>
801007da:	8b 45 10             	mov    0x10(%ebp),%eax
801007dd:	eb 05                	jmp    801007e4 <send_arp+0x64>
801007df:	b8 00 00 00 00       	mov    $0x0,%eax
801007e4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801007e7:	89 cb                	mov    %ecx,%ebx
801007e9:	83 ec 04             	sub    $0x4,%esp
801007ec:	8d 4d c8             	lea    -0x38(%ebp),%ecx
801007ef:	51                   	push   %ecx
801007f0:	ff 75 1c             	pushl  0x1c(%ebp)
801007f3:	52                   	push   %edx
801007f4:	ff 75 14             	pushl  0x14(%ebp)
801007f7:	50                   	push   %eax
801007f8:	ff 75 0c             	pushl  0xc(%ebp)
801007fb:	53                   	push   %ebx
801007fc:	e8 4e fa ff ff       	call   8010024f <create_eth_arp_frame>
80100801:	83 c4 20             	add    $0x20,%esp
  e1000_transmit((char *)&eth, sizeof(eth)-2);
80100804:	83 ec 08             	sub    $0x8,%esp
80100807:	6a 2a                	push   $0x2a
80100809:	8d 45 c8             	lea    -0x38(%ebp),%eax
8010080c:	50                   	push   %eax
8010080d:	e8 85 0d 00 00       	call   80101597 <e1000_transmit>
80100812:	83 c4 10             	add    $0x10,%esp

  return 0;
80100815:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010081a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010081d:	c9                   	leave  
8010081e:	c3                   	ret    

8010081f <recv_arp>:

int recv_arp(const char *myIpAddr, bool expected_reply, uint8_t *received_from_mac, char *received_from_ip, char *arpMsgMac) {
8010081f:	55                   	push   %ebp
80100820:	89 e5                	mov    %esp,%ebp
80100822:	83 ec 58             	sub    $0x58,%esp
80100825:	8b 45 0c             	mov    0xc(%ebp),%eax
80100828:	88 45 b4             	mov    %al,-0x4c(%ebp)

  uint8_t arpMsgMacBytes[6];


  while (true) {
    int status = e1000_receive((char*)&eth, sizeof(eth) - 2);
8010082b:	83 ec 08             	sub    $0x8,%esp
8010082e:	6a 2a                	push   $0x2a
80100830:	8d 45 c8             	lea    -0x38(%ebp),%eax
80100833:	50                   	push   %eax
80100834:	e8 68 0d 00 00       	call   801015a1 <e1000_receive>
80100839:	83 c4 10             	add    $0x10,%esp
8010083c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (status < 0) {
8010083f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100843:	79 17                	jns    8010085c <recv_arp+0x3d>
      cprintf("Error: in e1000 receive\n");   
80100845:	83 ec 0c             	sub    $0xc,%esp
80100848:	68 ed b0 10 80       	push   $0x8010b0ed
8010084d:	e8 c6 05 00 00       	call   80100e18 <cprintf>
80100852:	83 c4 10             	add    $0x10,%esp
      return -1;
80100855:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010085a:	eb 7b                	jmp    801008d7 <recv_arp+0xb8>
    } else if(status) {
8010085c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100860:	74 5d                	je     801008bf <recv_arp+0xa0>
      cprintf("received arp message!\n");
80100862:	83 ec 0c             	sub    $0xc,%esp
80100865:	68 06 b1 10 80       	push   $0x8010b106
8010086a:	e8 a9 05 00 00       	call   80100e18 <cprintf>
8010086f:	83 c4 10             	add    $0x10,%esp
      if (parse_arp_packet(&eth, myIpAddr, expected_reply, received_from_mac, received_from_ip, arpMsgMacBytes) < 0) {
80100872:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80100876:	83 ec 08             	sub    $0x8,%esp
80100879:	8d 55 c2             	lea    -0x3e(%ebp),%edx
8010087c:	52                   	push   %edx
8010087d:	ff 75 14             	pushl  0x14(%ebp)
80100880:	ff 75 10             	pushl  0x10(%ebp)
80100883:	50                   	push   %eax
80100884:	ff 75 08             	pushl  0x8(%ebp)
80100887:	8d 45 c8             	lea    -0x38(%ebp),%eax
8010088a:	50                   	push   %eax
8010088b:	e8 91 fd ff ff       	call   80100621 <parse_arp_packet>
80100890:	83 c4 20             	add    $0x20,%esp
80100893:	85 c0                	test   %eax,%eax
80100895:	78 3a                	js     801008d1 <recv_arp+0xb2>
        continue;
      }

      if (arpMsgMac) {
80100897:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
8010089b:	74 1b                	je     801008b8 <recv_arp+0x99>
        unpack_mac(arpMsgMacBytes, arpMsgMac);
8010089d:	83 ec 08             	sub    $0x8,%esp
801008a0:	ff 75 18             	pushl  0x18(%ebp)
801008a3:	8d 45 c2             	lea    -0x3e(%ebp),%eax
801008a6:	50                   	push   %eax
801008a7:	e8 8a fb ff ff       	call   80100436 <unpack_mac>
801008ac:	83 c4 10             	add    $0x10,%esp
        arpMsgMac[17] = '\0';
801008af:	8b 45 18             	mov    0x18(%ebp),%eax
801008b2:	83 c0 11             	add    $0x11,%eax
801008b5:	c6 00 00             	movb   $0x0,(%eax)
      }

      return 0; // successfully received
801008b8:	b8 00 00 00 00       	mov    $0x0,%eax
801008bd:	eb 18                	jmp    801008d7 <recv_arp+0xb8>
    }

    timed_sleep(10);
801008bf:	83 ec 0c             	sub    $0xc,%esp
801008c2:	6a 0a                	push   $0xa
801008c4:	e8 07 75 00 00       	call   80107dd0 <timed_sleep>
801008c9:	83 c4 10             	add    $0x10,%esp
801008cc:	e9 5a ff ff ff       	jmp    8010082b <recv_arp+0xc>
        continue;
801008d1:	90                   	nop
  while (true) {
801008d2:	e9 54 ff ff ff       	jmp    8010082b <recv_arp+0xc>
  }
}
801008d7:	c9                   	leave  
801008d8:	c3                   	ret    

801008d9 <send_arpRequest>:

int send_arpRequest(char *interface, char *ipAddr, char *arpResp) {
801008d9:	55                   	push   %ebp
801008da:	89 e5                	mov    %esp,%ebp
801008dc:	83 ec 18             	sub    $0x18,%esp
  const char *sender_ip = "192.168.1.1";
801008df:	c7 45 f4 1d b1 10 80 	movl   $0x8010b11d,-0xc(%ebp)
  uint8_t emptymac[6];

  cprintf("Sending ARP request\n");
801008e6:	83 ec 0c             	sub    $0xc,%esp
801008e9:	68 29 b1 10 80       	push   $0x8010b129
801008ee:	e8 25 05 00 00       	call   80100e18 <cprintf>
801008f3:	83 c4 10             	add    $0x10,%esp
  send_arp(interface, sender_ip, NULL, ipAddr, false, emptymac);
801008f6:	83 ec 08             	sub    $0x8,%esp
801008f9:	8d 45 ee             	lea    -0x12(%ebp),%eax
801008fc:	50                   	push   %eax
801008fd:	6a 00                	push   $0x0
801008ff:	ff 75 0c             	pushl  0xc(%ebp)
80100902:	6a 00                	push   $0x0
80100904:	ff 75 f4             	pushl  -0xc(%ebp)
80100907:	ff 75 08             	pushl  0x8(%ebp)
8010090a:	e8 71 fe ff ff       	call   80100780 <send_arp>
8010090f:	83 c4 20             	add    $0x20,%esp

  cprintf("Sent ARP request\n");
80100912:	83 ec 0c             	sub    $0xc,%esp
80100915:	68 3e b1 10 80       	push   $0x8010b13e
8010091a:	e8 f9 04 00 00       	call   80100e18 <cprintf>
8010091f:	83 c4 10             	add    $0x10,%esp

  //struct ethr_hdr arpResponse;
  if(recv_arp(sender_ip, true, NULL, NULL, arpResp) < 0) {
80100922:	83 ec 0c             	sub    $0xc,%esp
80100925:	ff 75 10             	pushl  0x10(%ebp)
80100928:	6a 00                	push   $0x0
8010092a:	6a 00                	push   $0x0
8010092c:	6a 01                	push   $0x1
8010092e:	ff 75 f4             	pushl  -0xc(%ebp)
80100931:	e8 e9 fe ff ff       	call   8010081f <recv_arp>
80100936:	83 c4 20             	add    $0x20,%esp
80100939:	85 c0                	test   %eax,%eax
8010093b:	79 17                	jns    80100954 <send_arpRequest+0x7b>
    cprintf("ERROR:send_arpRequest:Failed to recv ARP response over the NIC\n");
8010093d:	83 ec 0c             	sub    $0xc,%esp
80100940:	68 50 b1 10 80       	push   $0x8010b150
80100945:	e8 ce 04 00 00       	call   80100e18 <cprintf>
8010094a:	83 c4 10             	add    $0x10,%esp
    return -3;
8010094d:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
80100952:	eb 05                	jmp    80100959 <send_arpRequest+0x80>
  }

  return 0;
80100954:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100959:	c9                   	leave  
8010095a:	c3                   	ret    

8010095b <recv_arpRequest>:

int recv_arpRequest(char *interface) {
8010095b:	55                   	push   %ebp
8010095c:	89 e5                	mov    %esp,%ebp
8010095e:	83 ec 28             	sub    $0x28,%esp
  const char *receiver_ip = "192.168.2.1";
80100961:	c7 45 f4 90 b1 10 80 	movl   $0x8010b190,-0xc(%ebp)

  struct nic_device *nd;
  if(get_device(interface, &nd) < 0) {
80100968:	83 ec 08             	sub    $0x8,%esp
8010096b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010096e:	50                   	push   %eax
8010096f:	ff 75 08             	pushl  0x8(%ebp)
80100972:	e8 89 00 00 00       	call   80100a00 <get_device>
80100977:	83 c4 10             	add    $0x10,%esp
8010097a:	85 c0                	test   %eax,%eax
8010097c:	79 17                	jns    80100995 <recv_arpRequest+0x3a>
    cprintf("ERROR:recv_arp:Device not loaded\n");
8010097e:	83 ec 0c             	sub    $0xc,%esp
80100981:	68 9c b1 10 80       	push   $0x8010b19c
80100986:	e8 8d 04 00 00       	call   80100e18 <cprintf>
8010098b:	83 c4 10             	add    $0x10,%esp
    return -1;
8010098e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100993:	eb 69                	jmp    801009fe <recv_arpRequest+0xa3>
  }

  cprintf("Receiving ARP request\n");
80100995:	83 ec 0c             	sub    $0xc,%esp
80100998:	68 be b1 10 80       	push   $0x8010b1be
8010099d:	e8 76 04 00 00       	call   80100e18 <cprintf>
801009a2:	83 c4 10             	add    $0x10,%esp

  uint8_t received_from_mac[6];
  char received_from_ip[16];

  if(recv_arp(receiver_ip, false, received_from_mac, received_from_ip, NULL) < 0) {
801009a5:	83 ec 0c             	sub    $0xc,%esp
801009a8:	6a 00                	push   $0x0
801009aa:	8d 45 da             	lea    -0x26(%ebp),%eax
801009ad:	50                   	push   %eax
801009ae:	8d 45 ea             	lea    -0x16(%ebp),%eax
801009b1:	50                   	push   %eax
801009b2:	6a 00                	push   $0x0
801009b4:	ff 75 f4             	pushl  -0xc(%ebp)
801009b7:	e8 63 fe ff ff       	call   8010081f <recv_arp>
801009bc:	83 c4 20             	add    $0x20,%esp
801009bf:	85 c0                	test   %eax,%eax
801009c1:	79 17                	jns    801009da <recv_arpRequest+0x7f>
    cprintf("ERROR:recv_arpRequest:Failed to recv ARP request over the NIC\n");
801009c3:	83 ec 0c             	sub    $0xc,%esp
801009c6:	68 d8 b1 10 80       	push   $0x8010b1d8
801009cb:	e8 48 04 00 00       	call   80100e18 <cprintf>
801009d0:	83 c4 10             	add    $0x10,%esp
    return -3;
801009d3:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
801009d8:	eb 24                	jmp    801009fe <recv_arpRequest+0xa3>
  }

  send_arp(interface, receiver_ip, received_from_mac, received_from_ip, true, nd->mac_addr);
801009da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801009dd:	83 ec 08             	sub    $0x8,%esp
801009e0:	50                   	push   %eax
801009e1:	6a 01                	push   $0x1
801009e3:	8d 45 da             	lea    -0x26(%ebp),%eax
801009e6:	50                   	push   %eax
801009e7:	8d 45 ea             	lea    -0x16(%ebp),%eax
801009ea:	50                   	push   %eax
801009eb:	ff 75 f4             	pushl  -0xc(%ebp)
801009ee:	ff 75 08             	pushl  0x8(%ebp)
801009f1:	e8 8a fd ff ff       	call   80100780 <send_arp>
801009f6:	83 c4 20             	add    $0x20,%esp
  return 0;
801009f9:	b8 00 00 00 00       	mov    $0x0,%eax
}
801009fe:	c9                   	leave  
801009ff:	c3                   	ret    

80100a00 <get_device>:
#include "nic.h"
#include "defs.h"

int get_device(char* interface, struct nic_device** nd) {
80100a00:	55                   	push   %ebp
80100a01:	89 e5                	mov    %esp,%ebp
80100a03:	83 ec 08             	sub    $0x8,%esp
  cprintf("get device for interface=%s\n", interface);
80100a06:	83 ec 08             	sub    $0x8,%esp
80100a09:	ff 75 08             	pushl  0x8(%ebp)
80100a0c:	68 17 b2 10 80       	push   $0x8010b217
80100a11:	e8 02 04 00 00       	call   80100e18 <cprintf>
80100a16:	83 c4 10             	add    $0x10,%esp
   * this will suffice
   */
   //if(nic_devices[0].send_packet == 0 || nic_devices[0].recv_packet == 0) {
   //  return -1;
   //}
   *nd = &nic_devices[0];
80100a19:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a1c:	c7 00 e0 aa 12 80    	movl   $0x8012aae0,(%eax)

   return 0;
80100a22:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100a27:	c9                   	leave  
80100a28:	c3                   	ret    

80100a29 <register_device>:

void register_device(struct nic_device nd) {
80100a29:	55                   	push   %ebp
80100a2a:	89 e5                	mov    %esp,%ebp
  nic_devices[0] = nd;
80100a2c:	8b 45 08             	mov    0x8(%ebp),%eax
80100a2f:	a3 e0 aa 12 80       	mov    %eax,0x8012aae0
80100a34:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
80100a38:	66 a3 e4 aa 12 80    	mov    %ax,0x8012aae4
}
80100a3e:	90                   	nop
80100a3f:	5d                   	pop    %ebp
80100a40:	c3                   	ret    

80100a41 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100a41:	55                   	push   %ebp
80100a42:	89 e5                	mov    %esp,%ebp
80100a44:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100a47:	83 ec 08             	sub    $0x8,%esp
80100a4a:	68 34 b2 10 80       	push   $0x8010b234
80100a4f:	68 00 ab 12 80       	push   $0x8012ab00
80100a54:	e8 42 5b 00 00       	call   8010659b <initlock>
80100a59:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100a5c:	c7 05 10 ea 12 80 04 	movl   $0x8012ea04,0x8012ea10
80100a63:	ea 12 80 
  bcache.head.next = &bcache.head;
80100a66:	c7 05 14 ea 12 80 04 	movl   $0x8012ea04,0x8012ea14
80100a6d:	ea 12 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100a70:	c7 45 f4 34 ab 12 80 	movl   $0x8012ab34,-0xc(%ebp)
80100a77:	eb 3a                	jmp    80100ab3 <binit+0x72>
    b->next = bcache.head.next;
80100a79:	8b 15 14 ea 12 80    	mov    0x8012ea14,%edx
80100a7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a82:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a88:	c7 40 0c 04 ea 12 80 	movl   $0x8012ea04,0xc(%eax)
    b->dev = -1;
80100a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a92:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
80100a99:	a1 14 ea 12 80       	mov    0x8012ea14,%eax
80100a9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100aa1:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100aa7:	a3 14 ea 12 80       	mov    %eax,0x8012ea14
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100aac:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
80100ab3:	b8 04 ea 12 80       	mov    $0x8012ea04,%eax
80100ab8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100abb:	72 bc                	jb     80100a79 <binit+0x38>
  }
}
80100abd:	90                   	nop
80100abe:	c9                   	leave  
80100abf:	c3                   	ret    

80100ac0 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint blockno)
{
80100ac0:	55                   	push   %ebp
80100ac1:	89 e5                	mov    %esp,%ebp
80100ac3:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
80100ac6:	83 ec 0c             	sub    $0xc,%esp
80100ac9:	68 00 ab 12 80       	push   $0x8012ab00
80100ace:	e8 ea 5a 00 00       	call   801065bd <acquire>
80100ad3:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100ad6:	a1 14 ea 12 80       	mov    0x8012ea14,%eax
80100adb:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100ade:	eb 67                	jmp    80100b47 <bget+0x87>
    if(b->dev == dev && b->blockno == blockno){
80100ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ae3:	8b 40 04             	mov    0x4(%eax),%eax
80100ae6:	39 45 08             	cmp    %eax,0x8(%ebp)
80100ae9:	75 53                	jne    80100b3e <bget+0x7e>
80100aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100aee:	8b 40 08             	mov    0x8(%eax),%eax
80100af1:	39 45 0c             	cmp    %eax,0xc(%ebp)
80100af4:	75 48                	jne    80100b3e <bget+0x7e>
      if(!(b->flags & B_BUSY)){
80100af6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100af9:	8b 00                	mov    (%eax),%eax
80100afb:	83 e0 01             	and    $0x1,%eax
80100afe:	85 c0                	test   %eax,%eax
80100b00:	75 27                	jne    80100b29 <bget+0x69>
        b->flags |= B_BUSY;
80100b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b05:	8b 00                	mov    (%eax),%eax
80100b07:	83 c8 01             	or     $0x1,%eax
80100b0a:	89 c2                	mov    %eax,%edx
80100b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b0f:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	68 00 ab 12 80       	push   $0x8012ab00
80100b19:	e8 0b 5b 00 00       	call   80106629 <release>
80100b1e:	83 c4 10             	add    $0x10,%esp
        return b;
80100b21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b24:	e9 98 00 00 00       	jmp    80100bc1 <bget+0x101>
      }
      sleep(b, &bcache.lock);
80100b29:	83 ec 08             	sub    $0x8,%esp
80100b2c:	68 00 ab 12 80       	push   $0x8012ab00
80100b31:	ff 75 f4             	pushl  -0xc(%ebp)
80100b34:	e8 82 57 00 00       	call   801062bb <sleep>
80100b39:	83 c4 10             	add    $0x10,%esp
      goto loop;
80100b3c:	eb 98                	jmp    80100ad6 <bget+0x16>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b41:	8b 40 10             	mov    0x10(%eax),%eax
80100b44:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100b47:	81 7d f4 04 ea 12 80 	cmpl   $0x8012ea04,-0xc(%ebp)
80100b4e:	75 90                	jne    80100ae0 <bget+0x20>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100b50:	a1 10 ea 12 80       	mov    0x8012ea10,%eax
80100b55:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100b58:	eb 51                	jmp    80100bab <bget+0xeb>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100b5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b5d:	8b 00                	mov    (%eax),%eax
80100b5f:	83 e0 01             	and    $0x1,%eax
80100b62:	85 c0                	test   %eax,%eax
80100b64:	75 3c                	jne    80100ba2 <bget+0xe2>
80100b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b69:	8b 00                	mov    (%eax),%eax
80100b6b:	83 e0 04             	and    $0x4,%eax
80100b6e:	85 c0                	test   %eax,%eax
80100b70:	75 30                	jne    80100ba2 <bget+0xe2>
      b->dev = dev;
80100b72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b75:	8b 55 08             	mov    0x8(%ebp),%edx
80100b78:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
80100b7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b7e:	8b 55 0c             	mov    0xc(%ebp),%edx
80100b81:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b87:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100b8d:	83 ec 0c             	sub    $0xc,%esp
80100b90:	68 00 ab 12 80       	push   $0x8012ab00
80100b95:	e8 8f 5a 00 00       	call   80106629 <release>
80100b9a:	83 c4 10             	add    $0x10,%esp
      return b;
80100b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ba0:	eb 1f                	jmp    80100bc1 <bget+0x101>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100ba2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ba5:	8b 40 0c             	mov    0xc(%eax),%eax
80100ba8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100bab:	81 7d f4 04 ea 12 80 	cmpl   $0x8012ea04,-0xc(%ebp)
80100bb2:	75 a6                	jne    80100b5a <bget+0x9a>
    }
  }
  panic("bget: no buffers");
80100bb4:	83 ec 0c             	sub    $0xc,%esp
80100bb7:	68 3b b2 10 80       	push   $0x8010b23b
80100bbc:	e8 7d 02 00 00       	call   80100e3e <panic>
}
80100bc1:	c9                   	leave  
80100bc2:	c3                   	ret    

80100bc3 <bread>:

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
80100bc3:	55                   	push   %ebp
80100bc4:	89 e5                	mov    %esp,%ebp
80100bc6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
80100bc9:	83 ec 08             	sub    $0x8,%esp
80100bcc:	ff 75 0c             	pushl  0xc(%ebp)
80100bcf:	ff 75 08             	pushl  0x8(%ebp)
80100bd2:	e8 e9 fe ff ff       	call   80100ac0 <bget>
80100bd7:	83 c4 10             	add    $0x10,%esp
80100bda:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID)) {
80100bdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100be0:	8b 00                	mov    (%eax),%eax
80100be2:	83 e0 02             	and    $0x2,%eax
80100be5:	85 c0                	test   %eax,%eax
80100be7:	75 0e                	jne    80100bf7 <bread+0x34>
    iderw(b);
80100be9:	83 ec 0c             	sub    $0xc,%esp
80100bec:	ff 75 f4             	pushl  -0xc(%ebp)
80100bef:	e8 3c 2b 00 00       	call   80103730 <iderw>
80100bf4:	83 c4 10             	add    $0x10,%esp
  }
  return b;
80100bf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80100bfa:	c9                   	leave  
80100bfb:	c3                   	ret    

80100bfc <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
80100bfc:	55                   	push   %ebp
80100bfd:	89 e5                	mov    %esp,%ebp
80100bff:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100c02:	8b 45 08             	mov    0x8(%ebp),%eax
80100c05:	8b 00                	mov    (%eax),%eax
80100c07:	83 e0 01             	and    $0x1,%eax
80100c0a:	85 c0                	test   %eax,%eax
80100c0c:	75 0d                	jne    80100c1b <bwrite+0x1f>
    panic("bwrite");
80100c0e:	83 ec 0c             	sub    $0xc,%esp
80100c11:	68 4c b2 10 80       	push   $0x8010b24c
80100c16:	e8 23 02 00 00       	call   80100e3e <panic>
  b->flags |= B_DIRTY;
80100c1b:	8b 45 08             	mov    0x8(%ebp),%eax
80100c1e:	8b 00                	mov    (%eax),%eax
80100c20:	83 c8 04             	or     $0x4,%eax
80100c23:	89 c2                	mov    %eax,%edx
80100c25:	8b 45 08             	mov    0x8(%ebp),%eax
80100c28:	89 10                	mov    %edx,(%eax)
  iderw(b);
80100c2a:	83 ec 0c             	sub    $0xc,%esp
80100c2d:	ff 75 08             	pushl  0x8(%ebp)
80100c30:	e8 fb 2a 00 00       	call   80103730 <iderw>
80100c35:	83 c4 10             	add    $0x10,%esp
}
80100c38:	90                   	nop
80100c39:	c9                   	leave  
80100c3a:	c3                   	ret    

80100c3b <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100c3b:	55                   	push   %ebp
80100c3c:	89 e5                	mov    %esp,%ebp
80100c3e:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100c41:	8b 45 08             	mov    0x8(%ebp),%eax
80100c44:	8b 00                	mov    (%eax),%eax
80100c46:	83 e0 01             	and    $0x1,%eax
80100c49:	85 c0                	test   %eax,%eax
80100c4b:	75 0d                	jne    80100c5a <brelse+0x1f>
    panic("brelse");
80100c4d:	83 ec 0c             	sub    $0xc,%esp
80100c50:	68 53 b2 10 80       	push   $0x8010b253
80100c55:	e8 e4 01 00 00       	call   80100e3e <panic>

  acquire(&bcache.lock);
80100c5a:	83 ec 0c             	sub    $0xc,%esp
80100c5d:	68 00 ab 12 80       	push   $0x8012ab00
80100c62:	e8 56 59 00 00       	call   801065bd <acquire>
80100c67:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
80100c6a:	8b 45 08             	mov    0x8(%ebp),%eax
80100c6d:	8b 40 10             	mov    0x10(%eax),%eax
80100c70:	8b 55 08             	mov    0x8(%ebp),%edx
80100c73:	8b 52 0c             	mov    0xc(%edx),%edx
80100c76:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100c79:	8b 45 08             	mov    0x8(%ebp),%eax
80100c7c:	8b 40 0c             	mov    0xc(%eax),%eax
80100c7f:	8b 55 08             	mov    0x8(%ebp),%edx
80100c82:	8b 52 10             	mov    0x10(%edx),%edx
80100c85:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
80100c88:	8b 15 14 ea 12 80    	mov    0x8012ea14,%edx
80100c8e:	8b 45 08             	mov    0x8(%ebp),%eax
80100c91:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100c94:	8b 45 08             	mov    0x8(%ebp),%eax
80100c97:	c7 40 0c 04 ea 12 80 	movl   $0x8012ea04,0xc(%eax)
  bcache.head.next->prev = b;
80100c9e:	a1 14 ea 12 80       	mov    0x8012ea14,%eax
80100ca3:	8b 55 08             	mov    0x8(%ebp),%edx
80100ca6:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100ca9:	8b 45 08             	mov    0x8(%ebp),%eax
80100cac:	a3 14 ea 12 80       	mov    %eax,0x8012ea14

  b->flags &= ~B_BUSY;
80100cb1:	8b 45 08             	mov    0x8(%ebp),%eax
80100cb4:	8b 00                	mov    (%eax),%eax
80100cb6:	83 e0 fe             	and    $0xfffffffe,%eax
80100cb9:	89 c2                	mov    %eax,%edx
80100cbb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cbe:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80100cc0:	83 ec 0c             	sub    $0xc,%esp
80100cc3:	ff 75 08             	pushl  0x8(%ebp)
80100cc6:	e8 de 56 00 00       	call   801063a9 <wakeup>
80100ccb:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
80100cce:	83 ec 0c             	sub    $0xc,%esp
80100cd1:	68 00 ab 12 80       	push   $0x8012ab00
80100cd6:	e8 4e 59 00 00       	call   80106629 <release>
80100cdb:	83 c4 10             	add    $0x10,%esp
}
80100cde:	90                   	nop
80100cdf:	c9                   	leave  
80100ce0:	c3                   	ret    

80100ce1 <inb>:
	__asm __volatile("invlpg (%0)" : : "r" (addr) : "memory");
}

static inline uchar
inb(ushort port)
{
80100ce1:	55                   	push   %ebp
80100ce2:	89 e5                	mov    %esp,%ebp
80100ce4:	83 ec 14             	sub    $0x14,%esp
80100ce7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cea:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100cee:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80100cf2:	89 c2                	mov    %eax,%edx
80100cf4:	ec                   	in     (%dx),%al
80100cf5:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80100cf8:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80100cfc:	c9                   	leave  
80100cfd:	c3                   	ret    

80100cfe <outb>:
  return data;
}

static inline void
outb(ushort port, uchar data)
{
80100cfe:	55                   	push   %ebp
80100cff:	89 e5                	mov    %esp,%ebp
80100d01:	83 ec 08             	sub    $0x8,%esp
80100d04:	8b 55 08             	mov    0x8(%ebp),%edx
80100d07:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d0a:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80100d0e:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d11:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100d15:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80100d19:	ee                   	out    %al,(%dx)
}
80100d1a:	90                   	nop
80100d1b:	c9                   	leave  
80100d1c:	c3                   	ret    

80100d1d <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100d1d:	55                   	push   %ebp
80100d1e:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100d20:	fa                   	cli    
}
80100d21:	90                   	nop
80100d22:	5d                   	pop    %ebp
80100d23:	c3                   	ret    

80100d24 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100d24:	55                   	push   %ebp
80100d25:	89 e5                	mov    %esp,%ebp
80100d27:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100d2a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100d2e:	74 1c                	je     80100d4c <printint+0x28>
80100d30:	8b 45 08             	mov    0x8(%ebp),%eax
80100d33:	c1 e8 1f             	shr    $0x1f,%eax
80100d36:	0f b6 c0             	movzbl %al,%eax
80100d39:	89 45 10             	mov    %eax,0x10(%ebp)
80100d3c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100d40:	74 0a                	je     80100d4c <printint+0x28>
    x = -xx;
80100d42:	8b 45 08             	mov    0x8(%ebp),%eax
80100d45:	f7 d8                	neg    %eax
80100d47:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100d4a:	eb 06                	jmp    80100d52 <printint+0x2e>
  else
    x = xx;
80100d4c:	8b 45 08             	mov    0x8(%ebp),%eax
80100d4f:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100d52:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100d59:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100d5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100d5f:	ba 00 00 00 00       	mov    $0x0,%edx
80100d64:	f7 f1                	div    %ecx
80100d66:	89 d1                	mov    %edx,%ecx
80100d68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100d6b:	8d 50 01             	lea    0x1(%eax),%edx
80100d6e:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100d71:	0f b6 91 04 70 12 80 	movzbl -0x7fed8ffc(%ecx),%edx
80100d78:	88 54 05 e0          	mov    %dl,-0x20(%ebp,%eax,1)
  }while((x /= base) != 0);
80100d7c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100d7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100d82:	ba 00 00 00 00       	mov    $0x0,%edx
80100d87:	f7 f1                	div    %ecx
80100d89:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100d8c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100d90:	75 c7                	jne    80100d59 <printint+0x35>

  if(sign)
80100d92:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100d96:	74 2a                	je     80100dc2 <printint+0x9e>
    buf[i++] = '-';
80100d98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100d9b:	8d 50 01             	lea    0x1(%eax),%edx
80100d9e:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100da1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
80100da6:	eb 1a                	jmp    80100dc2 <printint+0x9e>
    consputc(buf[i]);
80100da8:	8d 55 e0             	lea    -0x20(%ebp),%edx
80100dab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100dae:	01 d0                	add    %edx,%eax
80100db0:	0f b6 00             	movzbl (%eax),%eax
80100db3:	0f be c0             	movsbl %al,%eax
80100db6:	83 ec 0c             	sub    $0xc,%esp
80100db9:	50                   	push   %eax
80100dba:	e8 b3 02 00 00       	call   80101072 <consputc>
80100dbf:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
80100dc2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100dc6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100dca:	79 dc                	jns    80100da8 <printint+0x84>
}
80100dcc:	90                   	nop
80100dcd:	c9                   	leave  
80100dce:	c3                   	ret    

80100dcf <putch>:
//PAGEBREAK: 50

static void
putch(int ch, int *cnt)
{
80100dcf:	55                   	push   %ebp
80100dd0:	89 e5                	mov    %esp,%ebp
80100dd2:	83 ec 08             	sub    $0x8,%esp
  cputchar(ch);
80100dd5:	83 ec 0c             	sub    $0xc,%esp
80100dd8:	ff 75 08             	pushl  0x8(%ebp)
80100ddb:	e8 73 07 00 00       	call   80101553 <cputchar>
80100de0:	83 c4 10             	add    $0x10,%esp
  *cnt++;
80100de3:	8b 45 0c             	mov    0xc(%ebp),%eax
80100de6:	83 c0 04             	add    $0x4,%eax
80100de9:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80100dec:	90                   	nop
80100ded:	c9                   	leave  
80100dee:	c3                   	ret    

80100def <vcprintf>:

int
vcprintf(const char *fmt, va_list ap)
{
80100def:	55                   	push   %ebp
80100df0:	89 e5                	mov    %esp,%ebp
80100df2:	83 ec 18             	sub    $0x18,%esp
  int cnt = 0;
80100df5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  vprintfmt((void*)putch, &cnt, fmt, ap);
80100dfc:	ff 75 0c             	pushl  0xc(%ebp)
80100dff:	ff 75 08             	pushl  0x8(%ebp)
80100e02:	8d 45 f4             	lea    -0xc(%ebp),%eax
80100e05:	50                   	push   %eax
80100e06:	68 cf 0d 10 80       	push   $0x80100dcf
80100e0b:	e8 d3 96 00 00       	call   8010a4e3 <vprintfmt>
80100e10:	83 c4 10             	add    $0x10,%esp
  return cnt;
80100e13:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80100e16:	c9                   	leave  
80100e17:	c3                   	ret    

80100e18 <cprintf>:

int
cprintf(const char *fmt, ...)
{
80100e18:	55                   	push   %ebp
80100e19:	89 e5                	mov    %esp,%ebp
80100e1b:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int cnt;

  va_start(ap, fmt);
80100e1e:	8d 45 0c             	lea    0xc(%ebp),%eax
80100e21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cnt = vcprintf(fmt, ap);
80100e24:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100e27:	83 ec 08             	sub    $0x8,%esp
80100e2a:	50                   	push   %eax
80100e2b:	ff 75 08             	pushl  0x8(%ebp)
80100e2e:	e8 bc ff ff ff       	call   80100def <vcprintf>
80100e33:	83 c4 10             	add    $0x10,%esp
80100e36:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return cnt;
80100e39:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80100e3c:	c9                   	leave  
80100e3d:	c3                   	ret    

80100e3e <panic>:
    release(&cons.lock);
}
*/
void
panic(char *s)
{
80100e3e:	55                   	push   %ebp
80100e3f:	89 e5                	mov    %esp,%ebp
80100e41:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];

  cli();
80100e44:	e8 d4 fe ff ff       	call   80100d1d <cli>
  cons.locking = 0;
80100e49:	c7 05 74 96 12 80 00 	movl   $0x0,0x80129674
80100e50:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100e53:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100e59:	0f b6 00             	movzbl (%eax),%eax
80100e5c:	0f b6 c0             	movzbl %al,%eax
80100e5f:	83 ec 08             	sub    $0x8,%esp
80100e62:	50                   	push   %eax
80100e63:	68 5a b2 10 80       	push   $0x8010b25a
80100e68:	e8 ab ff ff ff       	call   80100e18 <cprintf>
80100e6d:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
80100e70:	8b 45 08             	mov    0x8(%ebp),%eax
80100e73:	83 ec 0c             	sub    $0xc,%esp
80100e76:	50                   	push   %eax
80100e77:	e8 9c ff ff ff       	call   80100e18 <cprintf>
80100e7c:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
80100e7f:	83 ec 0c             	sub    $0xc,%esp
80100e82:	68 76 b2 10 80       	push   $0x8010b276
80100e87:	e8 8c ff ff ff       	call   80100e18 <cprintf>
80100e8c:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
80100e8f:	83 ec 08             	sub    $0x8,%esp
80100e92:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100e95:	50                   	push   %eax
80100e96:	8d 45 08             	lea    0x8(%ebp),%eax
80100e99:	50                   	push   %eax
80100e9a:	e8 d9 57 00 00       	call   80106678 <getcallerpcs>
80100e9f:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100ea2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100ea9:	eb 1c                	jmp    80100ec7 <panic+0x89>
    cprintf(" %p", pcs[i]);
80100eab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eae:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
80100eb2:	83 ec 08             	sub    $0x8,%esp
80100eb5:	50                   	push   %eax
80100eb6:	68 78 b2 10 80       	push   $0x8010b278
80100ebb:	e8 58 ff ff ff       	call   80100e18 <cprintf>
80100ec0:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100ec3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100ec7:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80100ecb:	7e de                	jle    80100eab <panic+0x6d>
  panicked = 1; // freeze other CPU
80100ecd:	c7 05 20 96 12 80 01 	movl   $0x1,0x80129620
80100ed4:	00 00 00 
  for(;;)
80100ed7:	eb fe                	jmp    80100ed7 <panic+0x99>

80100ed9 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100ed9:	55                   	push   %ebp
80100eda:	89 e5                	mov    %esp,%ebp
80100edc:	53                   	push   %ebx
80100edd:	83 ec 14             	sub    $0x14,%esp
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100ee0:	6a 0e                	push   $0xe
80100ee2:	68 d4 03 00 00       	push   $0x3d4
80100ee7:	e8 12 fe ff ff       	call   80100cfe <outb>
80100eec:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100eef:	68 d5 03 00 00       	push   $0x3d5
80100ef4:	e8 e8 fd ff ff       	call   80100ce1 <inb>
80100ef9:	83 c4 04             	add    $0x4,%esp
80100efc:	0f b6 c0             	movzbl %al,%eax
80100eff:	c1 e0 08             	shl    $0x8,%eax
80100f02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100f05:	6a 0f                	push   $0xf
80100f07:	68 d4 03 00 00       	push   $0x3d4
80100f0c:	e8 ed fd ff ff       	call   80100cfe <outb>
80100f11:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100f14:	68 d5 03 00 00       	push   $0x3d5
80100f19:	e8 c3 fd ff ff       	call   80100ce1 <inb>
80100f1e:	83 c4 04             	add    $0x4,%esp
80100f21:	0f b6 c0             	movzbl %al,%eax
80100f24:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100f27:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100f2b:	75 30                	jne    80100f5d <cgaputc+0x84>
    pos += 80 - pos%80;
80100f2d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100f30:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100f35:	89 c8                	mov    %ecx,%eax
80100f37:	f7 ea                	imul   %edx
80100f39:	c1 fa 05             	sar    $0x5,%edx
80100f3c:	89 c8                	mov    %ecx,%eax
80100f3e:	c1 f8 1f             	sar    $0x1f,%eax
80100f41:	29 c2                	sub    %eax,%edx
80100f43:	89 d0                	mov    %edx,%eax
80100f45:	c1 e0 02             	shl    $0x2,%eax
80100f48:	01 d0                	add    %edx,%eax
80100f4a:	c1 e0 04             	shl    $0x4,%eax
80100f4d:	29 c1                	sub    %eax,%ecx
80100f4f:	89 ca                	mov    %ecx,%edx
80100f51:	b8 50 00 00 00       	mov    $0x50,%eax
80100f56:	29 d0                	sub    %edx,%eax
80100f58:	01 45 f4             	add    %eax,-0xc(%ebp)
80100f5b:	eb 38                	jmp    80100f95 <cgaputc+0xbc>
  else if(c == BACKSPACE){
80100f5d:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100f64:	75 0c                	jne    80100f72 <cgaputc+0x99>
    if(pos > 0) --pos;
80100f66:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100f6a:	7e 29                	jle    80100f95 <cgaputc+0xbc>
80100f6c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100f70:	eb 23                	jmp    80100f95 <cgaputc+0xbc>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100f72:	8b 45 08             	mov    0x8(%ebp),%eax
80100f75:	0f b6 c0             	movzbl %al,%eax
80100f78:	80 cc 07             	or     $0x7,%ah
80100f7b:	89 c3                	mov    %eax,%ebx
80100f7d:	8b 0d 00 70 12 80    	mov    0x80127000,%ecx
80100f83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f86:	8d 50 01             	lea    0x1(%eax),%edx
80100f89:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100f8c:	01 c0                	add    %eax,%eax
80100f8e:	01 c8                	add    %ecx,%eax
80100f90:	89 da                	mov    %ebx,%edx
80100f92:	66 89 10             	mov    %dx,(%eax)

  if(pos < 0 || pos > 25*80)
80100f95:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100f99:	78 09                	js     80100fa4 <cgaputc+0xcb>
80100f9b:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
80100fa2:	7e 0d                	jle    80100fb1 <cgaputc+0xd8>
    panic("pos under/overflow");
80100fa4:	83 ec 0c             	sub    $0xc,%esp
80100fa7:	68 7c b2 10 80       	push   $0x8010b27c
80100fac:	e8 8d fe ff ff       	call   80100e3e <panic>

  if((pos/80) >= 24){  // Scroll up.
80100fb1:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
80100fb8:	7e 4c                	jle    80101006 <cgaputc+0x12d>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100fba:	a1 00 70 12 80       	mov    0x80127000,%eax
80100fbf:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
80100fc5:	a1 00 70 12 80       	mov    0x80127000,%eax
80100fca:	83 ec 04             	sub    $0x4,%esp
80100fcd:	68 60 0e 00 00       	push   $0xe60
80100fd2:	52                   	push   %edx
80100fd3:	50                   	push   %eax
80100fd4:	e8 19 59 00 00       	call   801068f2 <memmove>
80100fd9:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
80100fdc:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100fe0:	b8 80 07 00 00       	mov    $0x780,%eax
80100fe5:	2b 45 f4             	sub    -0xc(%ebp),%eax
80100fe8:	8d 14 00             	lea    (%eax,%eax,1),%edx
80100feb:	a1 00 70 12 80       	mov    0x80127000,%eax
80100ff0:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100ff3:	01 c9                	add    %ecx,%ecx
80100ff5:	01 c8                	add    %ecx,%eax
80100ff7:	83 ec 04             	sub    $0x4,%esp
80100ffa:	52                   	push   %edx
80100ffb:	6a 00                	push   $0x0
80100ffd:	50                   	push   %eax
80100ffe:	e8 30 58 00 00       	call   80106833 <memset>
80101003:	83 c4 10             	add    $0x10,%esp
  }

  outb(CRTPORT, 14);
80101006:	83 ec 08             	sub    $0x8,%esp
80101009:	6a 0e                	push   $0xe
8010100b:	68 d4 03 00 00       	push   $0x3d4
80101010:	e8 e9 fc ff ff       	call   80100cfe <outb>
80101015:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
80101018:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010101b:	c1 f8 08             	sar    $0x8,%eax
8010101e:	0f b6 c0             	movzbl %al,%eax
80101021:	83 ec 08             	sub    $0x8,%esp
80101024:	50                   	push   %eax
80101025:	68 d5 03 00 00       	push   $0x3d5
8010102a:	e8 cf fc ff ff       	call   80100cfe <outb>
8010102f:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80101032:	83 ec 08             	sub    $0x8,%esp
80101035:	6a 0f                	push   $0xf
80101037:	68 d4 03 00 00       	push   $0x3d4
8010103c:	e8 bd fc ff ff       	call   80100cfe <outb>
80101041:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
80101044:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101047:	0f b6 c0             	movzbl %al,%eax
8010104a:	83 ec 08             	sub    $0x8,%esp
8010104d:	50                   	push   %eax
8010104e:	68 d5 03 00 00       	push   $0x3d5
80101053:	e8 a6 fc ff ff       	call   80100cfe <outb>
80101058:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
8010105b:	a1 00 70 12 80       	mov    0x80127000,%eax
80101060:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101063:	01 d2                	add    %edx,%edx
80101065:	01 d0                	add    %edx,%eax
80101067:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
8010106c:	90                   	nop
8010106d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101070:	c9                   	leave  
80101071:	c3                   	ret    

80101072 <consputc>:

void
consputc(int c)
{
80101072:	55                   	push   %ebp
80101073:	89 e5                	mov    %esp,%ebp
80101075:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
80101078:	a1 20 96 12 80       	mov    0x80129620,%eax
8010107d:	85 c0                	test   %eax,%eax
8010107f:	74 07                	je     80101088 <consputc+0x16>
    cli();
80101081:	e8 97 fc ff ff       	call   80100d1d <cli>
    for(;;)
80101086:	eb fe                	jmp    80101086 <consputc+0x14>
      ;
  }

  if(c == BACKSPACE){
80101088:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010108f:	75 29                	jne    801010ba <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80101091:	83 ec 0c             	sub    $0xc,%esp
80101094:	6a 08                	push   $0x8
80101096:	e8 21 74 00 00       	call   801084bc <uartputc>
8010109b:	83 c4 10             	add    $0x10,%esp
8010109e:	83 ec 0c             	sub    $0xc,%esp
801010a1:	6a 20                	push   $0x20
801010a3:	e8 14 74 00 00       	call   801084bc <uartputc>
801010a8:	83 c4 10             	add    $0x10,%esp
801010ab:	83 ec 0c             	sub    $0xc,%esp
801010ae:	6a 08                	push   $0x8
801010b0:	e8 07 74 00 00       	call   801084bc <uartputc>
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	eb 0e                	jmp    801010c8 <consputc+0x56>
  } else
    uartputc(c);
801010ba:	83 ec 0c             	sub    $0xc,%esp
801010bd:	ff 75 08             	pushl  0x8(%ebp)
801010c0:	e8 f7 73 00 00       	call   801084bc <uartputc>
801010c5:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801010c8:	83 ec 0c             	sub    $0xc,%esp
801010cb:	ff 75 08             	pushl  0x8(%ebp)
801010ce:	e8 06 fe ff ff       	call   80100ed9 <cgaputc>
801010d3:	83 c4 10             	add    $0x10,%esp
}
801010d6:	90                   	nop
801010d7:	c9                   	leave  
801010d8:	c3                   	ret    

801010d9 <cons_getc>:


// return the next input character from the console, or 0 if none waiting
int
cons_getc(void)
{
801010d9:	55                   	push   %ebp
801010da:	89 e5                	mov    %esp,%ebp
801010dc:	83 ec 18             	sub    $0x18,%esp
  int c;

  // poll for any pending input characters,
  // so that this function works even when interrupts are disabled
  // (e.g., when called from the kernel monitor).
  consoleintr(uartgetc);
801010df:	83 ec 0c             	sub    $0xc,%esp
801010e2:	68 21 85 10 80       	push   $0x80108521
801010e7:	e8 8f 00 00 00       	call   8010117b <consoleintr>
801010ec:	83 c4 10             	add    $0x10,%esp
  consoleintr(kbdgetc);
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	68 f0 3a 10 80       	push   $0x80103af0
801010f7:	e8 7f 00 00 00       	call   8010117b <consoleintr>
801010fc:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 40 96 12 80       	push   $0x80129640
80101107:	e8 b1 54 00 00       	call   801065bd <acquire>
8010110c:	83 c4 10             	add    $0x10,%esp

  // grab the next character from the input buffer.
  if (input.r != input.w) {
8010110f:	8b 15 a0 ec 12 80    	mov    0x8012eca0,%edx
80101115:	a1 a4 ec 12 80       	mov    0x8012eca4,%eax
8010111a:	39 c2                	cmp    %eax,%edx
8010111c:	74 46                	je     80101164 <cons_getc+0x8b>
    c = input.buf[input.r++];
8010111e:	a1 a0 ec 12 80       	mov    0x8012eca0,%eax
80101123:	8d 50 01             	lea    0x1(%eax),%edx
80101126:	89 15 a0 ec 12 80    	mov    %edx,0x8012eca0
8010112c:	0f b6 80 20 ec 12 80 	movzbl -0x7fed13e0(%eax),%eax
80101133:	0f be c0             	movsbl %al,%eax
80101136:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (input.r == INPUT_BUF)
80101139:	a1 a0 ec 12 80       	mov    0x8012eca0,%eax
8010113e:	3d 80 00 00 00       	cmp    $0x80,%eax
80101143:	75 0a                	jne    8010114f <cons_getc+0x76>
      input.r = 0;
80101145:	c7 05 a0 ec 12 80 00 	movl   $0x0,0x8012eca0
8010114c:	00 00 00 
    release(&cons.lock);
8010114f:	83 ec 0c             	sub    $0xc,%esp
80101152:	68 40 96 12 80       	push   $0x80129640
80101157:	e8 cd 54 00 00       	call   80106629 <release>
8010115c:	83 c4 10             	add    $0x10,%esp
    return c;
8010115f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101162:	eb 15                	jmp    80101179 <cons_getc+0xa0>
  }
  release(&cons.lock);
80101164:	83 ec 0c             	sub    $0xc,%esp
80101167:	68 40 96 12 80       	push   $0x80129640
8010116c:	e8 b8 54 00 00       	call   80106629 <release>
80101171:	83 c4 10             	add    $0x10,%esp
  return 0;
80101174:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101179:	c9                   	leave  
8010117a:	c3                   	ret    

8010117b <consoleintr>:


    
void
consoleintr(int (*getc)(void))
{
8010117b:	55                   	push   %ebp
8010117c:	89 e5                	mov    %esp,%ebp
8010117e:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump = 0;
80101181:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
80101188:	83 ec 0c             	sub    $0xc,%esp
8010118b:	68 40 96 12 80       	push   $0x80129640
80101190:	e8 28 54 00 00       	call   801065bd <acquire>
80101195:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
80101198:	e9 44 01 00 00       	jmp    801012e1 <consoleintr+0x166>
    switch(c){
8010119d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801011a0:	83 f8 10             	cmp    $0x10,%eax
801011a3:	74 1e                	je     801011c3 <consoleintr+0x48>
801011a5:	83 f8 10             	cmp    $0x10,%eax
801011a8:	7f 0a                	jg     801011b4 <consoleintr+0x39>
801011aa:	83 f8 08             	cmp    $0x8,%eax
801011ad:	74 6b                	je     8010121a <consoleintr+0x9f>
801011af:	e9 9b 00 00 00       	jmp    8010124f <consoleintr+0xd4>
801011b4:	83 f8 15             	cmp    $0x15,%eax
801011b7:	74 33                	je     801011ec <consoleintr+0x71>
801011b9:	83 f8 7f             	cmp    $0x7f,%eax
801011bc:	74 5c                	je     8010121a <consoleintr+0x9f>
801011be:	e9 8c 00 00 00       	jmp    8010124f <consoleintr+0xd4>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
801011c3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
801011ca:	e9 12 01 00 00       	jmp    801012e1 <consoleintr+0x166>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801011cf:	a1 a8 ec 12 80       	mov    0x8012eca8,%eax
801011d4:	83 e8 01             	sub    $0x1,%eax
801011d7:	a3 a8 ec 12 80       	mov    %eax,0x8012eca8
        consputc(BACKSPACE);
801011dc:	83 ec 0c             	sub    $0xc,%esp
801011df:	68 00 01 00 00       	push   $0x100
801011e4:	e8 89 fe ff ff       	call   80101072 <consputc>
801011e9:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
801011ec:	8b 15 a8 ec 12 80    	mov    0x8012eca8,%edx
801011f2:	a1 a4 ec 12 80       	mov    0x8012eca4,%eax
801011f7:	39 c2                	cmp    %eax,%edx
801011f9:	0f 84 e2 00 00 00    	je     801012e1 <consoleintr+0x166>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801011ff:	a1 a8 ec 12 80       	mov    0x8012eca8,%eax
80101204:	83 e8 01             	sub    $0x1,%eax
80101207:	83 e0 7f             	and    $0x7f,%eax
8010120a:	0f b6 80 20 ec 12 80 	movzbl -0x7fed13e0(%eax),%eax
      while(input.e != input.w &&
80101211:	3c 0a                	cmp    $0xa,%al
80101213:	75 ba                	jne    801011cf <consoleintr+0x54>
      }
      break;
80101215:	e9 c7 00 00 00       	jmp    801012e1 <consoleintr+0x166>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010121a:	8b 15 a8 ec 12 80    	mov    0x8012eca8,%edx
80101220:	a1 a4 ec 12 80       	mov    0x8012eca4,%eax
80101225:	39 c2                	cmp    %eax,%edx
80101227:	0f 84 b4 00 00 00    	je     801012e1 <consoleintr+0x166>
        input.e--;
8010122d:	a1 a8 ec 12 80       	mov    0x8012eca8,%eax
80101232:	83 e8 01             	sub    $0x1,%eax
80101235:	a3 a8 ec 12 80       	mov    %eax,0x8012eca8
        consputc(BACKSPACE);
8010123a:	83 ec 0c             	sub    $0xc,%esp
8010123d:	68 00 01 00 00       	push   $0x100
80101242:	e8 2b fe ff ff       	call   80101072 <consputc>
80101247:	83 c4 10             	add    $0x10,%esp
      }
      break;
8010124a:	e9 92 00 00 00       	jmp    801012e1 <consoleintr+0x166>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010124f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101253:	0f 84 87 00 00 00    	je     801012e0 <consoleintr+0x165>
80101259:	8b 15 a8 ec 12 80    	mov    0x8012eca8,%edx
8010125f:	a1 a0 ec 12 80       	mov    0x8012eca0,%eax
80101264:	29 c2                	sub    %eax,%edx
80101266:	89 d0                	mov    %edx,%eax
80101268:	83 f8 7f             	cmp    $0x7f,%eax
8010126b:	77 73                	ja     801012e0 <consoleintr+0x165>
        c = (c == '\r') ? '\n' : c;
8010126d:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80101271:	74 05                	je     80101278 <consoleintr+0xfd>
80101273:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101276:	eb 05                	jmp    8010127d <consoleintr+0x102>
80101278:	b8 0a 00 00 00       	mov    $0xa,%eax
8010127d:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
80101280:	a1 a8 ec 12 80       	mov    0x8012eca8,%eax
80101285:	8d 50 01             	lea    0x1(%eax),%edx
80101288:	89 15 a8 ec 12 80    	mov    %edx,0x8012eca8
8010128e:	83 e0 7f             	and    $0x7f,%eax
80101291:	8b 55 f0             	mov    -0x10(%ebp),%edx
80101294:	88 90 20 ec 12 80    	mov    %dl,-0x7fed13e0(%eax)
        consputc(c);
8010129a:	83 ec 0c             	sub    $0xc,%esp
8010129d:	ff 75 f0             	pushl  -0x10(%ebp)
801012a0:	e8 cd fd ff ff       	call   80101072 <consputc>
801012a5:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801012a8:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801012ac:	74 18                	je     801012c6 <consoleintr+0x14b>
801012ae:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801012b2:	74 12                	je     801012c6 <consoleintr+0x14b>
801012b4:	a1 a8 ec 12 80       	mov    0x8012eca8,%eax
801012b9:	8b 15 a0 ec 12 80    	mov    0x8012eca0,%edx
801012bf:	83 ea 80             	sub    $0xffffff80,%edx
801012c2:	39 d0                	cmp    %edx,%eax
801012c4:	75 1a                	jne    801012e0 <consoleintr+0x165>
          input.w = input.e;
801012c6:	a1 a8 ec 12 80       	mov    0x8012eca8,%eax
801012cb:	a3 a4 ec 12 80       	mov    %eax,0x8012eca4
          wakeup(&input.r);
801012d0:	83 ec 0c             	sub    $0xc,%esp
801012d3:	68 a0 ec 12 80       	push   $0x8012eca0
801012d8:	e8 cc 50 00 00       	call   801063a9 <wakeup>
801012dd:	83 c4 10             	add    $0x10,%esp
          // Wake up anything waiting on console read
          // LAB 4: Your code here
        }
      }
      break;
801012e0:	90                   	nop
  while((c = getc()) >= 0){
801012e1:	8b 45 08             	mov    0x8(%ebp),%eax
801012e4:	ff d0                	call   *%eax
801012e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801012e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801012ed:	0f 89 aa fe ff ff    	jns    8010119d <consoleintr+0x22>
    }
  }
  release(&cons.lock);
801012f3:	83 ec 0c             	sub    $0xc,%esp
801012f6:	68 40 96 12 80       	push   $0x80129640
801012fb:	e8 29 53 00 00       	call   80106629 <release>
80101300:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
80101303:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101307:	74 05                	je     8010130e <consoleintr+0x193>
    procdump();  // now call procdump() wo. cons.lock held
80101309:	e8 59 51 00 00       	call   80106467 <procdump>
  }
}
8010130e:	90                   	nop
8010130f:	c9                   	leave  
80101310:	c3                   	ret    

80101311 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80101311:	55                   	push   %ebp
80101312:	89 e5                	mov    %esp,%ebp
80101314:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80101317:	83 ec 0c             	sub    $0xc,%esp
8010131a:	ff 75 08             	pushl  0x8(%ebp)
8010131d:	e8 5d 13 00 00       	call   8010267f <iunlock>
80101322:	83 c4 10             	add    $0x10,%esp
  target = n;
80101325:	8b 45 10             	mov    0x10(%ebp),%eax
80101328:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
8010132b:	83 ec 0c             	sub    $0xc,%esp
8010132e:	68 40 96 12 80       	push   $0x80129640
80101333:	e8 85 52 00 00       	call   801065bd <acquire>
80101338:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
8010133b:	e9 ac 00 00 00       	jmp    801013ec <consoleread+0xdb>
    while(input.r == input.w){
      if(proc->killed){
80101340:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101346:	8b 40 24             	mov    0x24(%eax),%eax
80101349:	85 c0                	test   %eax,%eax
8010134b:	74 28                	je     80101375 <consoleread+0x64>
        release(&cons.lock);
8010134d:	83 ec 0c             	sub    $0xc,%esp
80101350:	68 40 96 12 80       	push   $0x80129640
80101355:	e8 cf 52 00 00       	call   80106629 <release>
8010135a:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
8010135d:	83 ec 0c             	sub    $0xc,%esp
80101360:	ff 75 08             	pushl  0x8(%ebp)
80101363:	e8 b9 11 00 00       	call   80102521 <ilock>
80101368:	83 c4 10             	add    $0x10,%esp
        return -1;
8010136b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101370:	e9 ab 00 00 00       	jmp    80101420 <consoleread+0x10f>
      }
      sleep(&input.r, &cons.lock);
80101375:	83 ec 08             	sub    $0x8,%esp
80101378:	68 40 96 12 80       	push   $0x80129640
8010137d:	68 a0 ec 12 80       	push   $0x8012eca0
80101382:	e8 34 4f 00 00       	call   801062bb <sleep>
80101387:	83 c4 10             	add    $0x10,%esp
    while(input.r == input.w){
8010138a:	8b 15 a0 ec 12 80    	mov    0x8012eca0,%edx
80101390:	a1 a4 ec 12 80       	mov    0x8012eca4,%eax
80101395:	39 c2                	cmp    %eax,%edx
80101397:	74 a7                	je     80101340 <consoleread+0x2f>
    }
    c = input.buf[input.r++ % INPUT_BUF];
80101399:	a1 a0 ec 12 80       	mov    0x8012eca0,%eax
8010139e:	8d 50 01             	lea    0x1(%eax),%edx
801013a1:	89 15 a0 ec 12 80    	mov    %edx,0x8012eca0
801013a7:	83 e0 7f             	and    $0x7f,%eax
801013aa:	0f b6 80 20 ec 12 80 	movzbl -0x7fed13e0(%eax),%eax
801013b1:	0f be c0             	movsbl %al,%eax
801013b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
801013b7:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801013bb:	75 17                	jne    801013d4 <consoleread+0xc3>
      if(n < target){
801013bd:	8b 45 10             	mov    0x10(%ebp),%eax
801013c0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801013c3:	76 2f                	jbe    801013f4 <consoleread+0xe3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
801013c5:	a1 a0 ec 12 80       	mov    0x8012eca0,%eax
801013ca:	83 e8 01             	sub    $0x1,%eax
801013cd:	a3 a0 ec 12 80       	mov    %eax,0x8012eca0
      }
      break;
801013d2:	eb 20                	jmp    801013f4 <consoleread+0xe3>
    }
    *dst++ = c;
801013d4:	8b 45 0c             	mov    0xc(%ebp),%eax
801013d7:	8d 50 01             	lea    0x1(%eax),%edx
801013da:	89 55 0c             	mov    %edx,0xc(%ebp)
801013dd:	8b 55 f0             	mov    -0x10(%ebp),%edx
801013e0:	88 10                	mov    %dl,(%eax)
    --n;
801013e2:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
801013e6:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801013ea:	74 0b                	je     801013f7 <consoleread+0xe6>
  while(n > 0){
801013ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801013f0:	7f 98                	jg     8010138a <consoleread+0x79>
801013f2:	eb 04                	jmp    801013f8 <consoleread+0xe7>
      break;
801013f4:	90                   	nop
801013f5:	eb 01                	jmp    801013f8 <consoleread+0xe7>
      break;
801013f7:	90                   	nop
  }
  release(&cons.lock);
801013f8:	83 ec 0c             	sub    $0xc,%esp
801013fb:	68 40 96 12 80       	push   $0x80129640
80101400:	e8 24 52 00 00       	call   80106629 <release>
80101405:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80101408:	83 ec 0c             	sub    $0xc,%esp
8010140b:	ff 75 08             	pushl  0x8(%ebp)
8010140e:	e8 0e 11 00 00       	call   80102521 <ilock>
80101413:	83 c4 10             	add    $0x10,%esp

  return target - n;
80101416:	8b 45 10             	mov    0x10(%ebp),%eax
80101419:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010141c:	29 c2                	sub    %eax,%edx
8010141e:	89 d0                	mov    %edx,%eax
}
80101420:	c9                   	leave  
80101421:	c3                   	ret    

80101422 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80101422:	55                   	push   %ebp
80101423:	89 e5                	mov    %esp,%ebp
80101425:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80101428:	83 ec 0c             	sub    $0xc,%esp
8010142b:	ff 75 08             	pushl  0x8(%ebp)
8010142e:	e8 4c 12 00 00       	call   8010267f <iunlock>
80101433:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80101436:	83 ec 0c             	sub    $0xc,%esp
80101439:	68 40 96 12 80       	push   $0x80129640
8010143e:	e8 7a 51 00 00       	call   801065bd <acquire>
80101443:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80101446:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010144d:	eb 21                	jmp    80101470 <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
8010144f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101452:	8b 45 0c             	mov    0xc(%ebp),%eax
80101455:	01 d0                	add    %edx,%eax
80101457:	0f b6 00             	movzbl (%eax),%eax
8010145a:	0f be c0             	movsbl %al,%eax
8010145d:	0f b6 c0             	movzbl %al,%eax
80101460:	83 ec 0c             	sub    $0xc,%esp
80101463:	50                   	push   %eax
80101464:	e8 09 fc ff ff       	call   80101072 <consputc>
80101469:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
8010146c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101470:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101473:	3b 45 10             	cmp    0x10(%ebp),%eax
80101476:	7c d7                	jl     8010144f <consolewrite+0x2d>
  release(&cons.lock);
80101478:	83 ec 0c             	sub    $0xc,%esp
8010147b:	68 40 96 12 80       	push   $0x80129640
80101480:	e8 a4 51 00 00       	call   80106629 <release>
80101485:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80101488:	83 ec 0c             	sub    $0xc,%esp
8010148b:	ff 75 08             	pushl  0x8(%ebp)
8010148e:	e8 8e 10 00 00       	call   80102521 <ilock>
80101493:	83 c4 10             	add    $0x10,%esp

  return n;
80101496:	8b 45 10             	mov    0x10(%ebp),%eax
}
80101499:	c9                   	leave  
8010149a:	c3                   	ret    

8010149b <consolewriteable>:
 * @param {struct inode *} ip - the inode to be checked
 * @return 0 for true, >0 for false, -1 for error.
 */
int
consolewriteable(struct inode* ip)
{
8010149b:	55                   	push   %ebp
8010149c:	89 e5                	mov    %esp,%ebp
    return 0;
8010149e:	b8 00 00 00 00       	mov    $0x0,%eax
}
801014a3:	5d                   	pop    %ebp
801014a4:	c3                   	ret    

801014a5 <consolereadable>:
 * @param {struct inode *} ip - the inode to be checked
 * @return 1 for true, 0 for false, -1 for error.
 */
int
consolereadable(struct inode* ip)
{
801014a5:	55                   	push   %ebp
801014a6:	89 e5                	mov    %esp,%ebp

  // LAB 4: Your code here

  return 0;
801014a8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801014ad:	5d                   	pop    %ebp
801014ae:	c3                   	ret    

801014af <consoleselect>:
// Console select
//
// Adds the selid to be woken up.
int
consoleselect(struct inode *ip, int *selid, struct spinlock * lk)
{
801014af:	55                   	push   %ebp
801014b0:	89 e5                	mov    %esp,%ebp
    // LAB 4: Your code here
    
    return 0;
801014b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801014b7:	5d                   	pop    %ebp
801014b8:	c3                   	ret    

801014b9 <consoleclrsel>:
// Console select clear
//
// Removes the selid from being woken up.
int
consoleclrsel(struct inode *ip, int *selid)
{
801014b9:	55                   	push   %ebp
801014ba:	89 e5                	mov    %esp,%ebp
    // LAB 4: Your code here
    
    return 0;
801014bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
801014c1:	5d                   	pop    %ebp
801014c2:	c3                   	ret    

801014c3 <consoleinit>:
void
consoleinit(void)
{
801014c3:	55                   	push   %ebp
801014c4:	89 e5                	mov    %esp,%ebp
801014c6:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
801014c9:	83 ec 08             	sub    $0x8,%esp
801014cc:	68 8f b2 10 80       	push   $0x8010b28f
801014d1:	68 40 96 12 80       	push   $0x80129640
801014d6:	e8 c0 50 00 00       	call   8010659b <initlock>
801014db:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
801014de:	c7 05 84 f7 12 80 22 	movl   $0x80101422,0x8012f784
801014e5:	14 10 80 
  devsw[CONSOLE].read = consoleread;
801014e8:	c7 05 80 f7 12 80 11 	movl   $0x80101311,0x8012f780
801014ef:	13 10 80 
  devsw[CONSOLE].writeable = consolewriteable;
801014f2:	c7 05 88 f7 12 80 9b 	movl   $0x8010149b,0x8012f788
801014f9:	14 10 80 
  devsw[CONSOLE].readable = consolereadable;
801014fc:	c7 05 8c f7 12 80 a5 	movl   $0x801014a5,0x8012f78c
80101503:	14 10 80 
  devsw[CONSOLE].select = consoleselect;
80101506:	c7 05 90 f7 12 80 af 	movl   $0x801014af,0x8012f790
8010150d:	14 10 80 
  devsw[CONSOLE].clrsel = consoleclrsel;
80101510:	c7 05 94 f7 12 80 b9 	movl   $0x801014b9,0x8012f794
80101517:	14 10 80 
  initselproc(&devsw[CONSOLE].selprocread);
8010151a:	83 ec 0c             	sub    $0xc,%esp
8010151d:	68 98 f7 12 80       	push   $0x8012f798
80101522:	e8 24 89 00 00       	call   80109e4b <initselproc>
80101527:	83 c4 10             	add    $0x10,%esp
  cons.locking = 1;
8010152a:	c7 05 74 96 12 80 01 	movl   $0x1,0x80129674
80101531:	00 00 00 

  picenable(IRQ_KBD);
80101534:	83 ec 0c             	sub    $0xc,%esp
80101537:	6a 01                	push   $0x1
80101539:	e8 05 3f 00 00       	call   80105443 <picenable>
8010153e:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80101541:	83 ec 08             	sub    $0x8,%esp
80101544:	6a 00                	push   $0x0
80101546:	6a 01                	push   $0x1
80101548:	e8 b0 23 00 00       	call   801038fd <ioapicenable>
8010154d:	83 c4 10             	add    $0x10,%esp
}
80101550:	90                   	nop
80101551:	c9                   	leave  
80101552:	c3                   	ret    

80101553 <cputchar>:

void
cputchar(int c)
{
80101553:	55                   	push   %ebp
80101554:	89 e5                	mov    %esp,%ebp
80101556:	83 ec 08             	sub    $0x8,%esp
  consputc(c);
80101559:	83 ec 0c             	sub    $0xc,%esp
8010155c:	ff 75 08             	pushl  0x8(%ebp)
8010155f:	e8 0e fb ff ff       	call   80101072 <consputc>
80101564:	83 c4 10             	add    $0x10,%esp
}
80101567:	90                   	nop
80101568:	c9                   	leave  
80101569:	c3                   	ret    

8010156a <getchar>:

int
getchar(void)
{
8010156a:	55                   	push   %ebp
8010156b:	89 e5                	mov    %esp,%ebp
8010156d:	83 ec 18             	sub    $0x18,%esp
  int c;

  while ((c = cons_getc()) == 0)
80101570:	e8 64 fb ff ff       	call   801010d9 <cons_getc>
80101575:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101578:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010157c:	74 f2                	je     80101570 <getchar+0x6>
    /* do nothing */;
  return c;
8010157e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101581:	c9                   	leave  
80101582:	c3                   	ret    

80101583 <iscons>:

int
iscons(int fdnum)
{
80101583:	55                   	push   %ebp
80101584:	89 e5                	mov    %esp,%ebp
  // used by readline
  return 1;
80101586:	b8 01 00 00 00       	mov    $0x1,%eax
}
8010158b:	5d                   	pop    %ebp
8010158c:	c3                   	ret    

8010158d <e1000_attach>:
// LAB 6: Your driver code here


int
e1000_attach(struct pci_func *pcif)
{
8010158d:	55                   	push   %ebp
8010158e:	89 e5                	mov    %esp,%ebp
	/* Fill this in */
	return -1;
80101590:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101595:	5d                   	pop    %ebp
80101596:	c3                   	ret    

80101597 <e1000_transmit>:

int
e1000_transmit(const char *buf, unsigned int len)
{
80101597:	55                   	push   %ebp
80101598:	89 e5                	mov    %esp,%ebp
	/* Fill this in */
	return -1;
8010159a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010159f:	5d                   	pop    %ebp
801015a0:	c3                   	ret    

801015a1 <e1000_receive>:

int
e1000_receive(char *buf, unsigned int len)
{
801015a1:	55                   	push   %ebp
801015a2:	89 e5                	mov    %esp,%ebp
	/* Fill this in */
	return -1;
801015a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801015a9:	5d                   	pop    %ebp
801015aa:	c3                   	ret    

801015ab <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801015ab:	55                   	push   %ebp
801015ac:	89 e5                	mov    %esp,%ebp
801015ae:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
801015b4:	e8 f3 2d 00 00       	call   801043ac <begin_op>
  if((ip = namei(path)) == 0){
801015b9:	83 ec 0c             	sub    $0xc,%esp
801015bc:	ff 75 08             	pushl  0x8(%ebp)
801015bf:	e8 46 1b 00 00       	call   8010310a <namei>
801015c4:	83 c4 10             	add    $0x10,%esp
801015c7:	89 45 d8             	mov    %eax,-0x28(%ebp)
801015ca:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
801015ce:	75 0f                	jne    801015df <exec+0x34>
    end_op();
801015d0:	e8 63 2e 00 00       	call   80104438 <end_op>
    return -1;
801015d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801015da:	e9 07 04 00 00       	jmp    801019e6 <exec+0x43b>
  }
  ilock(ip);
801015df:	83 ec 0c             	sub    $0xc,%esp
801015e2:	ff 75 d8             	pushl  -0x28(%ebp)
801015e5:	e8 37 0f 00 00       	call   80102521 <ilock>
801015ea:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
801015ed:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
801015f4:	6a 34                	push   $0x34
801015f6:	6a 00                	push   $0x0
801015f8:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
801015fe:	50                   	push   %eax
801015ff:	ff 75 d8             	pushl  -0x28(%ebp)
80101602:	e8 83 14 00 00       	call   80102a8a <readi>
80101607:	83 c4 10             	add    $0x10,%esp
8010160a:	83 f8 33             	cmp    $0x33,%eax
8010160d:	0f 86 7c 03 00 00    	jbe    8010198f <exec+0x3e4>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80101613:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80101619:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
8010161e:	0f 85 6e 03 00 00    	jne    80101992 <exec+0x3e7>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80101624:	e8 21 80 00 00       	call   8010964a <setupkvm>
80101629:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010162c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80101630:	0f 84 5f 03 00 00    	je     80101995 <exec+0x3ea>
    goto bad;

  // Load program into memory.
  sz = 0;
80101636:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010163d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80101644:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
8010164a:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010164d:	e9 de 00 00 00       	jmp    80101730 <exec+0x185>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101652:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101655:	6a 20                	push   $0x20
80101657:	50                   	push   %eax
80101658:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
8010165e:	50                   	push   %eax
8010165f:	ff 75 d8             	pushl  -0x28(%ebp)
80101662:	e8 23 14 00 00       	call   80102a8a <readi>
80101667:	83 c4 10             	add    $0x10,%esp
8010166a:	83 f8 20             	cmp    $0x20,%eax
8010166d:	0f 85 25 03 00 00    	jne    80101998 <exec+0x3ed>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80101673:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80101679:	83 f8 01             	cmp    $0x1,%eax
8010167c:	0f 85 a0 00 00 00    	jne    80101722 <exec+0x177>
      continue;
    if(ph.memsz < ph.filesz)
80101682:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80101688:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
8010168e:	39 c2                	cmp    %eax,%edx
80101690:	0f 82 05 03 00 00    	jb     8010199b <exec+0x3f0>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80101696:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
8010169c:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
801016a2:	01 c2                	add    %eax,%edx
801016a4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
801016aa:	39 c2                	cmp    %eax,%edx
801016ac:	0f 82 ec 02 00 00    	jb     8010199e <exec+0x3f3>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801016b2:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
801016b8:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
801016be:	01 d0                	add    %edx,%eax
801016c0:	83 ec 04             	sub    $0x4,%esp
801016c3:	50                   	push   %eax
801016c4:	ff 75 e0             	pushl  -0x20(%ebp)
801016c7:	ff 75 d4             	pushl  -0x2c(%ebp)
801016ca:	e8 ed 82 00 00       	call   801099bc <allocuvm>
801016cf:	83 c4 10             	add    $0x10,%esp
801016d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801016d5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801016d9:	0f 84 c2 02 00 00    	je     801019a1 <exec+0x3f6>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
801016df:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
801016e5:	25 ff 0f 00 00       	and    $0xfff,%eax
801016ea:	85 c0                	test   %eax,%eax
801016ec:	0f 85 b2 02 00 00    	jne    801019a4 <exec+0x3f9>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801016f2:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
801016f8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
801016fe:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80101704:	83 ec 0c             	sub    $0xc,%esp
80101707:	52                   	push   %edx
80101708:	50                   	push   %eax
80101709:	ff 75 d8             	pushl  -0x28(%ebp)
8010170c:	51                   	push   %ecx
8010170d:	ff 75 d4             	pushl  -0x2c(%ebp)
80101710:	e8 da 81 00 00       	call   801098ef <loaduvm>
80101715:	83 c4 20             	add    $0x20,%esp
80101718:	85 c0                	test   %eax,%eax
8010171a:	0f 88 87 02 00 00    	js     801019a7 <exec+0x3fc>
80101720:	eb 01                	jmp    80101723 <exec+0x178>
      continue;
80101722:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101723:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80101727:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010172a:	83 c0 20             	add    $0x20,%eax
8010172d:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101730:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80101737:	0f b7 c0             	movzwl %ax,%eax
8010173a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
8010173d:	0f 8c 0f ff ff ff    	jl     80101652 <exec+0xa7>
      goto bad;
  }
  iunlockput(ip);
80101743:	83 ec 0c             	sub    $0xc,%esp
80101746:	ff 75 d8             	pushl  -0x28(%ebp)
80101749:	e8 93 10 00 00       	call   801027e1 <iunlockput>
8010174e:	83 c4 10             	add    $0x10,%esp
  end_op();
80101751:	e8 e2 2c 00 00       	call   80104438 <end_op>
  ip = 0;
80101756:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
8010175d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101760:	05 ff 0f 00 00       	add    $0xfff,%eax
80101765:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010176a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
8010176d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101770:	05 00 20 00 00       	add    $0x2000,%eax
80101775:	83 ec 04             	sub    $0x4,%esp
80101778:	50                   	push   %eax
80101779:	ff 75 e0             	pushl  -0x20(%ebp)
8010177c:	ff 75 d4             	pushl  -0x2c(%ebp)
8010177f:	e8 38 82 00 00       	call   801099bc <allocuvm>
80101784:	83 c4 10             	add    $0x10,%esp
80101787:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010178a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010178e:	0f 84 16 02 00 00    	je     801019aa <exec+0x3ff>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101794:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101797:	2d 00 20 00 00       	sub    $0x2000,%eax
8010179c:	83 ec 08             	sub    $0x8,%esp
8010179f:	50                   	push   %eax
801017a0:	ff 75 d4             	pushl  -0x2c(%ebp)
801017a3:	e8 66 84 00 00       	call   80109c0e <clearpteu>
801017a8:	83 c4 10             	add    $0x10,%esp
  sp = sz;
801017ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
801017ae:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
801017b1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801017b8:	e9 96 00 00 00       	jmp    80101853 <exec+0x2a8>
    if(argc >= MAXARG)
801017bd:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
801017c1:	0f 87 e6 01 00 00    	ja     801019ad <exec+0x402>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801017c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801017ca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801017d1:	8b 45 0c             	mov    0xc(%ebp),%eax
801017d4:	01 d0                	add    %edx,%eax
801017d6:	8b 00                	mov    (%eax),%eax
801017d8:	83 ec 0c             	sub    $0xc,%esp
801017db:	50                   	push   %eax
801017dc:	e8 cf 52 00 00       	call   80106ab0 <strlen>
801017e1:	83 c4 10             	add    $0x10,%esp
801017e4:	89 c2                	mov    %eax,%edx
801017e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801017e9:	29 d0                	sub    %edx,%eax
801017eb:	83 e8 01             	sub    $0x1,%eax
801017ee:	83 e0 fc             	and    $0xfffffffc,%eax
801017f1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801017f4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801017f7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801017fe:	8b 45 0c             	mov    0xc(%ebp),%eax
80101801:	01 d0                	add    %edx,%eax
80101803:	8b 00                	mov    (%eax),%eax
80101805:	83 ec 0c             	sub    $0xc,%esp
80101808:	50                   	push   %eax
80101809:	e8 a2 52 00 00       	call   80106ab0 <strlen>
8010180e:	83 c4 10             	add    $0x10,%esp
80101811:	83 c0 01             	add    $0x1,%eax
80101814:	89 c1                	mov    %eax,%ecx
80101816:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101819:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101820:	8b 45 0c             	mov    0xc(%ebp),%eax
80101823:	01 d0                	add    %edx,%eax
80101825:	8b 00                	mov    (%eax),%eax
80101827:	51                   	push   %ecx
80101828:	50                   	push   %eax
80101829:	ff 75 dc             	pushl  -0x24(%ebp)
8010182c:	ff 75 d4             	pushl  -0x2c(%ebp)
8010182f:	e8 79 85 00 00       	call   80109dad <copyout>
80101834:	83 c4 10             	add    $0x10,%esp
80101837:	85 c0                	test   %eax,%eax
80101839:	0f 88 71 01 00 00    	js     801019b0 <exec+0x405>
      goto bad;
    ustack[3+argc] = sp;
8010183f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101842:	8d 50 03             	lea    0x3(%eax),%edx
80101845:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101848:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
  for(argc = 0; argv[argc]; argc++) {
8010184f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80101853:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101856:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010185d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101860:	01 d0                	add    %edx,%eax
80101862:	8b 00                	mov    (%eax),%eax
80101864:	85 c0                	test   %eax,%eax
80101866:	0f 85 51 ff ff ff    	jne    801017bd <exec+0x212>
  }
  ustack[3+argc] = 0;
8010186c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010186f:	83 c0 03             	add    $0x3,%eax
80101872:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80101879:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
8010187d:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80101884:	ff ff ff 
  ustack[1] = argc;
80101887:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010188a:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101890:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101893:	83 c0 01             	add    $0x1,%eax
80101896:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010189d:	8b 45 dc             	mov    -0x24(%ebp),%eax
801018a0:	29 d0                	sub    %edx,%eax
801018a2:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
801018a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801018ab:	83 c0 04             	add    $0x4,%eax
801018ae:	c1 e0 02             	shl    $0x2,%eax
801018b1:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801018b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801018b7:	83 c0 04             	add    $0x4,%eax
801018ba:	c1 e0 02             	shl    $0x2,%eax
801018bd:	50                   	push   %eax
801018be:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
801018c4:	50                   	push   %eax
801018c5:	ff 75 dc             	pushl  -0x24(%ebp)
801018c8:	ff 75 d4             	pushl  -0x2c(%ebp)
801018cb:	e8 dd 84 00 00       	call   80109dad <copyout>
801018d0:	83 c4 10             	add    $0x10,%esp
801018d3:	85 c0                	test   %eax,%eax
801018d5:	0f 88 d8 00 00 00    	js     801019b3 <exec+0x408>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
801018db:	8b 45 08             	mov    0x8(%ebp),%eax
801018de:	89 45 f4             	mov    %eax,-0xc(%ebp)
801018e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
801018e7:	eb 17                	jmp    80101900 <exec+0x355>
    if(*s == '/')
801018e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ec:	0f b6 00             	movzbl (%eax),%eax
801018ef:	3c 2f                	cmp    $0x2f,%al
801018f1:	75 09                	jne    801018fc <exec+0x351>
      last = s+1;
801018f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018f6:	83 c0 01             	add    $0x1,%eax
801018f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(last=s=path; *s; s++)
801018fc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101900:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101903:	0f b6 00             	movzbl (%eax),%eax
80101906:	84 c0                	test   %al,%al
80101908:	75 df                	jne    801018e9 <exec+0x33e>
  safestrcpy(proc->name, last, sizeof(proc->name));
8010190a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101910:	83 c0 6c             	add    $0x6c,%eax
80101913:	83 ec 04             	sub    $0x4,%esp
80101916:	6a 10                	push   $0x10
80101918:	ff 75 f0             	pushl  -0x10(%ebp)
8010191b:	50                   	push   %eax
8010191c:	e8 45 51 00 00       	call   80106a66 <safestrcpy>
80101921:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80101924:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010192a:	8b 40 04             	mov    0x4(%eax),%eax
8010192d:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80101930:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101936:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80101939:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
8010193c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101942:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101945:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80101947:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010194d:	8b 40 18             	mov    0x18(%eax),%eax
80101950:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80101956:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80101959:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010195f:	8b 40 18             	mov    0x18(%eax),%eax
80101962:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101965:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80101968:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010196e:	83 ec 0c             	sub    $0xc,%esp
80101971:	50                   	push   %eax
80101972:	e8 8f 7d 00 00       	call   80109706 <switchuvm>
80101977:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
8010197a:	83 ec 0c             	sub    $0xc,%esp
8010197d:	ff 75 d0             	pushl  -0x30(%ebp)
80101980:	e8 f0 81 00 00       	call   80109b75 <freevm>
80101985:	83 c4 10             	add    $0x10,%esp
  return 0;
80101988:	b8 00 00 00 00       	mov    $0x0,%eax
8010198d:	eb 57                	jmp    801019e6 <exec+0x43b>
    goto bad;
8010198f:	90                   	nop
80101990:	eb 22                	jmp    801019b4 <exec+0x409>
    goto bad;
80101992:	90                   	nop
80101993:	eb 1f                	jmp    801019b4 <exec+0x409>
    goto bad;
80101995:	90                   	nop
80101996:	eb 1c                	jmp    801019b4 <exec+0x409>
      goto bad;
80101998:	90                   	nop
80101999:	eb 19                	jmp    801019b4 <exec+0x409>
      goto bad;
8010199b:	90                   	nop
8010199c:	eb 16                	jmp    801019b4 <exec+0x409>
      goto bad;
8010199e:	90                   	nop
8010199f:	eb 13                	jmp    801019b4 <exec+0x409>
      goto bad;
801019a1:	90                   	nop
801019a2:	eb 10                	jmp    801019b4 <exec+0x409>
      goto bad;
801019a4:	90                   	nop
801019a5:	eb 0d                	jmp    801019b4 <exec+0x409>
      goto bad;
801019a7:	90                   	nop
801019a8:	eb 0a                	jmp    801019b4 <exec+0x409>
    goto bad;
801019aa:	90                   	nop
801019ab:	eb 07                	jmp    801019b4 <exec+0x409>
      goto bad;
801019ad:	90                   	nop
801019ae:	eb 04                	jmp    801019b4 <exec+0x409>
      goto bad;
801019b0:	90                   	nop
801019b1:	eb 01                	jmp    801019b4 <exec+0x409>
    goto bad;
801019b3:	90                   	nop

 bad:
  if(pgdir)
801019b4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
801019b8:	74 0e                	je     801019c8 <exec+0x41d>
    freevm(pgdir);
801019ba:	83 ec 0c             	sub    $0xc,%esp
801019bd:	ff 75 d4             	pushl  -0x2c(%ebp)
801019c0:	e8 b0 81 00 00       	call   80109b75 <freevm>
801019c5:	83 c4 10             	add    $0x10,%esp
  if(ip){
801019c8:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
801019cc:	74 13                	je     801019e1 <exec+0x436>
    iunlockput(ip);
801019ce:	83 ec 0c             	sub    $0xc,%esp
801019d1:	ff 75 d8             	pushl  -0x28(%ebp)
801019d4:	e8 08 0e 00 00       	call   801027e1 <iunlockput>
801019d9:	83 c4 10             	add    $0x10,%esp
    end_op();
801019dc:	e8 57 2a 00 00       	call   80104438 <end_op>
  }
  return -1;
801019e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801019e6:	c9                   	leave  
801019e7:	c3                   	ret    

801019e8 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801019e8:	55                   	push   %ebp
801019e9:	89 e5                	mov    %esp,%ebp
801019eb:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
801019ee:	83 ec 08             	sub    $0x8,%esp
801019f1:	68 97 b2 10 80       	push   $0x8010b297
801019f6:	68 c0 ec 12 80       	push   $0x8012ecc0
801019fb:	e8 9b 4b 00 00       	call   8010659b <initlock>
80101a00:	83 c4 10             	add    $0x10,%esp
}
80101a03:	90                   	nop
80101a04:	c9                   	leave  
80101a05:	c3                   	ret    

80101a06 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101a06:	55                   	push   %ebp
80101a07:	89 e5                	mov    %esp,%ebp
80101a09:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80101a0c:	83 ec 0c             	sub    $0xc,%esp
80101a0f:	68 c0 ec 12 80       	push   $0x8012ecc0
80101a14:	e8 a4 4b 00 00       	call   801065bd <acquire>
80101a19:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101a1c:	c7 45 f4 f4 ec 12 80 	movl   $0x8012ecf4,-0xc(%ebp)
80101a23:	eb 2d                	jmp    80101a52 <filealloc+0x4c>
    if(f->ref == 0){
80101a25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a28:	8b 40 04             	mov    0x4(%eax),%eax
80101a2b:	85 c0                	test   %eax,%eax
80101a2d:	75 1f                	jne    80101a4e <filealloc+0x48>
      f->ref = 1;
80101a2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a32:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80101a39:	83 ec 0c             	sub    $0xc,%esp
80101a3c:	68 c0 ec 12 80       	push   $0x8012ecc0
80101a41:	e8 e3 4b 00 00       	call   80106629 <release>
80101a46:	83 c4 10             	add    $0x10,%esp
      return f;
80101a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a4c:	eb 23                	jmp    80101a71 <filealloc+0x6b>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101a4e:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80101a52:	b8 54 f6 12 80       	mov    $0x8012f654,%eax
80101a57:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80101a5a:	72 c9                	jb     80101a25 <filealloc+0x1f>
    }
  }
  release(&ftable.lock);
80101a5c:	83 ec 0c             	sub    $0xc,%esp
80101a5f:	68 c0 ec 12 80       	push   $0x8012ecc0
80101a64:	e8 c0 4b 00 00       	call   80106629 <release>
80101a69:	83 c4 10             	add    $0x10,%esp
  return 0;
80101a6c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101a71:	c9                   	leave  
80101a72:	c3                   	ret    

80101a73 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101a73:	55                   	push   %ebp
80101a74:	89 e5                	mov    %esp,%ebp
80101a76:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80101a79:	83 ec 0c             	sub    $0xc,%esp
80101a7c:	68 c0 ec 12 80       	push   $0x8012ecc0
80101a81:	e8 37 4b 00 00       	call   801065bd <acquire>
80101a86:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101a89:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8c:	8b 40 04             	mov    0x4(%eax),%eax
80101a8f:	85 c0                	test   %eax,%eax
80101a91:	7f 0d                	jg     80101aa0 <filedup+0x2d>
    panic("filedup");
80101a93:	83 ec 0c             	sub    $0xc,%esp
80101a96:	68 9e b2 10 80       	push   $0x8010b29e
80101a9b:	e8 9e f3 ff ff       	call   80100e3e <panic>
  f->ref++;
80101aa0:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa3:	8b 40 04             	mov    0x4(%eax),%eax
80101aa6:	8d 50 01             	lea    0x1(%eax),%edx
80101aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aac:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80101aaf:	83 ec 0c             	sub    $0xc,%esp
80101ab2:	68 c0 ec 12 80       	push   $0x8012ecc0
80101ab7:	e8 6d 4b 00 00       	call   80106629 <release>
80101abc:	83 c4 10             	add    $0x10,%esp
  return f;
80101abf:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ac2:	c9                   	leave  
80101ac3:	c3                   	ret    

80101ac4 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101ac4:	55                   	push   %ebp
80101ac5:	89 e5                	mov    %esp,%ebp
80101ac7:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
80101aca:	83 ec 0c             	sub    $0xc,%esp
80101acd:	68 c0 ec 12 80       	push   $0x8012ecc0
80101ad2:	e8 e6 4a 00 00       	call   801065bd <acquire>
80101ad7:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101ada:	8b 45 08             	mov    0x8(%ebp),%eax
80101add:	8b 40 04             	mov    0x4(%eax),%eax
80101ae0:	85 c0                	test   %eax,%eax
80101ae2:	7f 0d                	jg     80101af1 <fileclose+0x2d>
    panic("fileclose");
80101ae4:	83 ec 0c             	sub    $0xc,%esp
80101ae7:	68 a6 b2 10 80       	push   $0x8010b2a6
80101aec:	e8 4d f3 ff ff       	call   80100e3e <panic>
  if(--f->ref > 0){
80101af1:	8b 45 08             	mov    0x8(%ebp),%eax
80101af4:	8b 40 04             	mov    0x4(%eax),%eax
80101af7:	8d 50 ff             	lea    -0x1(%eax),%edx
80101afa:	8b 45 08             	mov    0x8(%ebp),%eax
80101afd:	89 50 04             	mov    %edx,0x4(%eax)
80101b00:	8b 45 08             	mov    0x8(%ebp),%eax
80101b03:	8b 40 04             	mov    0x4(%eax),%eax
80101b06:	85 c0                	test   %eax,%eax
80101b08:	7e 15                	jle    80101b1f <fileclose+0x5b>
    release(&ftable.lock);
80101b0a:	83 ec 0c             	sub    $0xc,%esp
80101b0d:	68 c0 ec 12 80       	push   $0x8012ecc0
80101b12:	e8 12 4b 00 00       	call   80106629 <release>
80101b17:	83 c4 10             	add    $0x10,%esp
80101b1a:	e9 8b 00 00 00       	jmp    80101baa <fileclose+0xe6>
    return;
  }
  ff = *f;
80101b1f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b22:	8b 10                	mov    (%eax),%edx
80101b24:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101b27:	8b 50 04             	mov    0x4(%eax),%edx
80101b2a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101b2d:	8b 50 08             	mov    0x8(%eax),%edx
80101b30:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101b33:	8b 50 0c             	mov    0xc(%eax),%edx
80101b36:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101b39:	8b 50 10             	mov    0x10(%eax),%edx
80101b3c:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101b3f:	8b 40 14             	mov    0x14(%eax),%eax
80101b42:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101b45:	8b 45 08             	mov    0x8(%ebp),%eax
80101b48:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
80101b4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101b58:	83 ec 0c             	sub    $0xc,%esp
80101b5b:	68 c0 ec 12 80       	push   $0x8012ecc0
80101b60:	e8 c4 4a 00 00       	call   80106629 <release>
80101b65:	83 c4 10             	add    $0x10,%esp

  if(ff.type == FD_PIPE)
80101b68:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b6b:	83 f8 01             	cmp    $0x1,%eax
80101b6e:	75 19                	jne    80101b89 <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
80101b70:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101b74:	0f be d0             	movsbl %al,%edx
80101b77:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101b7a:	83 ec 08             	sub    $0x8,%esp
80101b7d:	52                   	push   %edx
80101b7e:	50                   	push   %eax
80101b7f:	e8 53 3b 00 00       	call   801056d7 <pipeclose>
80101b84:	83 c4 10             	add    $0x10,%esp
80101b87:	eb 21                	jmp    80101baa <fileclose+0xe6>
  else if(ff.type == FD_INODE){
80101b89:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b8c:	83 f8 02             	cmp    $0x2,%eax
80101b8f:	75 19                	jne    80101baa <fileclose+0xe6>
    begin_op();
80101b91:	e8 16 28 00 00       	call   801043ac <begin_op>
    iput(ff.ip);
80101b96:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101b99:	83 ec 0c             	sub    $0xc,%esp
80101b9c:	50                   	push   %eax
80101b9d:	e8 4f 0b 00 00       	call   801026f1 <iput>
80101ba2:	83 c4 10             	add    $0x10,%esp
    end_op();
80101ba5:	e8 8e 28 00 00       	call   80104438 <end_op>
  }
}
80101baa:	c9                   	leave  
80101bab:	c3                   	ret    

80101bac <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101bac:	55                   	push   %ebp
80101bad:	89 e5                	mov    %esp,%ebp
80101baf:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
80101bb2:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb5:	8b 00                	mov    (%eax),%eax
80101bb7:	83 f8 02             	cmp    $0x2,%eax
80101bba:	75 40                	jne    80101bfc <filestat+0x50>
    ilock(f->ip);
80101bbc:	8b 45 08             	mov    0x8(%ebp),%eax
80101bbf:	8b 40 10             	mov    0x10(%eax),%eax
80101bc2:	83 ec 0c             	sub    $0xc,%esp
80101bc5:	50                   	push   %eax
80101bc6:	e8 56 09 00 00       	call   80102521 <ilock>
80101bcb:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
80101bce:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd1:	8b 40 10             	mov    0x10(%eax),%eax
80101bd4:	83 ec 08             	sub    $0x8,%esp
80101bd7:	ff 75 0c             	pushl  0xc(%ebp)
80101bda:	50                   	push   %eax
80101bdb:	e8 64 0e 00 00       	call   80102a44 <stati>
80101be0:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
80101be3:	8b 45 08             	mov    0x8(%ebp),%eax
80101be6:	8b 40 10             	mov    0x10(%eax),%eax
80101be9:	83 ec 0c             	sub    $0xc,%esp
80101bec:	50                   	push   %eax
80101bed:	e8 8d 0a 00 00       	call   8010267f <iunlock>
80101bf2:	83 c4 10             	add    $0x10,%esp
    return 0;
80101bf5:	b8 00 00 00 00       	mov    $0x0,%eax
80101bfa:	eb 05                	jmp    80101c01 <filestat+0x55>
  }
  return -1;
80101bfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101c01:	c9                   	leave  
80101c02:	c3                   	ret    

80101c03 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101c03:	55                   	push   %ebp
80101c04:	89 e5                	mov    %esp,%ebp
80101c06:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
80101c09:	8b 45 08             	mov    0x8(%ebp),%eax
80101c0c:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101c10:	84 c0                	test   %al,%al
80101c12:	75 0a                	jne    80101c1e <fileread+0x1b>
    return -1;
80101c14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c19:	e9 9b 00 00 00       	jmp    80101cb9 <fileread+0xb6>
  if(f->type == FD_PIPE)
80101c1e:	8b 45 08             	mov    0x8(%ebp),%eax
80101c21:	8b 00                	mov    (%eax),%eax
80101c23:	83 f8 01             	cmp    $0x1,%eax
80101c26:	75 1a                	jne    80101c42 <fileread+0x3f>
    return piperead(f->pipe, addr, n);
80101c28:	8b 45 08             	mov    0x8(%ebp),%eax
80101c2b:	8b 40 0c             	mov    0xc(%eax),%eax
80101c2e:	83 ec 04             	sub    $0x4,%esp
80101c31:	ff 75 10             	pushl  0x10(%ebp)
80101c34:	ff 75 0c             	pushl  0xc(%ebp)
80101c37:	50                   	push   %eax
80101c38:	e8 5f 3c 00 00       	call   8010589c <piperead>
80101c3d:	83 c4 10             	add    $0x10,%esp
80101c40:	eb 77                	jmp    80101cb9 <fileread+0xb6>
  if(f->type == FD_INODE){
80101c42:	8b 45 08             	mov    0x8(%ebp),%eax
80101c45:	8b 00                	mov    (%eax),%eax
80101c47:	83 f8 02             	cmp    $0x2,%eax
80101c4a:	75 60                	jne    80101cac <fileread+0xa9>
    ilock(f->ip);
80101c4c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c4f:	8b 40 10             	mov    0x10(%eax),%eax
80101c52:	83 ec 0c             	sub    $0xc,%esp
80101c55:	50                   	push   %eax
80101c56:	e8 c6 08 00 00       	call   80102521 <ilock>
80101c5b:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101c5e:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101c61:	8b 45 08             	mov    0x8(%ebp),%eax
80101c64:	8b 50 14             	mov    0x14(%eax),%edx
80101c67:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6a:	8b 40 10             	mov    0x10(%eax),%eax
80101c6d:	51                   	push   %ecx
80101c6e:	52                   	push   %edx
80101c6f:	ff 75 0c             	pushl  0xc(%ebp)
80101c72:	50                   	push   %eax
80101c73:	e8 12 0e 00 00       	call   80102a8a <readi>
80101c78:	83 c4 10             	add    $0x10,%esp
80101c7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c7e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c82:	7e 11                	jle    80101c95 <fileread+0x92>
      f->off += r;
80101c84:	8b 45 08             	mov    0x8(%ebp),%eax
80101c87:	8b 50 14             	mov    0x14(%eax),%edx
80101c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c8d:	01 c2                	add    %eax,%edx
80101c8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c92:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101c95:	8b 45 08             	mov    0x8(%ebp),%eax
80101c98:	8b 40 10             	mov    0x10(%eax),%eax
80101c9b:	83 ec 0c             	sub    $0xc,%esp
80101c9e:	50                   	push   %eax
80101c9f:	e8 db 09 00 00       	call   8010267f <iunlock>
80101ca4:	83 c4 10             	add    $0x10,%esp
    return r;
80101ca7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101caa:	eb 0d                	jmp    80101cb9 <fileread+0xb6>
  }
  panic("fileread");
80101cac:	83 ec 0c             	sub    $0xc,%esp
80101caf:	68 b0 b2 10 80       	push   $0x8010b2b0
80101cb4:	e8 85 f1 ff ff       	call   80100e3e <panic>
}
80101cb9:	c9                   	leave  
80101cba:	c3                   	ret    

80101cbb <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101cbb:	55                   	push   %ebp
80101cbc:	89 e5                	mov    %esp,%ebp
80101cbe:	53                   	push   %ebx
80101cbf:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
80101cc2:	8b 45 08             	mov    0x8(%ebp),%eax
80101cc5:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101cc9:	84 c0                	test   %al,%al
80101ccb:	75 0a                	jne    80101cd7 <filewrite+0x1c>
    return -1;
80101ccd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cd2:	e9 1b 01 00 00       	jmp    80101df2 <filewrite+0x137>
  if(f->type == FD_PIPE)
80101cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80101cda:	8b 00                	mov    (%eax),%eax
80101cdc:	83 f8 01             	cmp    $0x1,%eax
80101cdf:	75 1d                	jne    80101cfe <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
80101ce1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ce4:	8b 40 0c             	mov    0xc(%eax),%eax
80101ce7:	83 ec 04             	sub    $0x4,%esp
80101cea:	ff 75 10             	pushl  0x10(%ebp)
80101ced:	ff 75 0c             	pushl  0xc(%ebp)
80101cf0:	50                   	push   %eax
80101cf1:	e8 8b 3a 00 00       	call   80105781 <pipewrite>
80101cf6:	83 c4 10             	add    $0x10,%esp
80101cf9:	e9 f4 00 00 00       	jmp    80101df2 <filewrite+0x137>
  if(f->type == FD_INODE){
80101cfe:	8b 45 08             	mov    0x8(%ebp),%eax
80101d01:	8b 00                	mov    (%eax),%eax
80101d03:	83 f8 02             	cmp    $0x2,%eax
80101d06:	0f 85 d9 00 00 00    	jne    80101de5 <filewrite+0x12a>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
80101d0c:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
80101d13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101d1a:	e9 a3 00 00 00       	jmp    80101dc2 <filewrite+0x107>
      int n1 = n - i;
80101d1f:	8b 45 10             	mov    0x10(%ebp),%eax
80101d22:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101d25:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101d28:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d2b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101d2e:	7e 06                	jle    80101d36 <filewrite+0x7b>
        n1 = max;
80101d30:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d33:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
80101d36:	e8 71 26 00 00       	call   801043ac <begin_op>
      ilock(f->ip);
80101d3b:	8b 45 08             	mov    0x8(%ebp),%eax
80101d3e:	8b 40 10             	mov    0x10(%eax),%eax
80101d41:	83 ec 0c             	sub    $0xc,%esp
80101d44:	50                   	push   %eax
80101d45:	e8 d7 07 00 00       	call   80102521 <ilock>
80101d4a:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101d4d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101d50:	8b 45 08             	mov    0x8(%ebp),%eax
80101d53:	8b 50 14             	mov    0x14(%eax),%edx
80101d56:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101d59:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d5c:	01 c3                	add    %eax,%ebx
80101d5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d61:	8b 40 10             	mov    0x10(%eax),%eax
80101d64:	51                   	push   %ecx
80101d65:	52                   	push   %edx
80101d66:	53                   	push   %ebx
80101d67:	50                   	push   %eax
80101d68:	e8 8c 0e 00 00       	call   80102bf9 <writei>
80101d6d:	83 c4 10             	add    $0x10,%esp
80101d70:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101d73:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101d77:	7e 11                	jle    80101d8a <filewrite+0xcf>
        f->off += r;
80101d79:	8b 45 08             	mov    0x8(%ebp),%eax
80101d7c:	8b 50 14             	mov    0x14(%eax),%edx
80101d7f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d82:	01 c2                	add    %eax,%edx
80101d84:	8b 45 08             	mov    0x8(%ebp),%eax
80101d87:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
80101d8a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d8d:	8b 40 10             	mov    0x10(%eax),%eax
80101d90:	83 ec 0c             	sub    $0xc,%esp
80101d93:	50                   	push   %eax
80101d94:	e8 e6 08 00 00       	call   8010267f <iunlock>
80101d99:	83 c4 10             	add    $0x10,%esp
      end_op();
80101d9c:	e8 97 26 00 00       	call   80104438 <end_op>

      if(r < 0)
80101da1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101da5:	78 29                	js     80101dd0 <filewrite+0x115>
        break;
      if(r != n1)
80101da7:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101daa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80101dad:	74 0d                	je     80101dbc <filewrite+0x101>
        panic("short filewrite");
80101daf:	83 ec 0c             	sub    $0xc,%esp
80101db2:	68 b9 b2 10 80       	push   $0x8010b2b9
80101db7:	e8 82 f0 ff ff       	call   80100e3e <panic>
      i += r;
80101dbc:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101dbf:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
80101dc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101dc5:	3b 45 10             	cmp    0x10(%ebp),%eax
80101dc8:	0f 8c 51 ff ff ff    	jl     80101d1f <filewrite+0x64>
80101dce:	eb 01                	jmp    80101dd1 <filewrite+0x116>
        break;
80101dd0:	90                   	nop
    }
    return i == n ? n : -1;
80101dd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101dd4:	3b 45 10             	cmp    0x10(%ebp),%eax
80101dd7:	75 05                	jne    80101dde <filewrite+0x123>
80101dd9:	8b 45 10             	mov    0x10(%ebp),%eax
80101ddc:	eb 14                	jmp    80101df2 <filewrite+0x137>
80101dde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101de3:	eb 0d                	jmp    80101df2 <filewrite+0x137>
  }
  panic("filewrite");
80101de5:	83 ec 0c             	sub    $0xc,%esp
80101de8:	68 c9 b2 10 80       	push   $0x8010b2c9
80101ded:	e8 4c f0 ff ff       	call   80100e3e <panic>
}
80101df2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101df5:	c9                   	leave  
80101df6:	c3                   	ret    

80101df7 <filewriteable>:

int
filewriteable(struct file * f)
{
80101df7:	55                   	push   %ebp
80101df8:	89 e5                	mov    %esp,%ebp
80101dfa:	83 ec 08             	sub    $0x8,%esp
    if (f->type == FD_PIPE)
80101dfd:	8b 45 08             	mov    0x8(%ebp),%eax
80101e00:	8b 00                	mov    (%eax),%eax
80101e02:	83 f8 01             	cmp    $0x1,%eax
80101e05:	75 14                	jne    80101e1b <filewriteable+0x24>
        return pipewriteable(f->pipe);
80101e07:	8b 45 08             	mov    0x8(%ebp),%eax
80101e0a:	8b 40 0c             	mov    0xc(%eax),%eax
80101e0d:	83 ec 0c             	sub    $0xc,%esp
80101e10:	50                   	push   %eax
80101e11:	e8 83 3b 00 00       	call   80105999 <pipewriteable>
80101e16:	83 c4 10             	add    $0x10,%esp
80101e19:	eb 2a                	jmp    80101e45 <filewriteable+0x4e>
    if (f->type == FD_INODE)
80101e1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1e:	8b 00                	mov    (%eax),%eax
80101e20:	83 f8 02             	cmp    $0x2,%eax
80101e23:	75 1b                	jne    80101e40 <filewriteable+0x49>
        return writeablei(f->ip, f->off);
80101e25:	8b 45 08             	mov    0x8(%ebp),%eax
80101e28:	8b 50 14             	mov    0x14(%eax),%edx
80101e2b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2e:	8b 40 10             	mov    0x10(%eax),%eax
80101e31:	83 ec 08             	sub    $0x8,%esp
80101e34:	52                   	push   %edx
80101e35:	50                   	push   %eax
80101e36:	e8 87 13 00 00       	call   801031c2 <writeablei>
80101e3b:	83 c4 10             	add    $0x10,%esp
80101e3e:	eb 05                	jmp    80101e45 <filewriteable+0x4e>
    else
        return -1;
80101e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    
    return 0;
}
80101e45:	c9                   	leave  
80101e46:	c3                   	ret    

80101e47 <filereadable>:

int
filereadable(struct file * f)
{
80101e47:	55                   	push   %ebp
80101e48:	89 e5                	mov    %esp,%ebp
80101e4a:	83 ec 08             	sub    $0x8,%esp
    if (f->type == FD_PIPE)
80101e4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101e50:	8b 00                	mov    (%eax),%eax
80101e52:	83 f8 01             	cmp    $0x1,%eax
80101e55:	75 14                	jne    80101e6b <filereadable+0x24>
        return pipereadable(f->pipe);
80101e57:	8b 45 08             	mov    0x8(%ebp),%eax
80101e5a:	8b 40 0c             	mov    0xc(%eax),%eax
80101e5d:	83 ec 0c             	sub    $0xc,%esp
80101e60:	50                   	push   %eax
80101e61:	e8 3d 3b 00 00       	call   801059a3 <pipereadable>
80101e66:	83 c4 10             	add    $0x10,%esp
80101e69:	eb 2a                	jmp    80101e95 <filereadable+0x4e>
    if (f->type == FD_INODE)
80101e6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e6e:	8b 00                	mov    (%eax),%eax
80101e70:	83 f8 02             	cmp    $0x2,%eax
80101e73:	75 1b                	jne    80101e90 <filereadable+0x49>
        return readablei(f->ip, f->off);
80101e75:	8b 45 08             	mov    0x8(%ebp),%eax
80101e78:	8b 50 14             	mov    0x14(%eax),%edx
80101e7b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e7e:	8b 40 10             	mov    0x10(%eax),%eax
80101e81:	83 ec 08             	sub    $0x8,%esp
80101e84:	52                   	push   %edx
80101e85:	50                   	push   %eax
80101e86:	e8 b6 12 00 00       	call   80103141 <readablei>
80101e8b:	83 c4 10             	add    $0x10,%esp
80101e8e:	eb 05                	jmp    80101e95 <filereadable+0x4e>
    else
        return -1;
80101e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     
    return 0;
}
80101e95:	c9                   	leave  
80101e96:	c3                   	ret    

80101e97 <fileselect>:

int
fileselect(struct file *f, int *selid, struct spinlock *lk)
{
80101e97:	55                   	push   %ebp
80101e98:	89 e5                	mov    %esp,%ebp
80101e9a:	83 ec 08             	sub    $0x8,%esp
    if (f->type == FD_PIPE)
80101e9d:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea0:	8b 00                	mov    (%eax),%eax
80101ea2:	83 f8 01             	cmp    $0x1,%eax
80101ea5:	75 1a                	jne    80101ec1 <fileselect+0x2a>
        return pipeselect(f->pipe, selid, lk);
80101ea7:	8b 45 08             	mov    0x8(%ebp),%eax
80101eaa:	8b 40 0c             	mov    0xc(%eax),%eax
80101ead:	83 ec 04             	sub    $0x4,%esp
80101eb0:	ff 75 10             	pushl  0x10(%ebp)
80101eb3:	ff 75 0c             	pushl  0xc(%ebp)
80101eb6:	50                   	push   %eax
80101eb7:	e8 f1 3a 00 00       	call   801059ad <pipeselect>
80101ebc:	83 c4 10             	add    $0x10,%esp
80101ebf:	eb 29                	jmp    80101eea <fileselect+0x53>
    if (f->type == FD_INODE)
80101ec1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec4:	8b 00                	mov    (%eax),%eax
80101ec6:	83 f8 02             	cmp    $0x2,%eax
80101ec9:	75 1a                	jne    80101ee5 <fileselect+0x4e>
        return selecti(f->ip, selid, lk);
80101ecb:	8b 45 08             	mov    0x8(%ebp),%eax
80101ece:	8b 40 10             	mov    0x10(%eax),%eax
80101ed1:	83 ec 04             	sub    $0x4,%esp
80101ed4:	ff 75 10             	pushl  0x10(%ebp)
80101ed7:	ff 75 0c             	pushl  0xc(%ebp)
80101eda:	50                   	push   %eax
80101edb:	e8 63 13 00 00       	call   80103243 <selecti>
80101ee0:	83 c4 10             	add    $0x10,%esp
80101ee3:	eb 05                	jmp    80101eea <fileselect+0x53>
    else
        return -1;
80101ee5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 
    return 0;
}
80101eea:	c9                   	leave  
80101eeb:	c3                   	ret    

80101eec <fileclrsel>:

int
fileclrsel(struct file *f, int *selid)
{
80101eec:	55                   	push   %ebp
80101eed:	89 e5                	mov    %esp,%ebp
80101eef:	83 ec 08             	sub    $0x8,%esp
    if (f->type == FD_PIPE)
80101ef2:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef5:	8b 00                	mov    (%eax),%eax
80101ef7:	83 f8 01             	cmp    $0x1,%eax
80101efa:	75 17                	jne    80101f13 <fileclrsel+0x27>
        return pipeclrsel(f->pipe, selid);
80101efc:	8b 45 08             	mov    0x8(%ebp),%eax
80101eff:	8b 40 0c             	mov    0xc(%eax),%eax
80101f02:	83 ec 08             	sub    $0x8,%esp
80101f05:	ff 75 0c             	pushl  0xc(%ebp)
80101f08:	50                   	push   %eax
80101f09:	e8 a9 3a 00 00       	call   801059b7 <pipeclrsel>
80101f0e:	83 c4 10             	add    $0x10,%esp
80101f11:	eb 26                	jmp    80101f39 <fileclrsel+0x4d>
    if (f->type == FD_INODE)
80101f13:	8b 45 08             	mov    0x8(%ebp),%eax
80101f16:	8b 00                	mov    (%eax),%eax
80101f18:	83 f8 02             	cmp    $0x2,%eax
80101f1b:	75 17                	jne    80101f34 <fileclrsel+0x48>
        return clrseli(f->ip, selid);
80101f1d:	8b 45 08             	mov    0x8(%ebp),%eax
80101f20:	8b 40 10             	mov    0x10(%eax),%eax
80101f23:	83 ec 08             	sub    $0x8,%esp
80101f26:	ff 75 0c             	pushl  0xc(%ebp)
80101f29:	50                   	push   %eax
80101f2a:	e8 9b 13 00 00       	call   801032ca <clrseli>
80101f2f:	83 c4 10             	add    $0x10,%esp
80101f32:	eb 05                	jmp    80101f39 <fileclrsel+0x4d>
    else
        return -1;
80101f34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 
    return 0;
}
80101f39:	c9                   	leave  
80101f3a:	c3                   	ret    

80101f3b <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101f3b:	55                   	push   %ebp
80101f3c:	89 e5                	mov    %esp,%ebp
80101f3e:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
80101f41:	8b 45 08             	mov    0x8(%ebp),%eax
80101f44:	83 ec 08             	sub    $0x8,%esp
80101f47:	6a 01                	push   $0x1
80101f49:	50                   	push   %eax
80101f4a:	e8 74 ec ff ff       	call   80100bc3 <bread>
80101f4f:	83 c4 10             	add    $0x10,%esp
80101f52:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f58:	83 c0 18             	add    $0x18,%eax
80101f5b:	83 ec 04             	sub    $0x4,%esp
80101f5e:	6a 1c                	push   $0x1c
80101f60:	50                   	push   %eax
80101f61:	ff 75 0c             	pushl  0xc(%ebp)
80101f64:	e8 89 49 00 00       	call   801068f2 <memmove>
80101f69:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101f6c:	83 ec 0c             	sub    $0xc,%esp
80101f6f:	ff 75 f4             	pushl  -0xc(%ebp)
80101f72:	e8 c4 ec ff ff       	call   80100c3b <brelse>
80101f77:	83 c4 10             	add    $0x10,%esp
}
80101f7a:	90                   	nop
80101f7b:	c9                   	leave  
80101f7c:	c3                   	ret    

80101f7d <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101f7d:	55                   	push   %ebp
80101f7e:	89 e5                	mov    %esp,%ebp
80101f80:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, bno);
80101f83:	8b 55 0c             	mov    0xc(%ebp),%edx
80101f86:	8b 45 08             	mov    0x8(%ebp),%eax
80101f89:	83 ec 08             	sub    $0x8,%esp
80101f8c:	52                   	push   %edx
80101f8d:	50                   	push   %eax
80101f8e:	e8 30 ec ff ff       	call   80100bc3 <bread>
80101f93:	83 c4 10             	add    $0x10,%esp
80101f96:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f9c:	83 c0 18             	add    $0x18,%eax
80101f9f:	83 ec 04             	sub    $0x4,%esp
80101fa2:	68 00 02 00 00       	push   $0x200
80101fa7:	6a 00                	push   $0x0
80101fa9:	50                   	push   %eax
80101faa:	e8 84 48 00 00       	call   80106833 <memset>
80101faf:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101fb2:	83 ec 0c             	sub    $0xc,%esp
80101fb5:	ff 75 f4             	pushl  -0xc(%ebp)
80101fb8:	e8 27 26 00 00       	call   801045e4 <log_write>
80101fbd:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101fc0:	83 ec 0c             	sub    $0xc,%esp
80101fc3:	ff 75 f4             	pushl  -0xc(%ebp)
80101fc6:	e8 70 ec ff ff       	call   80100c3b <brelse>
80101fcb:	83 c4 10             	add    $0x10,%esp
}
80101fce:	90                   	nop
80101fcf:	c9                   	leave  
80101fd0:	c3                   	ret    

80101fd1 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101fd1:	55                   	push   %ebp
80101fd2:	89 e5                	mov    %esp,%ebp
80101fd4:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
80101fd7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101fde:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101fe5:	e9 13 01 00 00       	jmp    801020fd <balloc+0x12c>
    bp = bread(dev, BBLOCK(b, sb));
80101fea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fed:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80101ff3:	85 c0                	test   %eax,%eax
80101ff5:	0f 48 c2             	cmovs  %edx,%eax
80101ff8:	c1 f8 0c             	sar    $0xc,%eax
80101ffb:	89 c2                	mov    %eax,%edx
80101ffd:	a1 b8 01 13 80       	mov    0x801301b8,%eax
80102002:	01 d0                	add    %edx,%eax
80102004:	83 ec 08             	sub    $0x8,%esp
80102007:	50                   	push   %eax
80102008:	ff 75 08             	pushl  0x8(%ebp)
8010200b:	e8 b3 eb ff ff       	call   80100bc3 <bread>
80102010:	83 c4 10             	add    $0x10,%esp
80102013:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80102016:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010201d:	e9 a6 00 00 00       	jmp    801020c8 <balloc+0xf7>
      m = 1 << (bi % 8);
80102022:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102025:	99                   	cltd   
80102026:	c1 ea 1d             	shr    $0x1d,%edx
80102029:	01 d0                	add    %edx,%eax
8010202b:	83 e0 07             	and    $0x7,%eax
8010202e:	29 d0                	sub    %edx,%eax
80102030:	ba 01 00 00 00       	mov    $0x1,%edx
80102035:	89 c1                	mov    %eax,%ecx
80102037:	d3 e2                	shl    %cl,%edx
80102039:	89 d0                	mov    %edx,%eax
8010203b:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010203e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102041:	8d 50 07             	lea    0x7(%eax),%edx
80102044:	85 c0                	test   %eax,%eax
80102046:	0f 48 c2             	cmovs  %edx,%eax
80102049:	c1 f8 03             	sar    $0x3,%eax
8010204c:	89 c2                	mov    %eax,%edx
8010204e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102051:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80102056:	0f b6 c0             	movzbl %al,%eax
80102059:	23 45 e8             	and    -0x18(%ebp),%eax
8010205c:	85 c0                	test   %eax,%eax
8010205e:	75 64                	jne    801020c4 <balloc+0xf3>
        bp->data[bi/8] |= m;  // Mark block in use.
80102060:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102063:	8d 50 07             	lea    0x7(%eax),%edx
80102066:	85 c0                	test   %eax,%eax
80102068:	0f 48 c2             	cmovs  %edx,%eax
8010206b:	c1 f8 03             	sar    $0x3,%eax
8010206e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80102071:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80102076:	89 d1                	mov    %edx,%ecx
80102078:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010207b:	09 ca                	or     %ecx,%edx
8010207d:	89 d1                	mov    %edx,%ecx
8010207f:	8b 55 ec             	mov    -0x14(%ebp),%edx
80102082:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
80102086:	83 ec 0c             	sub    $0xc,%esp
80102089:	ff 75 ec             	pushl  -0x14(%ebp)
8010208c:	e8 53 25 00 00       	call   801045e4 <log_write>
80102091:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
80102094:	83 ec 0c             	sub    $0xc,%esp
80102097:	ff 75 ec             	pushl  -0x14(%ebp)
8010209a:	e8 9c eb ff ff       	call   80100c3b <brelse>
8010209f:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801020a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801020a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020a8:	01 c2                	add    %eax,%edx
801020aa:	8b 45 08             	mov    0x8(%ebp),%eax
801020ad:	83 ec 08             	sub    $0x8,%esp
801020b0:	52                   	push   %edx
801020b1:	50                   	push   %eax
801020b2:	e8 c6 fe ff ff       	call   80101f7d <bzero>
801020b7:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801020ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
801020bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020c0:	01 d0                	add    %edx,%eax
801020c2:	eb 57                	jmp    8010211b <balloc+0x14a>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801020c4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801020c8:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801020cf:	7f 17                	jg     801020e8 <balloc+0x117>
801020d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801020d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020d7:	01 d0                	add    %edx,%eax
801020d9:	89 c2                	mov    %eax,%edx
801020db:	a1 a0 01 13 80       	mov    0x801301a0,%eax
801020e0:	39 c2                	cmp    %eax,%edx
801020e2:	0f 82 3a ff ff ff    	jb     80102022 <balloc+0x51>
      }
    }
    brelse(bp);
801020e8:	83 ec 0c             	sub    $0xc,%esp
801020eb:	ff 75 ec             	pushl  -0x14(%ebp)
801020ee:	e8 48 eb ff ff       	call   80100c3b <brelse>
801020f3:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
801020f6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801020fd:	8b 15 a0 01 13 80    	mov    0x801301a0,%edx
80102103:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102106:	39 c2                	cmp    %eax,%edx
80102108:	0f 87 dc fe ff ff    	ja     80101fea <balloc+0x19>
  }
  panic("balloc: out of blocks");
8010210e:	83 ec 0c             	sub    $0xc,%esp
80102111:	68 d4 b2 10 80       	push   $0x8010b2d4
80102116:	e8 23 ed ff ff       	call   80100e3e <panic>
}
8010211b:	c9                   	leave  
8010211c:	c3                   	ret    

8010211d <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
8010211d:	55                   	push   %ebp
8010211e:	89 e5                	mov    %esp,%ebp
80102120:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80102123:	83 ec 08             	sub    $0x8,%esp
80102126:	68 a0 01 13 80       	push   $0x801301a0
8010212b:	ff 75 08             	pushl  0x8(%ebp)
8010212e:	e8 08 fe ff ff       	call   80101f3b <readsb>
80102133:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80102136:	8b 45 0c             	mov    0xc(%ebp),%eax
80102139:	c1 e8 0c             	shr    $0xc,%eax
8010213c:	89 c2                	mov    %eax,%edx
8010213e:	a1 b8 01 13 80       	mov    0x801301b8,%eax
80102143:	01 c2                	add    %eax,%edx
80102145:	8b 45 08             	mov    0x8(%ebp),%eax
80102148:	83 ec 08             	sub    $0x8,%esp
8010214b:	52                   	push   %edx
8010214c:	50                   	push   %eax
8010214d:	e8 71 ea ff ff       	call   80100bc3 <bread>
80102152:	83 c4 10             	add    $0x10,%esp
80102155:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80102158:	8b 45 0c             	mov    0xc(%ebp),%eax
8010215b:	25 ff 0f 00 00       	and    $0xfff,%eax
80102160:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80102163:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102166:	99                   	cltd   
80102167:	c1 ea 1d             	shr    $0x1d,%edx
8010216a:	01 d0                	add    %edx,%eax
8010216c:	83 e0 07             	and    $0x7,%eax
8010216f:	29 d0                	sub    %edx,%eax
80102171:	ba 01 00 00 00       	mov    $0x1,%edx
80102176:	89 c1                	mov    %eax,%ecx
80102178:	d3 e2                	shl    %cl,%edx
8010217a:	89 d0                	mov    %edx,%eax
8010217c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
8010217f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102182:	8d 50 07             	lea    0x7(%eax),%edx
80102185:	85 c0                	test   %eax,%eax
80102187:	0f 48 c2             	cmovs  %edx,%eax
8010218a:	c1 f8 03             	sar    $0x3,%eax
8010218d:	89 c2                	mov    %eax,%edx
8010218f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102192:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80102197:	0f b6 c0             	movzbl %al,%eax
8010219a:	23 45 ec             	and    -0x14(%ebp),%eax
8010219d:	85 c0                	test   %eax,%eax
8010219f:	75 0d                	jne    801021ae <bfree+0x91>
    panic("freeing free block");
801021a1:	83 ec 0c             	sub    $0xc,%esp
801021a4:	68 ea b2 10 80       	push   $0x8010b2ea
801021a9:	e8 90 ec ff ff       	call   80100e3e <panic>
  bp->data[bi/8] &= ~m;
801021ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801021b1:	8d 50 07             	lea    0x7(%eax),%edx
801021b4:	85 c0                	test   %eax,%eax
801021b6:	0f 48 c2             	cmovs  %edx,%eax
801021b9:	c1 f8 03             	sar    $0x3,%eax
801021bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021bf:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801021c4:	89 d1                	mov    %edx,%ecx
801021c6:	8b 55 ec             	mov    -0x14(%ebp),%edx
801021c9:	f7 d2                	not    %edx
801021cb:	21 ca                	and    %ecx,%edx
801021cd:	89 d1                	mov    %edx,%ecx
801021cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021d2:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
801021d6:	83 ec 0c             	sub    $0xc,%esp
801021d9:	ff 75 f4             	pushl  -0xc(%ebp)
801021dc:	e8 03 24 00 00       	call   801045e4 <log_write>
801021e1:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801021e4:	83 ec 0c             	sub    $0xc,%esp
801021e7:	ff 75 f4             	pushl  -0xc(%ebp)
801021ea:	e8 4c ea ff ff       	call   80100c3b <brelse>
801021ef:	83 c4 10             	add    $0x10,%esp
}
801021f2:	90                   	nop
801021f3:	c9                   	leave  
801021f4:	c3                   	ret    

801021f5 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801021f5:	55                   	push   %ebp
801021f6:	89 e5                	mov    %esp,%ebp
801021f8:	57                   	push   %edi
801021f9:	56                   	push   %esi
801021fa:	53                   	push   %ebx
801021fb:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&icache.lock, "icache");
801021fe:	83 ec 08             	sub    $0x8,%esp
80102201:	68 fd b2 10 80       	push   $0x8010b2fd
80102206:	68 c0 01 13 80       	push   $0x801301c0
8010220b:	e8 8b 43 00 00       	call   8010659b <initlock>
80102210:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
80102213:	83 ec 08             	sub    $0x8,%esp
80102216:	68 a0 01 13 80       	push   $0x801301a0
8010221b:	ff 75 08             	pushl  0x8(%ebp)
8010221e:	e8 18 fd ff ff       	call   80101f3b <readsb>
80102223:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80102226:	a1 b8 01 13 80       	mov    0x801301b8,%eax
8010222b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010222e:	8b 3d b4 01 13 80    	mov    0x801301b4,%edi
80102234:	8b 35 b0 01 13 80    	mov    0x801301b0,%esi
8010223a:	8b 1d ac 01 13 80    	mov    0x801301ac,%ebx
80102240:	8b 0d a8 01 13 80    	mov    0x801301a8,%ecx
80102246:	8b 15 a4 01 13 80    	mov    0x801301a4,%edx
8010224c:	a1 a0 01 13 80       	mov    0x801301a0,%eax
80102251:	ff 75 e4             	pushl  -0x1c(%ebp)
80102254:	57                   	push   %edi
80102255:	56                   	push   %esi
80102256:	53                   	push   %ebx
80102257:	51                   	push   %ecx
80102258:	52                   	push   %edx
80102259:	50                   	push   %eax
8010225a:	68 04 b3 10 80       	push   $0x8010b304
8010225f:	e8 b4 eb ff ff       	call   80100e18 <cprintf>
80102264:	83 c4 20             	add    $0x20,%esp
          inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80102267:	90                   	nop
80102268:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010226b:	5b                   	pop    %ebx
8010226c:	5e                   	pop    %esi
8010226d:	5f                   	pop    %edi
8010226e:	5d                   	pop    %ebp
8010226f:	c3                   	ret    

80102270 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80102270:	55                   	push   %ebp
80102271:	89 e5                	mov    %esp,%ebp
80102273:	83 ec 28             	sub    $0x28,%esp
80102276:	8b 45 0c             	mov    0xc(%ebp),%eax
80102279:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010227d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80102284:	e9 9e 00 00 00       	jmp    80102327 <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
80102289:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010228c:	c1 e8 03             	shr    $0x3,%eax
8010228f:	89 c2                	mov    %eax,%edx
80102291:	a1 b4 01 13 80       	mov    0x801301b4,%eax
80102296:	01 d0                	add    %edx,%eax
80102298:	83 ec 08             	sub    $0x8,%esp
8010229b:	50                   	push   %eax
8010229c:	ff 75 08             	pushl  0x8(%ebp)
8010229f:	e8 1f e9 ff ff       	call   80100bc3 <bread>
801022a4:	83 c4 10             	add    $0x10,%esp
801022a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801022aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022ad:	8d 50 18             	lea    0x18(%eax),%edx
801022b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022b3:	83 e0 07             	and    $0x7,%eax
801022b6:	c1 e0 06             	shl    $0x6,%eax
801022b9:	01 d0                	add    %edx,%eax
801022bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801022be:	8b 45 ec             	mov    -0x14(%ebp),%eax
801022c1:	0f b7 00             	movzwl (%eax),%eax
801022c4:	66 85 c0             	test   %ax,%ax
801022c7:	75 4c                	jne    80102315 <ialloc+0xa5>
      memset(dip, 0, sizeof(*dip));
801022c9:	83 ec 04             	sub    $0x4,%esp
801022cc:	6a 40                	push   $0x40
801022ce:	6a 00                	push   $0x0
801022d0:	ff 75 ec             	pushl  -0x14(%ebp)
801022d3:	e8 5b 45 00 00       	call   80106833 <memset>
801022d8:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801022db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801022de:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
801022e2:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801022e5:	83 ec 0c             	sub    $0xc,%esp
801022e8:	ff 75 f0             	pushl  -0x10(%ebp)
801022eb:	e8 f4 22 00 00       	call   801045e4 <log_write>
801022f0:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801022f3:	83 ec 0c             	sub    $0xc,%esp
801022f6:	ff 75 f0             	pushl  -0x10(%ebp)
801022f9:	e8 3d e9 ff ff       	call   80100c3b <brelse>
801022fe:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
80102301:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102304:	83 ec 08             	sub    $0x8,%esp
80102307:	50                   	push   %eax
80102308:	ff 75 08             	pushl  0x8(%ebp)
8010230b:	e8 f8 00 00 00       	call   80102408 <iget>
80102310:	83 c4 10             	add    $0x10,%esp
80102313:	eb 30                	jmp    80102345 <ialloc+0xd5>
    }
    brelse(bp);
80102315:	83 ec 0c             	sub    $0xc,%esp
80102318:	ff 75 f0             	pushl  -0x10(%ebp)
8010231b:	e8 1b e9 ff ff       	call   80100c3b <brelse>
80102320:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102323:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102327:	8b 15 a8 01 13 80    	mov    0x801301a8,%edx
8010232d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102330:	39 c2                	cmp    %eax,%edx
80102332:	0f 87 51 ff ff ff    	ja     80102289 <ialloc+0x19>
  }
  panic("ialloc: no inodes");
80102338:	83 ec 0c             	sub    $0xc,%esp
8010233b:	68 60 b3 10 80       	push   $0x8010b360
80102340:	e8 f9 ea ff ff       	call   80100e3e <panic>
}
80102345:	c9                   	leave  
80102346:	c3                   	ret    

80102347 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80102347:	55                   	push   %ebp
80102348:	89 e5                	mov    %esp,%ebp
8010234a:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010234d:	8b 45 08             	mov    0x8(%ebp),%eax
80102350:	8b 40 04             	mov    0x4(%eax),%eax
80102353:	c1 e8 03             	shr    $0x3,%eax
80102356:	89 c2                	mov    %eax,%edx
80102358:	a1 b4 01 13 80       	mov    0x801301b4,%eax
8010235d:	01 c2                	add    %eax,%edx
8010235f:	8b 45 08             	mov    0x8(%ebp),%eax
80102362:	8b 00                	mov    (%eax),%eax
80102364:	83 ec 08             	sub    $0x8,%esp
80102367:	52                   	push   %edx
80102368:	50                   	push   %eax
80102369:	e8 55 e8 ff ff       	call   80100bc3 <bread>
8010236e:	83 c4 10             	add    $0x10,%esp
80102371:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80102374:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102377:	8d 50 18             	lea    0x18(%eax),%edx
8010237a:	8b 45 08             	mov    0x8(%ebp),%eax
8010237d:	8b 40 04             	mov    0x4(%eax),%eax
80102380:	83 e0 07             	and    $0x7,%eax
80102383:	c1 e0 06             	shl    $0x6,%eax
80102386:	01 d0                	add    %edx,%eax
80102388:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
8010238b:	8b 45 08             	mov    0x8(%ebp),%eax
8010238e:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80102392:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102395:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80102398:	8b 45 08             	mov    0x8(%ebp),%eax
8010239b:	0f b7 50 12          	movzwl 0x12(%eax),%edx
8010239f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023a2:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801023a6:	8b 45 08             	mov    0x8(%ebp),%eax
801023a9:	0f b7 50 14          	movzwl 0x14(%eax),%edx
801023ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023b0:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801023b4:	8b 45 08             	mov    0x8(%ebp),%eax
801023b7:	0f b7 50 16          	movzwl 0x16(%eax),%edx
801023bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023be:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
801023c2:	8b 45 08             	mov    0x8(%ebp),%eax
801023c5:	8b 50 18             	mov    0x18(%eax),%edx
801023c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023cb:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801023ce:	8b 45 08             	mov    0x8(%ebp),%eax
801023d1:	8d 50 1c             	lea    0x1c(%eax),%edx
801023d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023d7:	83 c0 0c             	add    $0xc,%eax
801023da:	83 ec 04             	sub    $0x4,%esp
801023dd:	6a 34                	push   $0x34
801023df:	52                   	push   %edx
801023e0:	50                   	push   %eax
801023e1:	e8 0c 45 00 00       	call   801068f2 <memmove>
801023e6:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801023e9:	83 ec 0c             	sub    $0xc,%esp
801023ec:	ff 75 f4             	pushl  -0xc(%ebp)
801023ef:	e8 f0 21 00 00       	call   801045e4 <log_write>
801023f4:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801023f7:	83 ec 0c             	sub    $0xc,%esp
801023fa:	ff 75 f4             	pushl  -0xc(%ebp)
801023fd:	e8 39 e8 ff ff       	call   80100c3b <brelse>
80102402:	83 c4 10             	add    $0x10,%esp
}
80102405:	90                   	nop
80102406:	c9                   	leave  
80102407:	c3                   	ret    

80102408 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80102408:	55                   	push   %ebp
80102409:	89 e5                	mov    %esp,%ebp
8010240b:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010240e:	83 ec 0c             	sub    $0xc,%esp
80102411:	68 c0 01 13 80       	push   $0x801301c0
80102416:	e8 a2 41 00 00       	call   801065bd <acquire>
8010241b:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
8010241e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102425:	c7 45 f4 f4 01 13 80 	movl   $0x801301f4,-0xc(%ebp)
8010242c:	eb 5d                	jmp    8010248b <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010242e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102431:	8b 40 08             	mov    0x8(%eax),%eax
80102434:	85 c0                	test   %eax,%eax
80102436:	7e 39                	jle    80102471 <iget+0x69>
80102438:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010243b:	8b 00                	mov    (%eax),%eax
8010243d:	39 45 08             	cmp    %eax,0x8(%ebp)
80102440:	75 2f                	jne    80102471 <iget+0x69>
80102442:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102445:	8b 40 04             	mov    0x4(%eax),%eax
80102448:	39 45 0c             	cmp    %eax,0xc(%ebp)
8010244b:	75 24                	jne    80102471 <iget+0x69>
      ip->ref++;
8010244d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102450:	8b 40 08             	mov    0x8(%eax),%eax
80102453:	8d 50 01             	lea    0x1(%eax),%edx
80102456:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102459:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
8010245c:	83 ec 0c             	sub    $0xc,%esp
8010245f:	68 c0 01 13 80       	push   $0x801301c0
80102464:	e8 c0 41 00 00       	call   80106629 <release>
80102469:	83 c4 10             	add    $0x10,%esp
      return ip;
8010246c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010246f:	eb 74                	jmp    801024e5 <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102471:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102475:	75 10                	jne    80102487 <iget+0x7f>
80102477:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010247a:	8b 40 08             	mov    0x8(%eax),%eax
8010247d:	85 c0                	test   %eax,%eax
8010247f:	75 06                	jne    80102487 <iget+0x7f>
      empty = ip;
80102481:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102484:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102487:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
8010248b:	81 7d f4 94 11 13 80 	cmpl   $0x80131194,-0xc(%ebp)
80102492:	72 9a                	jb     8010242e <iget+0x26>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80102494:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102498:	75 0d                	jne    801024a7 <iget+0x9f>
    panic("iget: no inodes");
8010249a:	83 ec 0c             	sub    $0xc,%esp
8010249d:	68 72 b3 10 80       	push   $0x8010b372
801024a2:	e8 97 e9 ff ff       	call   80100e3e <panic>

  ip = empty;
801024a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801024aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
801024ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024b0:	8b 55 08             	mov    0x8(%ebp),%edx
801024b3:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
801024b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801024bb:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
801024be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024c1:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
801024c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024cb:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
801024d2:	83 ec 0c             	sub    $0xc,%esp
801024d5:	68 c0 01 13 80       	push   $0x801301c0
801024da:	e8 4a 41 00 00       	call   80106629 <release>
801024df:	83 c4 10             	add    $0x10,%esp

  return ip;
801024e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801024e5:	c9                   	leave  
801024e6:	c3                   	ret    

801024e7 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801024e7:	55                   	push   %ebp
801024e8:	89 e5                	mov    %esp,%ebp
801024ea:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
801024ed:	83 ec 0c             	sub    $0xc,%esp
801024f0:	68 c0 01 13 80       	push   $0x801301c0
801024f5:	e8 c3 40 00 00       	call   801065bd <acquire>
801024fa:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801024fd:	8b 45 08             	mov    0x8(%ebp),%eax
80102500:	8b 40 08             	mov    0x8(%eax),%eax
80102503:	8d 50 01             	lea    0x1(%eax),%edx
80102506:	8b 45 08             	mov    0x8(%ebp),%eax
80102509:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
8010250c:	83 ec 0c             	sub    $0xc,%esp
8010250f:	68 c0 01 13 80       	push   $0x801301c0
80102514:	e8 10 41 00 00       	call   80106629 <release>
80102519:	83 c4 10             	add    $0x10,%esp
  return ip;
8010251c:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010251f:	c9                   	leave  
80102520:	c3                   	ret    

80102521 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80102521:	55                   	push   %ebp
80102522:	89 e5                	mov    %esp,%ebp
80102524:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80102527:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010252b:	74 0a                	je     80102537 <ilock+0x16>
8010252d:	8b 45 08             	mov    0x8(%ebp),%eax
80102530:	8b 40 08             	mov    0x8(%eax),%eax
80102533:	85 c0                	test   %eax,%eax
80102535:	7f 0d                	jg     80102544 <ilock+0x23>
    panic("ilock");
80102537:	83 ec 0c             	sub    $0xc,%esp
8010253a:	68 82 b3 10 80       	push   $0x8010b382
8010253f:	e8 fa e8 ff ff       	call   80100e3e <panic>

  acquire(&icache.lock);
80102544:	83 ec 0c             	sub    $0xc,%esp
80102547:	68 c0 01 13 80       	push   $0x801301c0
8010254c:	e8 6c 40 00 00       	call   801065bd <acquire>
80102551:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
80102554:	eb 13                	jmp    80102569 <ilock+0x48>
    sleep(ip, &icache.lock);
80102556:	83 ec 08             	sub    $0x8,%esp
80102559:	68 c0 01 13 80       	push   $0x801301c0
8010255e:	ff 75 08             	pushl  0x8(%ebp)
80102561:	e8 55 3d 00 00       	call   801062bb <sleep>
80102566:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
80102569:	8b 45 08             	mov    0x8(%ebp),%eax
8010256c:	8b 40 0c             	mov    0xc(%eax),%eax
8010256f:	83 e0 01             	and    $0x1,%eax
80102572:	85 c0                	test   %eax,%eax
80102574:	75 e0                	jne    80102556 <ilock+0x35>
  ip->flags |= I_BUSY;
80102576:	8b 45 08             	mov    0x8(%ebp),%eax
80102579:	8b 40 0c             	mov    0xc(%eax),%eax
8010257c:	83 c8 01             	or     $0x1,%eax
8010257f:	89 c2                	mov    %eax,%edx
80102581:	8b 45 08             	mov    0x8(%ebp),%eax
80102584:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
80102587:	83 ec 0c             	sub    $0xc,%esp
8010258a:	68 c0 01 13 80       	push   $0x801301c0
8010258f:	e8 95 40 00 00       	call   80106629 <release>
80102594:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
80102597:	8b 45 08             	mov    0x8(%ebp),%eax
8010259a:	8b 40 0c             	mov    0xc(%eax),%eax
8010259d:	83 e0 02             	and    $0x2,%eax
801025a0:	85 c0                	test   %eax,%eax
801025a2:	0f 85 d4 00 00 00    	jne    8010267c <ilock+0x15b>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801025a8:	8b 45 08             	mov    0x8(%ebp),%eax
801025ab:	8b 40 04             	mov    0x4(%eax),%eax
801025ae:	c1 e8 03             	shr    $0x3,%eax
801025b1:	89 c2                	mov    %eax,%edx
801025b3:	a1 b4 01 13 80       	mov    0x801301b4,%eax
801025b8:	01 c2                	add    %eax,%edx
801025ba:	8b 45 08             	mov    0x8(%ebp),%eax
801025bd:	8b 00                	mov    (%eax),%eax
801025bf:	83 ec 08             	sub    $0x8,%esp
801025c2:	52                   	push   %edx
801025c3:	50                   	push   %eax
801025c4:	e8 fa e5 ff ff       	call   80100bc3 <bread>
801025c9:	83 c4 10             	add    $0x10,%esp
801025cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801025cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801025d2:	8d 50 18             	lea    0x18(%eax),%edx
801025d5:	8b 45 08             	mov    0x8(%ebp),%eax
801025d8:	8b 40 04             	mov    0x4(%eax),%eax
801025db:	83 e0 07             	and    $0x7,%eax
801025de:	c1 e0 06             	shl    $0x6,%eax
801025e1:	01 d0                	add    %edx,%eax
801025e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
801025e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801025e9:	0f b7 10             	movzwl (%eax),%edx
801025ec:	8b 45 08             	mov    0x8(%ebp),%eax
801025ef:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
801025f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801025f6:	0f b7 50 02          	movzwl 0x2(%eax),%edx
801025fa:	8b 45 08             	mov    0x8(%ebp),%eax
801025fd:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80102601:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102604:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80102608:	8b 45 08             	mov    0x8(%ebp),%eax
8010260b:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
8010260f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102612:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80102616:	8b 45 08             	mov    0x8(%ebp),%eax
80102619:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
8010261d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102620:	8b 50 08             	mov    0x8(%eax),%edx
80102623:	8b 45 08             	mov    0x8(%ebp),%eax
80102626:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102629:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010262c:	8d 50 0c             	lea    0xc(%eax),%edx
8010262f:	8b 45 08             	mov    0x8(%ebp),%eax
80102632:	83 c0 1c             	add    $0x1c,%eax
80102635:	83 ec 04             	sub    $0x4,%esp
80102638:	6a 34                	push   $0x34
8010263a:	52                   	push   %edx
8010263b:	50                   	push   %eax
8010263c:	e8 b1 42 00 00       	call   801068f2 <memmove>
80102641:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102644:	83 ec 0c             	sub    $0xc,%esp
80102647:	ff 75 f4             	pushl  -0xc(%ebp)
8010264a:	e8 ec e5 ff ff       	call   80100c3b <brelse>
8010264f:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80102652:	8b 45 08             	mov    0x8(%ebp),%eax
80102655:	8b 40 0c             	mov    0xc(%eax),%eax
80102658:	83 c8 02             	or     $0x2,%eax
8010265b:	89 c2                	mov    %eax,%edx
8010265d:	8b 45 08             	mov    0x8(%ebp),%eax
80102660:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80102663:	8b 45 08             	mov    0x8(%ebp),%eax
80102666:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010266a:	66 85 c0             	test   %ax,%ax
8010266d:	75 0d                	jne    8010267c <ilock+0x15b>
      panic("ilock: no type");
8010266f:	83 ec 0c             	sub    $0xc,%esp
80102672:	68 88 b3 10 80       	push   $0x8010b388
80102677:	e8 c2 e7 ff ff       	call   80100e3e <panic>
  }
}
8010267c:	90                   	nop
8010267d:	c9                   	leave  
8010267e:	c3                   	ret    

8010267f <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
8010267f:	55                   	push   %ebp
80102680:	89 e5                	mov    %esp,%ebp
80102682:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80102685:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102689:	74 17                	je     801026a2 <iunlock+0x23>
8010268b:	8b 45 08             	mov    0x8(%ebp),%eax
8010268e:	8b 40 0c             	mov    0xc(%eax),%eax
80102691:	83 e0 01             	and    $0x1,%eax
80102694:	85 c0                	test   %eax,%eax
80102696:	74 0a                	je     801026a2 <iunlock+0x23>
80102698:	8b 45 08             	mov    0x8(%ebp),%eax
8010269b:	8b 40 08             	mov    0x8(%eax),%eax
8010269e:	85 c0                	test   %eax,%eax
801026a0:	7f 0d                	jg     801026af <iunlock+0x30>
    panic("iunlock");
801026a2:	83 ec 0c             	sub    $0xc,%esp
801026a5:	68 97 b3 10 80       	push   $0x8010b397
801026aa:	e8 8f e7 ff ff       	call   80100e3e <panic>

  acquire(&icache.lock);
801026af:	83 ec 0c             	sub    $0xc,%esp
801026b2:	68 c0 01 13 80       	push   $0x801301c0
801026b7:	e8 01 3f 00 00       	call   801065bd <acquire>
801026bc:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
801026bf:	8b 45 08             	mov    0x8(%ebp),%eax
801026c2:	8b 40 0c             	mov    0xc(%eax),%eax
801026c5:	83 e0 fe             	and    $0xfffffffe,%eax
801026c8:	89 c2                	mov    %eax,%edx
801026ca:	8b 45 08             	mov    0x8(%ebp),%eax
801026cd:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
801026d0:	83 ec 0c             	sub    $0xc,%esp
801026d3:	ff 75 08             	pushl  0x8(%ebp)
801026d6:	e8 ce 3c 00 00       	call   801063a9 <wakeup>
801026db:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
801026de:	83 ec 0c             	sub    $0xc,%esp
801026e1:	68 c0 01 13 80       	push   $0x801301c0
801026e6:	e8 3e 3f 00 00       	call   80106629 <release>
801026eb:	83 c4 10             	add    $0x10,%esp
}
801026ee:	90                   	nop
801026ef:	c9                   	leave  
801026f0:	c3                   	ret    

801026f1 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801026f1:	55                   	push   %ebp
801026f2:	89 e5                	mov    %esp,%ebp
801026f4:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
801026f7:	83 ec 0c             	sub    $0xc,%esp
801026fa:	68 c0 01 13 80       	push   $0x801301c0
801026ff:	e8 b9 3e 00 00       	call   801065bd <acquire>
80102704:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80102707:	8b 45 08             	mov    0x8(%ebp),%eax
8010270a:	8b 40 08             	mov    0x8(%eax),%eax
8010270d:	83 f8 01             	cmp    $0x1,%eax
80102710:	0f 85 a9 00 00 00    	jne    801027bf <iput+0xce>
80102716:	8b 45 08             	mov    0x8(%ebp),%eax
80102719:	8b 40 0c             	mov    0xc(%eax),%eax
8010271c:	83 e0 02             	and    $0x2,%eax
8010271f:	85 c0                	test   %eax,%eax
80102721:	0f 84 98 00 00 00    	je     801027bf <iput+0xce>
80102727:	8b 45 08             	mov    0x8(%ebp),%eax
8010272a:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010272e:	66 85 c0             	test   %ax,%ax
80102731:	0f 85 88 00 00 00    	jne    801027bf <iput+0xce>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80102737:	8b 45 08             	mov    0x8(%ebp),%eax
8010273a:	8b 40 0c             	mov    0xc(%eax),%eax
8010273d:	83 e0 01             	and    $0x1,%eax
80102740:	85 c0                	test   %eax,%eax
80102742:	74 0d                	je     80102751 <iput+0x60>
      panic("iput busy");
80102744:	83 ec 0c             	sub    $0xc,%esp
80102747:	68 9f b3 10 80       	push   $0x8010b39f
8010274c:	e8 ed e6 ff ff       	call   80100e3e <panic>
    ip->flags |= I_BUSY;
80102751:	8b 45 08             	mov    0x8(%ebp),%eax
80102754:	8b 40 0c             	mov    0xc(%eax),%eax
80102757:	83 c8 01             	or     $0x1,%eax
8010275a:	89 c2                	mov    %eax,%edx
8010275c:	8b 45 08             	mov    0x8(%ebp),%eax
8010275f:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80102762:	83 ec 0c             	sub    $0xc,%esp
80102765:	68 c0 01 13 80       	push   $0x801301c0
8010276a:	e8 ba 3e 00 00       	call   80106629 <release>
8010276f:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80102772:	83 ec 0c             	sub    $0xc,%esp
80102775:	ff 75 08             	pushl  0x8(%ebp)
80102778:	e8 a3 01 00 00       	call   80102920 <itrunc>
8010277d:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80102780:	8b 45 08             	mov    0x8(%ebp),%eax
80102783:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80102789:	83 ec 0c             	sub    $0xc,%esp
8010278c:	ff 75 08             	pushl  0x8(%ebp)
8010278f:	e8 b3 fb ff ff       	call   80102347 <iupdate>
80102794:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80102797:	83 ec 0c             	sub    $0xc,%esp
8010279a:	68 c0 01 13 80       	push   $0x801301c0
8010279f:	e8 19 3e 00 00       	call   801065bd <acquire>
801027a4:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
801027a7:	8b 45 08             	mov    0x8(%ebp),%eax
801027aa:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
801027b1:	83 ec 0c             	sub    $0xc,%esp
801027b4:	ff 75 08             	pushl  0x8(%ebp)
801027b7:	e8 ed 3b 00 00       	call   801063a9 <wakeup>
801027bc:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
801027bf:	8b 45 08             	mov    0x8(%ebp),%eax
801027c2:	8b 40 08             	mov    0x8(%eax),%eax
801027c5:	8d 50 ff             	lea    -0x1(%eax),%edx
801027c8:	8b 45 08             	mov    0x8(%ebp),%eax
801027cb:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
801027ce:	83 ec 0c             	sub    $0xc,%esp
801027d1:	68 c0 01 13 80       	push   $0x801301c0
801027d6:	e8 4e 3e 00 00       	call   80106629 <release>
801027db:	83 c4 10             	add    $0x10,%esp
}
801027de:	90                   	nop
801027df:	c9                   	leave  
801027e0:	c3                   	ret    

801027e1 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801027e1:	55                   	push   %ebp
801027e2:	89 e5                	mov    %esp,%ebp
801027e4:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
801027e7:	83 ec 0c             	sub    $0xc,%esp
801027ea:	ff 75 08             	pushl  0x8(%ebp)
801027ed:	e8 8d fe ff ff       	call   8010267f <iunlock>
801027f2:	83 c4 10             	add    $0x10,%esp
  iput(ip);
801027f5:	83 ec 0c             	sub    $0xc,%esp
801027f8:	ff 75 08             	pushl  0x8(%ebp)
801027fb:	e8 f1 fe ff ff       	call   801026f1 <iput>
80102800:	83 c4 10             	add    $0x10,%esp
}
80102803:	90                   	nop
80102804:	c9                   	leave  
80102805:	c3                   	ret    

80102806 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102806:	55                   	push   %ebp
80102807:	89 e5                	mov    %esp,%ebp
80102809:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010280c:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80102810:	77 42                	ja     80102854 <bmap+0x4e>
    if((addr = ip->addrs[bn]) == 0)
80102812:	8b 45 08             	mov    0x8(%ebp),%eax
80102815:	8b 55 0c             	mov    0xc(%ebp),%edx
80102818:	83 c2 04             	add    $0x4,%edx
8010281b:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
8010281f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102822:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102826:	75 24                	jne    8010284c <bmap+0x46>
      ip->addrs[bn] = addr = balloc(ip->dev);
80102828:	8b 45 08             	mov    0x8(%ebp),%eax
8010282b:	8b 00                	mov    (%eax),%eax
8010282d:	83 ec 0c             	sub    $0xc,%esp
80102830:	50                   	push   %eax
80102831:	e8 9b f7 ff ff       	call   80101fd1 <balloc>
80102836:	83 c4 10             	add    $0x10,%esp
80102839:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010283c:	8b 45 08             	mov    0x8(%ebp),%eax
8010283f:	8b 55 0c             	mov    0xc(%ebp),%edx
80102842:	8d 4a 04             	lea    0x4(%edx),%ecx
80102845:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102848:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
8010284c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010284f:	e9 ca 00 00 00       	jmp    8010291e <bmap+0x118>
  }
  bn -= NDIRECT;
80102854:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80102858:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
8010285c:	0f 87 af 00 00 00    	ja     80102911 <bmap+0x10b>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80102862:	8b 45 08             	mov    0x8(%ebp),%eax
80102865:	8b 40 4c             	mov    0x4c(%eax),%eax
80102868:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010286b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010286f:	75 1d                	jne    8010288e <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80102871:	8b 45 08             	mov    0x8(%ebp),%eax
80102874:	8b 00                	mov    (%eax),%eax
80102876:	83 ec 0c             	sub    $0xc,%esp
80102879:	50                   	push   %eax
8010287a:	e8 52 f7 ff ff       	call   80101fd1 <balloc>
8010287f:	83 c4 10             	add    $0x10,%esp
80102882:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102885:	8b 45 08             	mov    0x8(%ebp),%eax
80102888:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010288b:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
8010288e:	8b 45 08             	mov    0x8(%ebp),%eax
80102891:	8b 00                	mov    (%eax),%eax
80102893:	83 ec 08             	sub    $0x8,%esp
80102896:	ff 75 f4             	pushl  -0xc(%ebp)
80102899:	50                   	push   %eax
8010289a:	e8 24 e3 ff ff       	call   80100bc3 <bread>
8010289f:	83 c4 10             	add    $0x10,%esp
801028a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
801028a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801028a8:	83 c0 18             	add    $0x18,%eax
801028ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
801028ae:	8b 45 0c             	mov    0xc(%ebp),%eax
801028b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801028b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801028bb:	01 d0                	add    %edx,%eax
801028bd:	8b 00                	mov    (%eax),%eax
801028bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801028c6:	75 36                	jne    801028fe <bmap+0xf8>
      a[bn] = addr = balloc(ip->dev);
801028c8:	8b 45 08             	mov    0x8(%ebp),%eax
801028cb:	8b 00                	mov    (%eax),%eax
801028cd:	83 ec 0c             	sub    $0xc,%esp
801028d0:	50                   	push   %eax
801028d1:	e8 fb f6 ff ff       	call   80101fd1 <balloc>
801028d6:	83 c4 10             	add    $0x10,%esp
801028d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801028df:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801028e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801028e9:	01 c2                	add    %eax,%edx
801028eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028ee:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801028f0:	83 ec 0c             	sub    $0xc,%esp
801028f3:	ff 75 f0             	pushl  -0x10(%ebp)
801028f6:	e8 e9 1c 00 00       	call   801045e4 <log_write>
801028fb:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
801028fe:	83 ec 0c             	sub    $0xc,%esp
80102901:	ff 75 f0             	pushl  -0x10(%ebp)
80102904:	e8 32 e3 ff ff       	call   80100c3b <brelse>
80102909:	83 c4 10             	add    $0x10,%esp
    return addr;
8010290c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010290f:	eb 0d                	jmp    8010291e <bmap+0x118>
  }

  panic("bmap: out of range");
80102911:	83 ec 0c             	sub    $0xc,%esp
80102914:	68 a9 b3 10 80       	push   $0x8010b3a9
80102919:	e8 20 e5 ff ff       	call   80100e3e <panic>
}
8010291e:	c9                   	leave  
8010291f:	c3                   	ret    

80102920 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80102920:	55                   	push   %ebp
80102921:	89 e5                	mov    %esp,%ebp
80102923:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102926:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010292d:	eb 45                	jmp    80102974 <itrunc+0x54>
    if(ip->addrs[i]){
8010292f:	8b 45 08             	mov    0x8(%ebp),%eax
80102932:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102935:	83 c2 04             	add    $0x4,%edx
80102938:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
8010293c:	85 c0                	test   %eax,%eax
8010293e:	74 30                	je     80102970 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80102940:	8b 45 08             	mov    0x8(%ebp),%eax
80102943:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102946:	83 c2 04             	add    $0x4,%edx
80102949:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
8010294d:	8b 55 08             	mov    0x8(%ebp),%edx
80102950:	8b 12                	mov    (%edx),%edx
80102952:	83 ec 08             	sub    $0x8,%esp
80102955:	50                   	push   %eax
80102956:	52                   	push   %edx
80102957:	e8 c1 f7 ff ff       	call   8010211d <bfree>
8010295c:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
8010295f:	8b 45 08             	mov    0x8(%ebp),%eax
80102962:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102965:	83 c2 04             	add    $0x4,%edx
80102968:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
8010296f:	00 
  for(i = 0; i < NDIRECT; i++){
80102970:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102974:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80102978:	7e b5                	jle    8010292f <itrunc+0xf>
    }
  }

  if(ip->addrs[NDIRECT]){
8010297a:	8b 45 08             	mov    0x8(%ebp),%eax
8010297d:	8b 40 4c             	mov    0x4c(%eax),%eax
80102980:	85 c0                	test   %eax,%eax
80102982:	0f 84 a1 00 00 00    	je     80102a29 <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80102988:	8b 45 08             	mov    0x8(%ebp),%eax
8010298b:	8b 50 4c             	mov    0x4c(%eax),%edx
8010298e:	8b 45 08             	mov    0x8(%ebp),%eax
80102991:	8b 00                	mov    (%eax),%eax
80102993:	83 ec 08             	sub    $0x8,%esp
80102996:	52                   	push   %edx
80102997:	50                   	push   %eax
80102998:	e8 26 e2 ff ff       	call   80100bc3 <bread>
8010299d:	83 c4 10             	add    $0x10,%esp
801029a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
801029a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801029a6:	83 c0 18             	add    $0x18,%eax
801029a9:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801029ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801029b3:	eb 3c                	jmp    801029f1 <itrunc+0xd1>
      if(a[j])
801029b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801029b8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801029bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
801029c2:	01 d0                	add    %edx,%eax
801029c4:	8b 00                	mov    (%eax),%eax
801029c6:	85 c0                	test   %eax,%eax
801029c8:	74 23                	je     801029ed <itrunc+0xcd>
        bfree(ip->dev, a[j]);
801029ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
801029cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801029d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
801029d7:	01 d0                	add    %edx,%eax
801029d9:	8b 00                	mov    (%eax),%eax
801029db:	8b 55 08             	mov    0x8(%ebp),%edx
801029de:	8b 12                	mov    (%edx),%edx
801029e0:	83 ec 08             	sub    $0x8,%esp
801029e3:	50                   	push   %eax
801029e4:	52                   	push   %edx
801029e5:	e8 33 f7 ff ff       	call   8010211d <bfree>
801029ea:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
801029ed:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801029f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801029f4:	83 f8 7f             	cmp    $0x7f,%eax
801029f7:	76 bc                	jbe    801029b5 <itrunc+0x95>
    }
    brelse(bp);
801029f9:	83 ec 0c             	sub    $0xc,%esp
801029fc:	ff 75 ec             	pushl  -0x14(%ebp)
801029ff:	e8 37 e2 ff ff       	call   80100c3b <brelse>
80102a04:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102a07:	8b 45 08             	mov    0x8(%ebp),%eax
80102a0a:	8b 40 4c             	mov    0x4c(%eax),%eax
80102a0d:	8b 55 08             	mov    0x8(%ebp),%edx
80102a10:	8b 12                	mov    (%edx),%edx
80102a12:	83 ec 08             	sub    $0x8,%esp
80102a15:	50                   	push   %eax
80102a16:	52                   	push   %edx
80102a17:	e8 01 f7 ff ff       	call   8010211d <bfree>
80102a1c:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80102a1f:	8b 45 08             	mov    0x8(%ebp),%eax
80102a22:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80102a29:	8b 45 08             	mov    0x8(%ebp),%eax
80102a2c:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80102a33:	83 ec 0c             	sub    $0xc,%esp
80102a36:	ff 75 08             	pushl  0x8(%ebp)
80102a39:	e8 09 f9 ff ff       	call   80102347 <iupdate>
80102a3e:	83 c4 10             	add    $0x10,%esp
}
80102a41:	90                   	nop
80102a42:	c9                   	leave  
80102a43:	c3                   	ret    

80102a44 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80102a44:	55                   	push   %ebp
80102a45:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80102a47:	8b 45 08             	mov    0x8(%ebp),%eax
80102a4a:	8b 00                	mov    (%eax),%eax
80102a4c:	89 c2                	mov    %eax,%edx
80102a4e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a51:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80102a54:	8b 45 08             	mov    0x8(%ebp),%eax
80102a57:	8b 50 04             	mov    0x4(%eax),%edx
80102a5a:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a5d:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80102a60:	8b 45 08             	mov    0x8(%ebp),%eax
80102a63:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80102a67:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a6a:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80102a6d:	8b 45 08             	mov    0x8(%ebp),%eax
80102a70:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80102a74:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a77:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80102a7b:	8b 45 08             	mov    0x8(%ebp),%eax
80102a7e:	8b 50 18             	mov    0x18(%eax),%edx
80102a81:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a84:	89 50 10             	mov    %edx,0x10(%eax)
}
80102a87:	90                   	nop
80102a88:	5d                   	pop    %ebp
80102a89:	c3                   	ret    

80102a8a <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102a8a:	55                   	push   %ebp
80102a8b:	89 e5                	mov    %esp,%ebp
80102a8d:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102a90:	8b 45 08             	mov    0x8(%ebp),%eax
80102a93:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102a97:	66 83 f8 03          	cmp    $0x3,%ax
80102a9b:	75 74                	jne    80102b11 <readi+0x87>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102a9d:	8b 45 08             	mov    0x8(%ebp),%eax
80102aa0:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102aa4:	66 85 c0             	test   %ax,%ax
80102aa7:	78 2c                	js     80102ad5 <readi+0x4b>
80102aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80102aac:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102ab0:	66 83 f8 09          	cmp    $0x9,%ax
80102ab4:	7f 1f                	jg     80102ad5 <readi+0x4b>
80102ab6:	8b 45 08             	mov    0x8(%ebp),%eax
80102ab9:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102abd:	0f bf d0             	movswl %ax,%edx
80102ac0:	89 d0                	mov    %edx,%eax
80102ac2:	c1 e0 03             	shl    $0x3,%eax
80102ac5:	01 d0                	add    %edx,%eax
80102ac7:	c1 e0 05             	shl    $0x5,%eax
80102aca:	05 60 f6 12 80       	add    $0x8012f660,%eax
80102acf:	8b 00                	mov    (%eax),%eax
80102ad1:	85 c0                	test   %eax,%eax
80102ad3:	75 0a                	jne    80102adf <readi+0x55>
      return -1;
80102ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ada:	e9 18 01 00 00       	jmp    80102bf7 <readi+0x16d>
    return devsw[ip->major].read(ip, dst, n);
80102adf:	8b 45 08             	mov    0x8(%ebp),%eax
80102ae2:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102ae6:	0f bf d0             	movswl %ax,%edx
80102ae9:	89 d0                	mov    %edx,%eax
80102aeb:	c1 e0 03             	shl    $0x3,%eax
80102aee:	01 d0                	add    %edx,%eax
80102af0:	c1 e0 05             	shl    $0x5,%eax
80102af3:	05 60 f6 12 80       	add    $0x8012f660,%eax
80102af8:	8b 00                	mov    (%eax),%eax
80102afa:	8b 55 14             	mov    0x14(%ebp),%edx
80102afd:	83 ec 04             	sub    $0x4,%esp
80102b00:	52                   	push   %edx
80102b01:	ff 75 0c             	pushl  0xc(%ebp)
80102b04:	ff 75 08             	pushl  0x8(%ebp)
80102b07:	ff d0                	call   *%eax
80102b09:	83 c4 10             	add    $0x10,%esp
80102b0c:	e9 e6 00 00 00       	jmp    80102bf7 <readi+0x16d>
  }

  if(off > ip->size || off + n < off)
80102b11:	8b 45 08             	mov    0x8(%ebp),%eax
80102b14:	8b 40 18             	mov    0x18(%eax),%eax
80102b17:	39 45 10             	cmp    %eax,0x10(%ebp)
80102b1a:	77 0d                	ja     80102b29 <readi+0x9f>
80102b1c:	8b 55 10             	mov    0x10(%ebp),%edx
80102b1f:	8b 45 14             	mov    0x14(%ebp),%eax
80102b22:	01 d0                	add    %edx,%eax
80102b24:	39 45 10             	cmp    %eax,0x10(%ebp)
80102b27:	76 0a                	jbe    80102b33 <readi+0xa9>
    return -1;
80102b29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102b2e:	e9 c4 00 00 00       	jmp    80102bf7 <readi+0x16d>
  if(off + n > ip->size)
80102b33:	8b 55 10             	mov    0x10(%ebp),%edx
80102b36:	8b 45 14             	mov    0x14(%ebp),%eax
80102b39:	01 c2                	add    %eax,%edx
80102b3b:	8b 45 08             	mov    0x8(%ebp),%eax
80102b3e:	8b 40 18             	mov    0x18(%eax),%eax
80102b41:	39 c2                	cmp    %eax,%edx
80102b43:	76 0c                	jbe    80102b51 <readi+0xc7>
    n = ip->size - off;
80102b45:	8b 45 08             	mov    0x8(%ebp),%eax
80102b48:	8b 40 18             	mov    0x18(%eax),%eax
80102b4b:	2b 45 10             	sub    0x10(%ebp),%eax
80102b4e:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102b51:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102b58:	e9 8b 00 00 00       	jmp    80102be8 <readi+0x15e>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102b5d:	8b 45 10             	mov    0x10(%ebp),%eax
80102b60:	c1 e8 09             	shr    $0x9,%eax
80102b63:	83 ec 08             	sub    $0x8,%esp
80102b66:	50                   	push   %eax
80102b67:	ff 75 08             	pushl  0x8(%ebp)
80102b6a:	e8 97 fc ff ff       	call   80102806 <bmap>
80102b6f:	83 c4 10             	add    $0x10,%esp
80102b72:	89 c2                	mov    %eax,%edx
80102b74:	8b 45 08             	mov    0x8(%ebp),%eax
80102b77:	8b 00                	mov    (%eax),%eax
80102b79:	83 ec 08             	sub    $0x8,%esp
80102b7c:	52                   	push   %edx
80102b7d:	50                   	push   %eax
80102b7e:	e8 40 e0 ff ff       	call   80100bc3 <bread>
80102b83:	83 c4 10             	add    $0x10,%esp
80102b86:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102b89:	8b 45 10             	mov    0x10(%ebp),%eax
80102b8c:	25 ff 01 00 00       	and    $0x1ff,%eax
80102b91:	ba 00 02 00 00       	mov    $0x200,%edx
80102b96:	29 c2                	sub    %eax,%edx
80102b98:	8b 45 14             	mov    0x14(%ebp),%eax
80102b9b:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102b9e:	39 c2                	cmp    %eax,%edx
80102ba0:	0f 46 c2             	cmovbe %edx,%eax
80102ba3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80102ba6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102ba9:	8d 50 18             	lea    0x18(%eax),%edx
80102bac:	8b 45 10             	mov    0x10(%ebp),%eax
80102baf:	25 ff 01 00 00       	and    $0x1ff,%eax
80102bb4:	01 d0                	add    %edx,%eax
80102bb6:	83 ec 04             	sub    $0x4,%esp
80102bb9:	ff 75 ec             	pushl  -0x14(%ebp)
80102bbc:	50                   	push   %eax
80102bbd:	ff 75 0c             	pushl  0xc(%ebp)
80102bc0:	e8 2d 3d 00 00       	call   801068f2 <memmove>
80102bc5:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102bc8:	83 ec 0c             	sub    $0xc,%esp
80102bcb:	ff 75 f0             	pushl  -0x10(%ebp)
80102bce:	e8 68 e0 ff ff       	call   80100c3b <brelse>
80102bd3:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102bd6:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102bd9:	01 45 f4             	add    %eax,-0xc(%ebp)
80102bdc:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102bdf:	01 45 10             	add    %eax,0x10(%ebp)
80102be2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102be5:	01 45 0c             	add    %eax,0xc(%ebp)
80102be8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102beb:	3b 45 14             	cmp    0x14(%ebp),%eax
80102bee:	0f 82 69 ff ff ff    	jb     80102b5d <readi+0xd3>
  }
  return n;
80102bf4:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102bf7:	c9                   	leave  
80102bf8:	c3                   	ret    

80102bf9 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102bf9:	55                   	push   %ebp
80102bfa:	89 e5                	mov    %esp,%ebp
80102bfc:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102bff:	8b 45 08             	mov    0x8(%ebp),%eax
80102c02:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102c06:	66 83 f8 03          	cmp    $0x3,%ax
80102c0a:	75 74                	jne    80102c80 <writei+0x87>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102c0c:	8b 45 08             	mov    0x8(%ebp),%eax
80102c0f:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102c13:	66 85 c0             	test   %ax,%ax
80102c16:	78 2c                	js     80102c44 <writei+0x4b>
80102c18:	8b 45 08             	mov    0x8(%ebp),%eax
80102c1b:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102c1f:	66 83 f8 09          	cmp    $0x9,%ax
80102c23:	7f 1f                	jg     80102c44 <writei+0x4b>
80102c25:	8b 45 08             	mov    0x8(%ebp),%eax
80102c28:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102c2c:	0f bf d0             	movswl %ax,%edx
80102c2f:	89 d0                	mov    %edx,%eax
80102c31:	c1 e0 03             	shl    $0x3,%eax
80102c34:	01 d0                	add    %edx,%eax
80102c36:	c1 e0 05             	shl    $0x5,%eax
80102c39:	05 64 f6 12 80       	add    $0x8012f664,%eax
80102c3e:	8b 00                	mov    (%eax),%eax
80102c40:	85 c0                	test   %eax,%eax
80102c42:	75 0a                	jne    80102c4e <writei+0x55>
      return -1;
80102c44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c49:	e9 49 01 00 00       	jmp    80102d97 <writei+0x19e>
    return devsw[ip->major].write(ip, src, n);
80102c4e:	8b 45 08             	mov    0x8(%ebp),%eax
80102c51:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102c55:	0f bf d0             	movswl %ax,%edx
80102c58:	89 d0                	mov    %edx,%eax
80102c5a:	c1 e0 03             	shl    $0x3,%eax
80102c5d:	01 d0                	add    %edx,%eax
80102c5f:	c1 e0 05             	shl    $0x5,%eax
80102c62:	05 64 f6 12 80       	add    $0x8012f664,%eax
80102c67:	8b 00                	mov    (%eax),%eax
80102c69:	8b 55 14             	mov    0x14(%ebp),%edx
80102c6c:	83 ec 04             	sub    $0x4,%esp
80102c6f:	52                   	push   %edx
80102c70:	ff 75 0c             	pushl  0xc(%ebp)
80102c73:	ff 75 08             	pushl  0x8(%ebp)
80102c76:	ff d0                	call   *%eax
80102c78:	83 c4 10             	add    $0x10,%esp
80102c7b:	e9 17 01 00 00       	jmp    80102d97 <writei+0x19e>
  }

  if(off > ip->size || off + n < off)
80102c80:	8b 45 08             	mov    0x8(%ebp),%eax
80102c83:	8b 40 18             	mov    0x18(%eax),%eax
80102c86:	39 45 10             	cmp    %eax,0x10(%ebp)
80102c89:	77 0d                	ja     80102c98 <writei+0x9f>
80102c8b:	8b 55 10             	mov    0x10(%ebp),%edx
80102c8e:	8b 45 14             	mov    0x14(%ebp),%eax
80102c91:	01 d0                	add    %edx,%eax
80102c93:	39 45 10             	cmp    %eax,0x10(%ebp)
80102c96:	76 0a                	jbe    80102ca2 <writei+0xa9>
    return -1;
80102c98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c9d:	e9 f5 00 00 00       	jmp    80102d97 <writei+0x19e>
  if(off + n > MAXFILE*BSIZE)
80102ca2:	8b 55 10             	mov    0x10(%ebp),%edx
80102ca5:	8b 45 14             	mov    0x14(%ebp),%eax
80102ca8:	01 d0                	add    %edx,%eax
80102caa:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102caf:	76 0a                	jbe    80102cbb <writei+0xc2>
    return -1;
80102cb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102cb6:	e9 dc 00 00 00       	jmp    80102d97 <writei+0x19e>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102cbb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102cc2:	e9 99 00 00 00       	jmp    80102d60 <writei+0x167>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102cc7:	8b 45 10             	mov    0x10(%ebp),%eax
80102cca:	c1 e8 09             	shr    $0x9,%eax
80102ccd:	83 ec 08             	sub    $0x8,%esp
80102cd0:	50                   	push   %eax
80102cd1:	ff 75 08             	pushl  0x8(%ebp)
80102cd4:	e8 2d fb ff ff       	call   80102806 <bmap>
80102cd9:	83 c4 10             	add    $0x10,%esp
80102cdc:	89 c2                	mov    %eax,%edx
80102cde:	8b 45 08             	mov    0x8(%ebp),%eax
80102ce1:	8b 00                	mov    (%eax),%eax
80102ce3:	83 ec 08             	sub    $0x8,%esp
80102ce6:	52                   	push   %edx
80102ce7:	50                   	push   %eax
80102ce8:	e8 d6 de ff ff       	call   80100bc3 <bread>
80102ced:	83 c4 10             	add    $0x10,%esp
80102cf0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102cf3:	8b 45 10             	mov    0x10(%ebp),%eax
80102cf6:	25 ff 01 00 00       	and    $0x1ff,%eax
80102cfb:	ba 00 02 00 00       	mov    $0x200,%edx
80102d00:	29 c2                	sub    %eax,%edx
80102d02:	8b 45 14             	mov    0x14(%ebp),%eax
80102d05:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102d08:	39 c2                	cmp    %eax,%edx
80102d0a:	0f 46 c2             	cmovbe %edx,%eax
80102d0d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80102d10:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102d13:	8d 50 18             	lea    0x18(%eax),%edx
80102d16:	8b 45 10             	mov    0x10(%ebp),%eax
80102d19:	25 ff 01 00 00       	and    $0x1ff,%eax
80102d1e:	01 d0                	add    %edx,%eax
80102d20:	83 ec 04             	sub    $0x4,%esp
80102d23:	ff 75 ec             	pushl  -0x14(%ebp)
80102d26:	ff 75 0c             	pushl  0xc(%ebp)
80102d29:	50                   	push   %eax
80102d2a:	e8 c3 3b 00 00       	call   801068f2 <memmove>
80102d2f:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102d32:	83 ec 0c             	sub    $0xc,%esp
80102d35:	ff 75 f0             	pushl  -0x10(%ebp)
80102d38:	e8 a7 18 00 00       	call   801045e4 <log_write>
80102d3d:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102d40:	83 ec 0c             	sub    $0xc,%esp
80102d43:	ff 75 f0             	pushl  -0x10(%ebp)
80102d46:	e8 f0 de ff ff       	call   80100c3b <brelse>
80102d4b:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102d4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102d51:	01 45 f4             	add    %eax,-0xc(%ebp)
80102d54:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102d57:	01 45 10             	add    %eax,0x10(%ebp)
80102d5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102d5d:	01 45 0c             	add    %eax,0xc(%ebp)
80102d60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d63:	3b 45 14             	cmp    0x14(%ebp),%eax
80102d66:	0f 82 5b ff ff ff    	jb     80102cc7 <writei+0xce>
  }

  if(n > 0 && off > ip->size){
80102d6c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102d70:	74 22                	je     80102d94 <writei+0x19b>
80102d72:	8b 45 08             	mov    0x8(%ebp),%eax
80102d75:	8b 40 18             	mov    0x18(%eax),%eax
80102d78:	39 45 10             	cmp    %eax,0x10(%ebp)
80102d7b:	76 17                	jbe    80102d94 <writei+0x19b>
    ip->size = off;
80102d7d:	8b 45 08             	mov    0x8(%ebp),%eax
80102d80:	8b 55 10             	mov    0x10(%ebp),%edx
80102d83:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102d86:	83 ec 0c             	sub    $0xc,%esp
80102d89:	ff 75 08             	pushl  0x8(%ebp)
80102d8c:	e8 b6 f5 ff ff       	call   80102347 <iupdate>
80102d91:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102d94:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102d97:	c9                   	leave  
80102d98:	c3                   	ret    

80102d99 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102d99:	55                   	push   %ebp
80102d9a:	89 e5                	mov    %esp,%ebp
80102d9c:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
80102d9f:	83 ec 04             	sub    $0x4,%esp
80102da2:	6a 0e                	push   $0xe
80102da4:	ff 75 0c             	pushl  0xc(%ebp)
80102da7:	ff 75 08             	pushl  0x8(%ebp)
80102daa:	e8 d9 3b 00 00       	call   80106988 <strncmp>
80102daf:	83 c4 10             	add    $0x10,%esp
}
80102db2:	c9                   	leave  
80102db3:	c3                   	ret    

80102db4 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102db4:	55                   	push   %ebp
80102db5:	89 e5                	mov    %esp,%ebp
80102db7:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102dba:	8b 45 08             	mov    0x8(%ebp),%eax
80102dbd:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102dc1:	66 83 f8 01          	cmp    $0x1,%ax
80102dc5:	74 0d                	je     80102dd4 <dirlookup+0x20>
    panic("dirlookup not DIR");
80102dc7:	83 ec 0c             	sub    $0xc,%esp
80102dca:	68 bc b3 10 80       	push   $0x8010b3bc
80102dcf:	e8 6a e0 ff ff       	call   80100e3e <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102dd4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102ddb:	eb 7b                	jmp    80102e58 <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102ddd:	6a 10                	push   $0x10
80102ddf:	ff 75 f4             	pushl  -0xc(%ebp)
80102de2:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102de5:	50                   	push   %eax
80102de6:	ff 75 08             	pushl  0x8(%ebp)
80102de9:	e8 9c fc ff ff       	call   80102a8a <readi>
80102dee:	83 c4 10             	add    $0x10,%esp
80102df1:	83 f8 10             	cmp    $0x10,%eax
80102df4:	74 0d                	je     80102e03 <dirlookup+0x4f>
      panic("dirlink read");
80102df6:	83 ec 0c             	sub    $0xc,%esp
80102df9:	68 ce b3 10 80       	push   $0x8010b3ce
80102dfe:	e8 3b e0 ff ff       	call   80100e3e <panic>
    if(de.inum == 0)
80102e03:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102e07:	66 85 c0             	test   %ax,%ax
80102e0a:	74 47                	je     80102e53 <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
80102e0c:	83 ec 08             	sub    $0x8,%esp
80102e0f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102e12:	83 c0 02             	add    $0x2,%eax
80102e15:	50                   	push   %eax
80102e16:	ff 75 0c             	pushl  0xc(%ebp)
80102e19:	e8 7b ff ff ff       	call   80102d99 <namecmp>
80102e1e:	83 c4 10             	add    $0x10,%esp
80102e21:	85 c0                	test   %eax,%eax
80102e23:	75 2f                	jne    80102e54 <dirlookup+0xa0>
      // entry matches path element
      if(poff)
80102e25:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102e29:	74 08                	je     80102e33 <dirlookup+0x7f>
        *poff = off;
80102e2b:	8b 45 10             	mov    0x10(%ebp),%eax
80102e2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102e31:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102e33:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102e37:	0f b7 c0             	movzwl %ax,%eax
80102e3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102e3d:	8b 45 08             	mov    0x8(%ebp),%eax
80102e40:	8b 00                	mov    (%eax),%eax
80102e42:	83 ec 08             	sub    $0x8,%esp
80102e45:	ff 75 f0             	pushl  -0x10(%ebp)
80102e48:	50                   	push   %eax
80102e49:	e8 ba f5 ff ff       	call   80102408 <iget>
80102e4e:	83 c4 10             	add    $0x10,%esp
80102e51:	eb 19                	jmp    80102e6c <dirlookup+0xb8>
      continue;
80102e53:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
80102e54:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102e58:	8b 45 08             	mov    0x8(%ebp),%eax
80102e5b:	8b 40 18             	mov    0x18(%eax),%eax
80102e5e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102e61:	0f 82 76 ff ff ff    	jb     80102ddd <dirlookup+0x29>
    }
  }

  return 0;
80102e67:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102e6c:	c9                   	leave  
80102e6d:	c3                   	ret    

80102e6e <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102e6e:	55                   	push   %ebp
80102e6f:	89 e5                	mov    %esp,%ebp
80102e71:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102e74:	83 ec 04             	sub    $0x4,%esp
80102e77:	6a 00                	push   $0x0
80102e79:	ff 75 0c             	pushl  0xc(%ebp)
80102e7c:	ff 75 08             	pushl  0x8(%ebp)
80102e7f:	e8 30 ff ff ff       	call   80102db4 <dirlookup>
80102e84:	83 c4 10             	add    $0x10,%esp
80102e87:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102e8a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102e8e:	74 18                	je     80102ea8 <dirlink+0x3a>
    iput(ip);
80102e90:	83 ec 0c             	sub    $0xc,%esp
80102e93:	ff 75 f0             	pushl  -0x10(%ebp)
80102e96:	e8 56 f8 ff ff       	call   801026f1 <iput>
80102e9b:	83 c4 10             	add    $0x10,%esp
    return -1;
80102e9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ea3:	e9 9c 00 00 00       	jmp    80102f44 <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102ea8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102eaf:	eb 39                	jmp    80102eea <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102eb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102eb4:	6a 10                	push   $0x10
80102eb6:	50                   	push   %eax
80102eb7:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102eba:	50                   	push   %eax
80102ebb:	ff 75 08             	pushl  0x8(%ebp)
80102ebe:	e8 c7 fb ff ff       	call   80102a8a <readi>
80102ec3:	83 c4 10             	add    $0x10,%esp
80102ec6:	83 f8 10             	cmp    $0x10,%eax
80102ec9:	74 0d                	je     80102ed8 <dirlink+0x6a>
      panic("dirlink read");
80102ecb:	83 ec 0c             	sub    $0xc,%esp
80102ece:	68 ce b3 10 80       	push   $0x8010b3ce
80102ed3:	e8 66 df ff ff       	call   80100e3e <panic>
    if(de.inum == 0)
80102ed8:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102edc:	66 85 c0             	test   %ax,%ax
80102edf:	74 18                	je     80102ef9 <dirlink+0x8b>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102ee1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ee4:	83 c0 10             	add    $0x10,%eax
80102ee7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102eea:	8b 45 08             	mov    0x8(%ebp),%eax
80102eed:	8b 50 18             	mov    0x18(%eax),%edx
80102ef0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ef3:	39 c2                	cmp    %eax,%edx
80102ef5:	77 ba                	ja     80102eb1 <dirlink+0x43>
80102ef7:	eb 01                	jmp    80102efa <dirlink+0x8c>
      break;
80102ef9:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
80102efa:	83 ec 04             	sub    $0x4,%esp
80102efd:	6a 0e                	push   $0xe
80102eff:	ff 75 0c             	pushl  0xc(%ebp)
80102f02:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102f05:	83 c0 02             	add    $0x2,%eax
80102f08:	50                   	push   %eax
80102f09:	e8 d0 3a 00 00       	call   801069de <strncpy>
80102f0e:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102f11:	8b 45 10             	mov    0x10(%ebp),%eax
80102f14:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102f18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f1b:	6a 10                	push   $0x10
80102f1d:	50                   	push   %eax
80102f1e:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102f21:	50                   	push   %eax
80102f22:	ff 75 08             	pushl  0x8(%ebp)
80102f25:	e8 cf fc ff ff       	call   80102bf9 <writei>
80102f2a:	83 c4 10             	add    $0x10,%esp
80102f2d:	83 f8 10             	cmp    $0x10,%eax
80102f30:	74 0d                	je     80102f3f <dirlink+0xd1>
    panic("dirlink");
80102f32:	83 ec 0c             	sub    $0xc,%esp
80102f35:	68 db b3 10 80       	push   $0x8010b3db
80102f3a:	e8 ff de ff ff       	call   80100e3e <panic>

  return 0;
80102f3f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102f44:	c9                   	leave  
80102f45:	c3                   	ret    

80102f46 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102f46:	55                   	push   %ebp
80102f47:	89 e5                	mov    %esp,%ebp
80102f49:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
80102f4c:	eb 04                	jmp    80102f52 <skipelem+0xc>
    path++;
80102f4e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
80102f52:	8b 45 08             	mov    0x8(%ebp),%eax
80102f55:	0f b6 00             	movzbl (%eax),%eax
80102f58:	3c 2f                	cmp    $0x2f,%al
80102f5a:	74 f2                	je     80102f4e <skipelem+0x8>
  if(*path == 0)
80102f5c:	8b 45 08             	mov    0x8(%ebp),%eax
80102f5f:	0f b6 00             	movzbl (%eax),%eax
80102f62:	84 c0                	test   %al,%al
80102f64:	75 07                	jne    80102f6d <skipelem+0x27>
    return 0;
80102f66:	b8 00 00 00 00       	mov    $0x0,%eax
80102f6b:	eb 7b                	jmp    80102fe8 <skipelem+0xa2>
  s = path;
80102f6d:	8b 45 08             	mov    0x8(%ebp),%eax
80102f70:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102f73:	eb 04                	jmp    80102f79 <skipelem+0x33>
    path++;
80102f75:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path != '/' && *path != 0)
80102f79:	8b 45 08             	mov    0x8(%ebp),%eax
80102f7c:	0f b6 00             	movzbl (%eax),%eax
80102f7f:	3c 2f                	cmp    $0x2f,%al
80102f81:	74 0a                	je     80102f8d <skipelem+0x47>
80102f83:	8b 45 08             	mov    0x8(%ebp),%eax
80102f86:	0f b6 00             	movzbl (%eax),%eax
80102f89:	84 c0                	test   %al,%al
80102f8b:	75 e8                	jne    80102f75 <skipelem+0x2f>
  len = path - s;
80102f8d:	8b 55 08             	mov    0x8(%ebp),%edx
80102f90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f93:	29 c2                	sub    %eax,%edx
80102f95:	89 d0                	mov    %edx,%eax
80102f97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
80102f9a:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102f9e:	7e 15                	jle    80102fb5 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
80102fa0:	83 ec 04             	sub    $0x4,%esp
80102fa3:	6a 0e                	push   $0xe
80102fa5:	ff 75 f4             	pushl  -0xc(%ebp)
80102fa8:	ff 75 0c             	pushl  0xc(%ebp)
80102fab:	e8 42 39 00 00       	call   801068f2 <memmove>
80102fb0:	83 c4 10             	add    $0x10,%esp
80102fb3:	eb 26                	jmp    80102fdb <skipelem+0x95>
  else {
    memmove(name, s, len);
80102fb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102fb8:	83 ec 04             	sub    $0x4,%esp
80102fbb:	50                   	push   %eax
80102fbc:	ff 75 f4             	pushl  -0xc(%ebp)
80102fbf:	ff 75 0c             	pushl  0xc(%ebp)
80102fc2:	e8 2b 39 00 00       	call   801068f2 <memmove>
80102fc7:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
80102fca:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102fcd:	8b 45 0c             	mov    0xc(%ebp),%eax
80102fd0:	01 d0                	add    %edx,%eax
80102fd2:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102fd5:	eb 04                	jmp    80102fdb <skipelem+0x95>
    path++;
80102fd7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
80102fdb:	8b 45 08             	mov    0x8(%ebp),%eax
80102fde:	0f b6 00             	movzbl (%eax),%eax
80102fe1:	3c 2f                	cmp    $0x2f,%al
80102fe3:	74 f2                	je     80102fd7 <skipelem+0x91>
  return path;
80102fe5:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102fe8:	c9                   	leave  
80102fe9:	c3                   	ret    

80102fea <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102fea:	55                   	push   %ebp
80102feb:	89 e5                	mov    %esp,%ebp
80102fed:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102ff0:	8b 45 08             	mov    0x8(%ebp),%eax
80102ff3:	0f b6 00             	movzbl (%eax),%eax
80102ff6:	3c 2f                	cmp    $0x2f,%al
80102ff8:	75 17                	jne    80103011 <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
80102ffa:	83 ec 08             	sub    $0x8,%esp
80102ffd:	6a 01                	push   $0x1
80102fff:	6a 01                	push   $0x1
80103001:	e8 02 f4 ff ff       	call   80102408 <iget>
80103006:	83 c4 10             	add    $0x10,%esp
80103009:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010300c:	e9 bb 00 00 00       	jmp    801030cc <namex+0xe2>
  else
    ip = idup(proc->cwd);
80103011:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103017:	8b 40 68             	mov    0x68(%eax),%eax
8010301a:	83 ec 0c             	sub    $0xc,%esp
8010301d:	50                   	push   %eax
8010301e:	e8 c4 f4 ff ff       	call   801024e7 <idup>
80103023:	83 c4 10             	add    $0x10,%esp
80103026:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80103029:	e9 9e 00 00 00       	jmp    801030cc <namex+0xe2>
    ilock(ip);
8010302e:	83 ec 0c             	sub    $0xc,%esp
80103031:	ff 75 f4             	pushl  -0xc(%ebp)
80103034:	e8 e8 f4 ff ff       	call   80102521 <ilock>
80103039:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
8010303c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010303f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80103043:	66 83 f8 01          	cmp    $0x1,%ax
80103047:	74 18                	je     80103061 <namex+0x77>
      iunlockput(ip);
80103049:	83 ec 0c             	sub    $0xc,%esp
8010304c:	ff 75 f4             	pushl  -0xc(%ebp)
8010304f:	e8 8d f7 ff ff       	call   801027e1 <iunlockput>
80103054:	83 c4 10             	add    $0x10,%esp
      return 0;
80103057:	b8 00 00 00 00       	mov    $0x0,%eax
8010305c:	e9 a7 00 00 00       	jmp    80103108 <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
80103061:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103065:	74 20                	je     80103087 <namex+0x9d>
80103067:	8b 45 08             	mov    0x8(%ebp),%eax
8010306a:	0f b6 00             	movzbl (%eax),%eax
8010306d:	84 c0                	test   %al,%al
8010306f:	75 16                	jne    80103087 <namex+0x9d>
      // Stop one level early.
      iunlock(ip);
80103071:	83 ec 0c             	sub    $0xc,%esp
80103074:	ff 75 f4             	pushl  -0xc(%ebp)
80103077:	e8 03 f6 ff ff       	call   8010267f <iunlock>
8010307c:	83 c4 10             	add    $0x10,%esp
      return ip;
8010307f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103082:	e9 81 00 00 00       	jmp    80103108 <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80103087:	83 ec 04             	sub    $0x4,%esp
8010308a:	6a 00                	push   $0x0
8010308c:	ff 75 10             	pushl  0x10(%ebp)
8010308f:	ff 75 f4             	pushl  -0xc(%ebp)
80103092:	e8 1d fd ff ff       	call   80102db4 <dirlookup>
80103097:	83 c4 10             	add    $0x10,%esp
8010309a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010309d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801030a1:	75 15                	jne    801030b8 <namex+0xce>
      iunlockput(ip);
801030a3:	83 ec 0c             	sub    $0xc,%esp
801030a6:	ff 75 f4             	pushl  -0xc(%ebp)
801030a9:	e8 33 f7 ff ff       	call   801027e1 <iunlockput>
801030ae:	83 c4 10             	add    $0x10,%esp
      return 0;
801030b1:	b8 00 00 00 00       	mov    $0x0,%eax
801030b6:	eb 50                	jmp    80103108 <namex+0x11e>
    }
    iunlockput(ip);
801030b8:	83 ec 0c             	sub    $0xc,%esp
801030bb:	ff 75 f4             	pushl  -0xc(%ebp)
801030be:	e8 1e f7 ff ff       	call   801027e1 <iunlockput>
801030c3:	83 c4 10             	add    $0x10,%esp
    ip = next;
801030c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
801030cc:	83 ec 08             	sub    $0x8,%esp
801030cf:	ff 75 10             	pushl  0x10(%ebp)
801030d2:	ff 75 08             	pushl  0x8(%ebp)
801030d5:	e8 6c fe ff ff       	call   80102f46 <skipelem>
801030da:	83 c4 10             	add    $0x10,%esp
801030dd:	89 45 08             	mov    %eax,0x8(%ebp)
801030e0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801030e4:	0f 85 44 ff ff ff    	jne    8010302e <namex+0x44>
  }
  if(nameiparent){
801030ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801030ee:	74 15                	je     80103105 <namex+0x11b>
    iput(ip);
801030f0:	83 ec 0c             	sub    $0xc,%esp
801030f3:	ff 75 f4             	pushl  -0xc(%ebp)
801030f6:	e8 f6 f5 ff ff       	call   801026f1 <iput>
801030fb:	83 c4 10             	add    $0x10,%esp
    return 0;
801030fe:	b8 00 00 00 00       	mov    $0x0,%eax
80103103:	eb 03                	jmp    80103108 <namex+0x11e>
  }
  return ip;
80103105:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103108:	c9                   	leave  
80103109:	c3                   	ret    

8010310a <namei>:

struct inode*
namei(char *path)
{
8010310a:	55                   	push   %ebp
8010310b:	89 e5                	mov    %esp,%ebp
8010310d:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80103110:	83 ec 04             	sub    $0x4,%esp
80103113:	8d 45 ea             	lea    -0x16(%ebp),%eax
80103116:	50                   	push   %eax
80103117:	6a 00                	push   $0x0
80103119:	ff 75 08             	pushl  0x8(%ebp)
8010311c:	e8 c9 fe ff ff       	call   80102fea <namex>
80103121:	83 c4 10             	add    $0x10,%esp
}
80103124:	c9                   	leave  
80103125:	c3                   	ret    

80103126 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80103126:	55                   	push   %ebp
80103127:	89 e5                	mov    %esp,%ebp
80103129:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
8010312c:	83 ec 04             	sub    $0x4,%esp
8010312f:	ff 75 0c             	pushl  0xc(%ebp)
80103132:	6a 01                	push   $0x1
80103134:	ff 75 08             	pushl  0x8(%ebp)
80103137:	e8 ae fe ff ff       	call   80102fea <namex>
8010313c:	83 c4 10             	add    $0x10,%esp
}
8010313f:	c9                   	leave  
80103140:	c3                   	ret    

80103141 <readablei>:

// Check if this inode is readable
int
readablei(struct inode *ip, uint off)
{
80103141:	55                   	push   %ebp
80103142:	89 e5                	mov    %esp,%ebp
80103144:	83 ec 08             	sub    $0x8,%esp
  if(ip->type == T_DEV){
80103147:	8b 45 08             	mov    0x8(%ebp),%eax
8010314a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010314e:	66 83 f8 03          	cmp    $0x3,%ax
80103152:	75 67                	jne    801031bb <readablei+0x7a>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].readable)
80103154:	8b 45 08             	mov    0x8(%ebp),%eax
80103157:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010315b:	66 85 c0             	test   %ax,%ax
8010315e:	78 2c                	js     8010318c <readablei+0x4b>
80103160:	8b 45 08             	mov    0x8(%ebp),%eax
80103163:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80103167:	66 83 f8 09          	cmp    $0x9,%ax
8010316b:	7f 1f                	jg     8010318c <readablei+0x4b>
8010316d:	8b 45 08             	mov    0x8(%ebp),%eax
80103170:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80103174:	0f bf d0             	movswl %ax,%edx
80103177:	89 d0                	mov    %edx,%eax
80103179:	c1 e0 03             	shl    $0x3,%eax
8010317c:	01 d0                	add    %edx,%eax
8010317e:	c1 e0 05             	shl    $0x5,%eax
80103181:	05 6c f6 12 80       	add    $0x8012f66c,%eax
80103186:	8b 00                	mov    (%eax),%eax
80103188:	85 c0                	test   %eax,%eax
8010318a:	75 07                	jne    80103193 <readablei+0x52>
      return -1;
8010318c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103191:	eb 2d                	jmp    801031c0 <readablei+0x7f>
    return devsw[ip->major].readable(ip);
80103193:	8b 45 08             	mov    0x8(%ebp),%eax
80103196:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010319a:	0f bf d0             	movswl %ax,%edx
8010319d:	89 d0                	mov    %edx,%eax
8010319f:	c1 e0 03             	shl    $0x3,%eax
801031a2:	01 d0                	add    %edx,%eax
801031a4:	c1 e0 05             	shl    $0x5,%eax
801031a7:	05 6c f6 12 80       	add    $0x8012f66c,%eax
801031ac:	8b 00                	mov    (%eax),%eax
801031ae:	83 ec 0c             	sub    $0xc,%esp
801031b1:	ff 75 08             	pushl  0x8(%ebp)
801031b4:	ff d0                	call   *%eax
801031b6:	83 c4 10             	add    $0x10,%esp
801031b9:	eb 05                	jmp    801031c0 <readablei+0x7f>
  }
    
  return -1;
801031bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801031c0:	c9                   	leave  
801031c1:	c3                   	ret    

801031c2 <writeablei>:

// Check if this inode is writeable
int
writeablei(struct inode *ip, uint off)
{
801031c2:	55                   	push   %ebp
801031c3:	89 e5                	mov    %esp,%ebp
801031c5:	83 ec 08             	sub    $0x8,%esp
  if(ip->type == T_DEV){
801031c8:	8b 45 08             	mov    0x8(%ebp),%eax
801031cb:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801031cf:	66 83 f8 03          	cmp    $0x3,%ax
801031d3:	75 67                	jne    8010323c <writeablei+0x7a>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].writeable)
801031d5:	8b 45 08             	mov    0x8(%ebp),%eax
801031d8:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801031dc:	66 85 c0             	test   %ax,%ax
801031df:	78 2c                	js     8010320d <writeablei+0x4b>
801031e1:	8b 45 08             	mov    0x8(%ebp),%eax
801031e4:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801031e8:	66 83 f8 09          	cmp    $0x9,%ax
801031ec:	7f 1f                	jg     8010320d <writeablei+0x4b>
801031ee:	8b 45 08             	mov    0x8(%ebp),%eax
801031f1:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801031f5:	0f bf d0             	movswl %ax,%edx
801031f8:	89 d0                	mov    %edx,%eax
801031fa:	c1 e0 03             	shl    $0x3,%eax
801031fd:	01 d0                	add    %edx,%eax
801031ff:	c1 e0 05             	shl    $0x5,%eax
80103202:	05 68 f6 12 80       	add    $0x8012f668,%eax
80103207:	8b 00                	mov    (%eax),%eax
80103209:	85 c0                	test   %eax,%eax
8010320b:	75 07                	jne    80103214 <writeablei+0x52>
      return -1;
8010320d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103212:	eb 2d                	jmp    80103241 <writeablei+0x7f>
    return devsw[ip->major].writeable(ip);
80103214:	8b 45 08             	mov    0x8(%ebp),%eax
80103217:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010321b:	0f bf d0             	movswl %ax,%edx
8010321e:	89 d0                	mov    %edx,%eax
80103220:	c1 e0 03             	shl    $0x3,%eax
80103223:	01 d0                	add    %edx,%eax
80103225:	c1 e0 05             	shl    $0x5,%eax
80103228:	05 68 f6 12 80       	add    $0x8012f668,%eax
8010322d:	8b 00                	mov    (%eax),%eax
8010322f:	83 ec 0c             	sub    $0xc,%esp
80103232:	ff 75 08             	pushl  0x8(%ebp)
80103235:	ff d0                	call   *%eax
80103237:	83 c4 10             	add    $0x10,%esp
8010323a:	eb 05                	jmp    80103241 <writeablei+0x7f>
  }

  return -1;
8010323c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103241:	c9                   	leave  
80103242:	c3                   	ret    

80103243 <selecti>:

int
selecti(struct inode *ip, int * selid, struct spinlock * lk)
{
80103243:	55                   	push   %ebp
80103244:	89 e5                	mov    %esp,%ebp
80103246:	83 ec 08             	sub    $0x8,%esp
 if(ip->type == T_DEV){
80103249:	8b 45 08             	mov    0x8(%ebp),%eax
8010324c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80103250:	66 83 f8 03          	cmp    $0x3,%ax
80103254:	75 6d                	jne    801032c3 <selecti+0x80>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].select)
80103256:	8b 45 08             	mov    0x8(%ebp),%eax
80103259:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010325d:	66 85 c0             	test   %ax,%ax
80103260:	78 2c                	js     8010328e <selecti+0x4b>
80103262:	8b 45 08             	mov    0x8(%ebp),%eax
80103265:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80103269:	66 83 f8 09          	cmp    $0x9,%ax
8010326d:	7f 1f                	jg     8010328e <selecti+0x4b>
8010326f:	8b 45 08             	mov    0x8(%ebp),%eax
80103272:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80103276:	0f bf d0             	movswl %ax,%edx
80103279:	89 d0                	mov    %edx,%eax
8010327b:	c1 e0 03             	shl    $0x3,%eax
8010327e:	01 d0                	add    %edx,%eax
80103280:	c1 e0 05             	shl    $0x5,%eax
80103283:	05 70 f6 12 80       	add    $0x8012f670,%eax
80103288:	8b 00                	mov    (%eax),%eax
8010328a:	85 c0                	test   %eax,%eax
8010328c:	75 07                	jne    80103295 <selecti+0x52>
      return -1;
8010328e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103293:	eb 33                	jmp    801032c8 <selecti+0x85>
    return devsw[ip->major].select(ip, selid, lk);
80103295:	8b 45 08             	mov    0x8(%ebp),%eax
80103298:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010329c:	0f bf d0             	movswl %ax,%edx
8010329f:	89 d0                	mov    %edx,%eax
801032a1:	c1 e0 03             	shl    $0x3,%eax
801032a4:	01 d0                	add    %edx,%eax
801032a6:	c1 e0 05             	shl    $0x5,%eax
801032a9:	05 70 f6 12 80       	add    $0x8012f670,%eax
801032ae:	8b 00                	mov    (%eax),%eax
801032b0:	83 ec 04             	sub    $0x4,%esp
801032b3:	ff 75 10             	pushl  0x10(%ebp)
801032b6:	ff 75 0c             	pushl  0xc(%ebp)
801032b9:	ff 75 08             	pushl  0x8(%ebp)
801032bc:	ff d0                	call   *%eax
801032be:	83 c4 10             	add    $0x10,%esp
801032c1:	eb 05                	jmp    801032c8 <selecti+0x85>
  }

  return -1;
801032c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032c8:	c9                   	leave  
801032c9:	c3                   	ret    

801032ca <clrseli>:

int
clrseli(struct inode *ip, int * selid)
{
801032ca:	55                   	push   %ebp
801032cb:	89 e5                	mov    %esp,%ebp
801032cd:	83 ec 08             	sub    $0x8,%esp
 if(ip->type == T_DEV){
801032d0:	8b 45 08             	mov    0x8(%ebp),%eax
801032d3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801032d7:	66 83 f8 03          	cmp    $0x3,%ax
801032db:	75 6a                	jne    80103347 <clrseli+0x7d>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].select)
801032dd:	8b 45 08             	mov    0x8(%ebp),%eax
801032e0:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801032e4:	66 85 c0             	test   %ax,%ax
801032e7:	78 2c                	js     80103315 <clrseli+0x4b>
801032e9:	8b 45 08             	mov    0x8(%ebp),%eax
801032ec:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801032f0:	66 83 f8 09          	cmp    $0x9,%ax
801032f4:	7f 1f                	jg     80103315 <clrseli+0x4b>
801032f6:	8b 45 08             	mov    0x8(%ebp),%eax
801032f9:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801032fd:	0f bf d0             	movswl %ax,%edx
80103300:	89 d0                	mov    %edx,%eax
80103302:	c1 e0 03             	shl    $0x3,%eax
80103305:	01 d0                	add    %edx,%eax
80103307:	c1 e0 05             	shl    $0x5,%eax
8010330a:	05 70 f6 12 80       	add    $0x8012f670,%eax
8010330f:	8b 00                	mov    (%eax),%eax
80103311:	85 c0                	test   %eax,%eax
80103313:	75 07                	jne    8010331c <clrseli+0x52>
      return -1;
80103315:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010331a:	eb 30                	jmp    8010334c <clrseli+0x82>
    return devsw[ip->major].clrsel(ip, selid);
8010331c:	8b 45 08             	mov    0x8(%ebp),%eax
8010331f:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80103323:	0f bf d0             	movswl %ax,%edx
80103326:	89 d0                	mov    %edx,%eax
80103328:	c1 e0 03             	shl    $0x3,%eax
8010332b:	01 d0                	add    %edx,%eax
8010332d:	c1 e0 05             	shl    $0x5,%eax
80103330:	05 74 f6 12 80       	add    $0x8012f674,%eax
80103335:	8b 00                	mov    (%eax),%eax
80103337:	83 ec 08             	sub    $0x8,%esp
8010333a:	ff 75 0c             	pushl  0xc(%ebp)
8010333d:	ff 75 08             	pushl  0x8(%ebp)
80103340:	ff d0                	call   *%eax
80103342:	83 c4 10             	add    $0x10,%esp
80103345:	eb 05                	jmp    8010334c <clrseli+0x82>
  }

  return -1;
80103347:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010334c:	c9                   	leave  
8010334d:	c3                   	ret    

8010334e <inb>:
{
8010334e:	55                   	push   %ebp
8010334f:	89 e5                	mov    %esp,%ebp
80103351:	83 ec 14             	sub    $0x14,%esp
80103354:	8b 45 08             	mov    0x8(%ebp),%eax
80103357:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010335b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010335f:	89 c2                	mov    %eax,%edx
80103361:	ec                   	in     (%dx),%al
80103362:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103365:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103369:	c9                   	leave  
8010336a:	c3                   	ret    

8010336b <insl>:
{
8010336b:	55                   	push   %ebp
8010336c:	89 e5                	mov    %esp,%ebp
8010336e:	57                   	push   %edi
8010336f:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80103370:	8b 55 08             	mov    0x8(%ebp),%edx
80103373:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103376:	8b 45 10             	mov    0x10(%ebp),%eax
80103379:	89 cb                	mov    %ecx,%ebx
8010337b:	89 df                	mov    %ebx,%edi
8010337d:	89 c1                	mov    %eax,%ecx
8010337f:	fc                   	cld    
80103380:	f3 6d                	rep insl (%dx),%es:(%edi)
80103382:	89 c8                	mov    %ecx,%eax
80103384:	89 fb                	mov    %edi,%ebx
80103386:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80103389:	89 45 10             	mov    %eax,0x10(%ebp)
}
8010338c:	90                   	nop
8010338d:	5b                   	pop    %ebx
8010338e:	5f                   	pop    %edi
8010338f:	5d                   	pop    %ebp
80103390:	c3                   	ret    

80103391 <outb>:
{
80103391:	55                   	push   %ebp
80103392:	89 e5                	mov    %esp,%ebp
80103394:	83 ec 08             	sub    $0x8,%esp
80103397:	8b 55 08             	mov    0x8(%ebp),%edx
8010339a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010339d:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801033a1:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801033a4:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801033a8:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801033ac:	ee                   	out    %al,(%dx)
}
801033ad:	90                   	nop
801033ae:	c9                   	leave  
801033af:	c3                   	ret    

801033b0 <outsl>:
{
801033b0:	55                   	push   %ebp
801033b1:	89 e5                	mov    %esp,%ebp
801033b3:	56                   	push   %esi
801033b4:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801033b5:	8b 55 08             	mov    0x8(%ebp),%edx
801033b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801033bb:	8b 45 10             	mov    0x10(%ebp),%eax
801033be:	89 cb                	mov    %ecx,%ebx
801033c0:	89 de                	mov    %ebx,%esi
801033c2:	89 c1                	mov    %eax,%ecx
801033c4:	fc                   	cld    
801033c5:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801033c7:	89 c8                	mov    %ecx,%eax
801033c9:	89 f3                	mov    %esi,%ebx
801033cb:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801033ce:	89 45 10             	mov    %eax,0x10(%ebp)
}
801033d1:	90                   	nop
801033d2:	5b                   	pop    %ebx
801033d3:	5e                   	pop    %esi
801033d4:	5d                   	pop    %ebp
801033d5:	c3                   	ret    

801033d6 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801033d6:	55                   	push   %ebp
801033d7:	89 e5                	mov    %esp,%ebp
801033d9:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801033dc:	90                   	nop
801033dd:	68 f7 01 00 00       	push   $0x1f7
801033e2:	e8 67 ff ff ff       	call   8010334e <inb>
801033e7:	83 c4 04             	add    $0x4,%esp
801033ea:	0f b6 c0             	movzbl %al,%eax
801033ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
801033f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801033f3:	25 c0 00 00 00       	and    $0xc0,%eax
801033f8:	83 f8 40             	cmp    $0x40,%eax
801033fb:	75 e0                	jne    801033dd <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801033fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80103401:	74 11                	je     80103414 <idewait+0x3e>
80103403:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103406:	83 e0 21             	and    $0x21,%eax
80103409:	85 c0                	test   %eax,%eax
8010340b:	74 07                	je     80103414 <idewait+0x3e>
    return -1;
8010340d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103412:	eb 05                	jmp    80103419 <idewait+0x43>
  return 0;
80103414:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103419:	c9                   	leave  
8010341a:	c3                   	ret    

8010341b <ideinit>:

void
ideinit(void)
{
8010341b:	55                   	push   %ebp
8010341c:	89 e5                	mov    %esp,%ebp
8010341e:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80103421:	83 ec 08             	sub    $0x8,%esp
80103424:	68 e3 b3 10 80       	push   $0x8010b3e3
80103429:	68 80 96 12 80       	push   $0x80129680
8010342e:	e8 68 31 00 00       	call   8010659b <initlock>
80103433:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	6a 0e                	push   $0xe
8010343b:	e8 03 20 00 00       	call   80105443 <picenable>
80103440:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80103443:	a1 c0 18 13 80       	mov    0x801318c0,%eax
80103448:	83 e8 01             	sub    $0x1,%eax
8010344b:	83 ec 08             	sub    $0x8,%esp
8010344e:	50                   	push   %eax
8010344f:	6a 0e                	push   $0xe
80103451:	e8 a7 04 00 00       	call   801038fd <ioapicenable>
80103456:	83 c4 10             	add    $0x10,%esp
  idewait(0);
80103459:	83 ec 0c             	sub    $0xc,%esp
8010345c:	6a 00                	push   $0x0
8010345e:	e8 73 ff ff ff       	call   801033d6 <idewait>
80103463:	83 c4 10             	add    $0x10,%esp

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80103466:	83 ec 08             	sub    $0x8,%esp
80103469:	68 f0 00 00 00       	push   $0xf0
8010346e:	68 f6 01 00 00       	push   $0x1f6
80103473:	e8 19 ff ff ff       	call   80103391 <outb>
80103478:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
8010347b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103482:	eb 24                	jmp    801034a8 <ideinit+0x8d>
    if(inb(0x1f7) != 0){
80103484:	83 ec 0c             	sub    $0xc,%esp
80103487:	68 f7 01 00 00       	push   $0x1f7
8010348c:	e8 bd fe ff ff       	call   8010334e <inb>
80103491:	83 c4 10             	add    $0x10,%esp
80103494:	84 c0                	test   %al,%al
80103496:	74 0c                	je     801034a4 <ideinit+0x89>
      havedisk1 = 1;
80103498:	c7 05 b8 96 12 80 01 	movl   $0x1,0x801296b8
8010349f:	00 00 00 
      break;
801034a2:	eb 0d                	jmp    801034b1 <ideinit+0x96>
  for(i=0; i<1000; i++){
801034a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034a8:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801034af:	7e d3                	jle    80103484 <ideinit+0x69>
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801034b1:	83 ec 08             	sub    $0x8,%esp
801034b4:	68 e0 00 00 00       	push   $0xe0
801034b9:	68 f6 01 00 00       	push   $0x1f6
801034be:	e8 ce fe ff ff       	call   80103391 <outb>
801034c3:	83 c4 10             	add    $0x10,%esp
}
801034c6:	90                   	nop
801034c7:	c9                   	leave  
801034c8:	c3                   	ret    

801034c9 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801034c9:	55                   	push   %ebp
801034ca:	89 e5                	mov    %esp,%ebp
801034cc:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801034cf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801034d3:	75 0d                	jne    801034e2 <idestart+0x19>
    panic("idestart");
801034d5:	83 ec 0c             	sub    $0xc,%esp
801034d8:	68 e7 b3 10 80       	push   $0x8010b3e7
801034dd:	e8 5c d9 ff ff       	call   80100e3e <panic>
  if(b->blockno >= FSSIZE)
801034e2:	8b 45 08             	mov    0x8(%ebp),%eax
801034e5:	8b 40 08             	mov    0x8(%eax),%eax
801034e8:	3d e7 03 00 00       	cmp    $0x3e7,%eax
801034ed:	76 0d                	jbe    801034fc <idestart+0x33>
    panic("incorrect blockno");
801034ef:	83 ec 0c             	sub    $0xc,%esp
801034f2:	68 f0 b3 10 80       	push   $0x8010b3f0
801034f7:	e8 42 d9 ff ff       	call   80100e3e <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
801034fc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
80103503:	8b 45 08             	mov    0x8(%ebp),%eax
80103506:	8b 50 08             	mov    0x8(%eax),%edx
80103509:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010350c:	0f af c2             	imul   %edx,%eax
8010350f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
80103512:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80103516:	75 07                	jne    8010351f <idestart+0x56>
80103518:	b8 20 00 00 00       	mov    $0x20,%eax
8010351d:	eb 05                	jmp    80103524 <idestart+0x5b>
8010351f:	b8 c4 00 00 00       	mov    $0xc4,%eax
80103524:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
80103527:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
8010352b:	75 07                	jne    80103534 <idestart+0x6b>
8010352d:	b8 30 00 00 00       	mov    $0x30,%eax
80103532:	eb 05                	jmp    80103539 <idestart+0x70>
80103534:	b8 c5 00 00 00       	mov    $0xc5,%eax
80103539:	89 45 e8             	mov    %eax,-0x18(%ebp)

  if (sector_per_block > 7) panic("idestart");
8010353c:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80103540:	7e 0d                	jle    8010354f <idestart+0x86>
80103542:	83 ec 0c             	sub    $0xc,%esp
80103545:	68 e7 b3 10 80       	push   $0x8010b3e7
8010354a:	e8 ef d8 ff ff       	call   80100e3e <panic>

  idewait(0);
8010354f:	83 ec 0c             	sub    $0xc,%esp
80103552:	6a 00                	push   $0x0
80103554:	e8 7d fe ff ff       	call   801033d6 <idewait>
80103559:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
8010355c:	83 ec 08             	sub    $0x8,%esp
8010355f:	6a 00                	push   $0x0
80103561:	68 f6 03 00 00       	push   $0x3f6
80103566:	e8 26 fe ff ff       	call   80103391 <outb>
8010356b:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
8010356e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103571:	0f b6 c0             	movzbl %al,%eax
80103574:	83 ec 08             	sub    $0x8,%esp
80103577:	50                   	push   %eax
80103578:	68 f2 01 00 00       	push   $0x1f2
8010357d:	e8 0f fe ff ff       	call   80103391 <outb>
80103582:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
80103585:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103588:	0f b6 c0             	movzbl %al,%eax
8010358b:	83 ec 08             	sub    $0x8,%esp
8010358e:	50                   	push   %eax
8010358f:	68 f3 01 00 00       	push   $0x1f3
80103594:	e8 f8 fd ff ff       	call   80103391 <outb>
80103599:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
8010359c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010359f:	c1 f8 08             	sar    $0x8,%eax
801035a2:	0f b6 c0             	movzbl %al,%eax
801035a5:	83 ec 08             	sub    $0x8,%esp
801035a8:	50                   	push   %eax
801035a9:	68 f4 01 00 00       	push   $0x1f4
801035ae:	e8 de fd ff ff       	call   80103391 <outb>
801035b3:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
801035b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035b9:	c1 f8 10             	sar    $0x10,%eax
801035bc:	0f b6 c0             	movzbl %al,%eax
801035bf:	83 ec 08             	sub    $0x8,%esp
801035c2:	50                   	push   %eax
801035c3:	68 f5 01 00 00       	push   $0x1f5
801035c8:	e8 c4 fd ff ff       	call   80103391 <outb>
801035cd:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801035d0:	8b 45 08             	mov    0x8(%ebp),%eax
801035d3:	8b 40 04             	mov    0x4(%eax),%eax
801035d6:	c1 e0 04             	shl    $0x4,%eax
801035d9:	83 e0 10             	and    $0x10,%eax
801035dc:	89 c2                	mov    %eax,%edx
801035de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035e1:	c1 f8 18             	sar    $0x18,%eax
801035e4:	83 e0 0f             	and    $0xf,%eax
801035e7:	09 d0                	or     %edx,%eax
801035e9:	83 c8 e0             	or     $0xffffffe0,%eax
801035ec:	0f b6 c0             	movzbl %al,%eax
801035ef:	83 ec 08             	sub    $0x8,%esp
801035f2:	50                   	push   %eax
801035f3:	68 f6 01 00 00       	push   $0x1f6
801035f8:	e8 94 fd ff ff       	call   80103391 <outb>
801035fd:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80103600:	8b 45 08             	mov    0x8(%ebp),%eax
80103603:	8b 00                	mov    (%eax),%eax
80103605:	83 e0 04             	and    $0x4,%eax
80103608:	85 c0                	test   %eax,%eax
8010360a:	74 35                	je     80103641 <idestart+0x178>
    outb(0x1f7, write_cmd);
8010360c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010360f:	0f b6 c0             	movzbl %al,%eax
80103612:	83 ec 08             	sub    $0x8,%esp
80103615:	50                   	push   %eax
80103616:	68 f7 01 00 00       	push   $0x1f7
8010361b:	e8 71 fd ff ff       	call   80103391 <outb>
80103620:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
80103623:	8b 45 08             	mov    0x8(%ebp),%eax
80103626:	83 c0 18             	add    $0x18,%eax
80103629:	83 ec 04             	sub    $0x4,%esp
8010362c:	68 80 00 00 00       	push   $0x80
80103631:	50                   	push   %eax
80103632:	68 f0 01 00 00       	push   $0x1f0
80103637:	e8 74 fd ff ff       	call   801033b0 <outsl>
8010363c:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010363f:	eb 17                	jmp    80103658 <idestart+0x18f>
    outb(0x1f7, read_cmd);
80103641:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103644:	0f b6 c0             	movzbl %al,%eax
80103647:	83 ec 08             	sub    $0x8,%esp
8010364a:	50                   	push   %eax
8010364b:	68 f7 01 00 00       	push   $0x1f7
80103650:	e8 3c fd ff ff       	call   80103391 <outb>
80103655:	83 c4 10             	add    $0x10,%esp
}
80103658:	90                   	nop
80103659:	c9                   	leave  
8010365a:	c3                   	ret    

8010365b <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
8010365b:	55                   	push   %ebp
8010365c:	89 e5                	mov    %esp,%ebp
8010365e:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80103661:	83 ec 0c             	sub    $0xc,%esp
80103664:	68 80 96 12 80       	push   $0x80129680
80103669:	e8 4f 2f 00 00       	call   801065bd <acquire>
8010366e:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
80103671:	a1 b4 96 12 80       	mov    0x801296b4,%eax
80103676:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103679:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010367d:	75 15                	jne    80103694 <ideintr+0x39>
    release(&idelock);
8010367f:	83 ec 0c             	sub    $0xc,%esp
80103682:	68 80 96 12 80       	push   $0x80129680
80103687:	e8 9d 2f 00 00       	call   80106629 <release>
8010368c:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
8010368f:	e9 9a 00 00 00       	jmp    8010372e <ideintr+0xd3>
  }
  idequeue = b->qnext;
80103694:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103697:	8b 40 14             	mov    0x14(%eax),%eax
8010369a:	a3 b4 96 12 80       	mov    %eax,0x801296b4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
8010369f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036a2:	8b 00                	mov    (%eax),%eax
801036a4:	83 e0 04             	and    $0x4,%eax
801036a7:	85 c0                	test   %eax,%eax
801036a9:	75 2d                	jne    801036d8 <ideintr+0x7d>
801036ab:	83 ec 0c             	sub    $0xc,%esp
801036ae:	6a 01                	push   $0x1
801036b0:	e8 21 fd ff ff       	call   801033d6 <idewait>
801036b5:	83 c4 10             	add    $0x10,%esp
801036b8:	85 c0                	test   %eax,%eax
801036ba:	78 1c                	js     801036d8 <ideintr+0x7d>
    insl(0x1f0, b->data, BSIZE/4);
801036bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036bf:	83 c0 18             	add    $0x18,%eax
801036c2:	83 ec 04             	sub    $0x4,%esp
801036c5:	68 80 00 00 00       	push   $0x80
801036ca:	50                   	push   %eax
801036cb:	68 f0 01 00 00       	push   $0x1f0
801036d0:	e8 96 fc ff ff       	call   8010336b <insl>
801036d5:	83 c4 10             	add    $0x10,%esp

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801036d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036db:	8b 00                	mov    (%eax),%eax
801036dd:	83 c8 02             	or     $0x2,%eax
801036e0:	89 c2                	mov    %eax,%edx
801036e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036e5:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
801036e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036ea:	8b 00                	mov    (%eax),%eax
801036ec:	83 e0 fb             	and    $0xfffffffb,%eax
801036ef:	89 c2                	mov    %eax,%edx
801036f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036f4:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801036f6:	83 ec 0c             	sub    $0xc,%esp
801036f9:	ff 75 f4             	pushl  -0xc(%ebp)
801036fc:	e8 a8 2c 00 00       	call   801063a9 <wakeup>
80103701:	83 c4 10             	add    $0x10,%esp

  // Start disk on next buf in queue.
  if(idequeue != 0)
80103704:	a1 b4 96 12 80       	mov    0x801296b4,%eax
80103709:	85 c0                	test   %eax,%eax
8010370b:	74 11                	je     8010371e <ideintr+0xc3>
    idestart(idequeue);
8010370d:	a1 b4 96 12 80       	mov    0x801296b4,%eax
80103712:	83 ec 0c             	sub    $0xc,%esp
80103715:	50                   	push   %eax
80103716:	e8 ae fd ff ff       	call   801034c9 <idestart>
8010371b:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
8010371e:	83 ec 0c             	sub    $0xc,%esp
80103721:	68 80 96 12 80       	push   $0x80129680
80103726:	e8 fe 2e 00 00       	call   80106629 <release>
8010372b:	83 c4 10             	add    $0x10,%esp
}
8010372e:	c9                   	leave  
8010372f:	c3                   	ret    

80103730 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
80103736:	8b 45 08             	mov    0x8(%ebp),%eax
80103739:	8b 00                	mov    (%eax),%eax
8010373b:	83 e0 01             	and    $0x1,%eax
8010373e:	85 c0                	test   %eax,%eax
80103740:	75 0d                	jne    8010374f <iderw+0x1f>
    panic("iderw: buf not busy");
80103742:	83 ec 0c             	sub    $0xc,%esp
80103745:	68 02 b4 10 80       	push   $0x8010b402
8010374a:	e8 ef d6 ff ff       	call   80100e3e <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010374f:	8b 45 08             	mov    0x8(%ebp),%eax
80103752:	8b 00                	mov    (%eax),%eax
80103754:	83 e0 06             	and    $0x6,%eax
80103757:	83 f8 02             	cmp    $0x2,%eax
8010375a:	75 0d                	jne    80103769 <iderw+0x39>
    panic("iderw: nothing to do");
8010375c:	83 ec 0c             	sub    $0xc,%esp
8010375f:	68 16 b4 10 80       	push   $0x8010b416
80103764:	e8 d5 d6 ff ff       	call   80100e3e <panic>
  if(b->dev != 0 && !havedisk1)
80103769:	8b 45 08             	mov    0x8(%ebp),%eax
8010376c:	8b 40 04             	mov    0x4(%eax),%eax
8010376f:	85 c0                	test   %eax,%eax
80103771:	74 16                	je     80103789 <iderw+0x59>
80103773:	a1 b8 96 12 80       	mov    0x801296b8,%eax
80103778:	85 c0                	test   %eax,%eax
8010377a:	75 0d                	jne    80103789 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
8010377c:	83 ec 0c             	sub    $0xc,%esp
8010377f:	68 2b b4 10 80       	push   $0x8010b42b
80103784:	e8 b5 d6 ff ff       	call   80100e3e <panic>

  acquire(&idelock);  //DOC:acquire-lock
80103789:	83 ec 0c             	sub    $0xc,%esp
8010378c:	68 80 96 12 80       	push   $0x80129680
80103791:	e8 27 2e 00 00       	call   801065bd <acquire>
80103796:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80103799:	8b 45 08             	mov    0x8(%ebp),%eax
8010379c:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801037a3:	c7 45 f4 b4 96 12 80 	movl   $0x801296b4,-0xc(%ebp)
801037aa:	eb 0b                	jmp    801037b7 <iderw+0x87>
801037ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037af:	8b 00                	mov    (%eax),%eax
801037b1:	83 c0 14             	add    $0x14,%eax
801037b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801037b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037ba:	8b 00                	mov    (%eax),%eax
801037bc:	85 c0                	test   %eax,%eax
801037be:	75 ec                	jne    801037ac <iderw+0x7c>
    ;
  *pp = b;
801037c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037c3:	8b 55 08             	mov    0x8(%ebp),%edx
801037c6:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
801037c8:	a1 b4 96 12 80       	mov    0x801296b4,%eax
801037cd:	39 45 08             	cmp    %eax,0x8(%ebp)
801037d0:	75 23                	jne    801037f5 <iderw+0xc5>
    idestart(b);
801037d2:	83 ec 0c             	sub    $0xc,%esp
801037d5:	ff 75 08             	pushl  0x8(%ebp)
801037d8:	e8 ec fc ff ff       	call   801034c9 <idestart>
801037dd:	83 c4 10             	add    $0x10,%esp

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801037e0:	eb 13                	jmp    801037f5 <iderw+0xc5>
    sleep(b, &idelock);
801037e2:	83 ec 08             	sub    $0x8,%esp
801037e5:	68 80 96 12 80       	push   $0x80129680
801037ea:	ff 75 08             	pushl  0x8(%ebp)
801037ed:	e8 c9 2a 00 00       	call   801062bb <sleep>
801037f2:	83 c4 10             	add    $0x10,%esp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801037f5:	8b 45 08             	mov    0x8(%ebp),%eax
801037f8:	8b 00                	mov    (%eax),%eax
801037fa:	83 e0 06             	and    $0x6,%eax
801037fd:	83 f8 02             	cmp    $0x2,%eax
80103800:	75 e0                	jne    801037e2 <iderw+0xb2>
  }

  release(&idelock);
80103802:	83 ec 0c             	sub    $0xc,%esp
80103805:	68 80 96 12 80       	push   $0x80129680
8010380a:	e8 1a 2e 00 00       	call   80106629 <release>
8010380f:	83 c4 10             	add    $0x10,%esp
}
80103812:	90                   	nop
80103813:	c9                   	leave  
80103814:	c3                   	ret    

80103815 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80103815:	55                   	push   %ebp
80103816:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80103818:	a1 94 11 13 80       	mov    0x80131194,%eax
8010381d:	8b 55 08             	mov    0x8(%ebp),%edx
80103820:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80103822:	a1 94 11 13 80       	mov    0x80131194,%eax
80103827:	8b 40 10             	mov    0x10(%eax),%eax
}
8010382a:	5d                   	pop    %ebp
8010382b:	c3                   	ret    

8010382c <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
8010382c:	55                   	push   %ebp
8010382d:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
8010382f:	a1 94 11 13 80       	mov    0x80131194,%eax
80103834:	8b 55 08             	mov    0x8(%ebp),%edx
80103837:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80103839:	a1 94 11 13 80       	mov    0x80131194,%eax
8010383e:	8b 55 0c             	mov    0xc(%ebp),%edx
80103841:	89 50 10             	mov    %edx,0x10(%eax)
}
80103844:	90                   	nop
80103845:	5d                   	pop    %ebp
80103846:	c3                   	ret    

80103847 <ioapicinit>:

void
ioapicinit(void)
{
80103847:	55                   	push   %ebp
80103848:	89 e5                	mov    %esp,%ebp
8010384a:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
8010384d:	a1 c4 12 13 80       	mov    0x801312c4,%eax
80103852:	85 c0                	test   %eax,%eax
80103854:	0f 84 a0 00 00 00    	je     801038fa <ioapicinit+0xb3>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
8010385a:	c7 05 94 11 13 80 00 	movl   $0xfec00000,0x80131194
80103861:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80103864:	6a 01                	push   $0x1
80103866:	e8 aa ff ff ff       	call   80103815 <ioapicread>
8010386b:	83 c4 04             	add    $0x4,%esp
8010386e:	c1 e8 10             	shr    $0x10,%eax
80103871:	25 ff 00 00 00       	and    $0xff,%eax
80103876:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80103879:	6a 00                	push   $0x0
8010387b:	e8 95 ff ff ff       	call   80103815 <ioapicread>
80103880:	83 c4 04             	add    $0x4,%esp
80103883:	c1 e8 18             	shr    $0x18,%eax
80103886:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80103889:	0f b6 05 c0 12 13 80 	movzbl 0x801312c0,%eax
80103890:	0f b6 c0             	movzbl %al,%eax
80103893:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80103896:	74 10                	je     801038a8 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80103898:	83 ec 0c             	sub    $0xc,%esp
8010389b:	68 4c b4 10 80       	push   $0x8010b44c
801038a0:	e8 73 d5 ff ff       	call   80100e18 <cprintf>
801038a5:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801038a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801038af:	eb 3f                	jmp    801038f0 <ioapicinit+0xa9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801038b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038b4:	83 c0 20             	add    $0x20,%eax
801038b7:	0d 00 00 01 00       	or     $0x10000,%eax
801038bc:	89 c2                	mov    %eax,%edx
801038be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038c1:	83 c0 08             	add    $0x8,%eax
801038c4:	01 c0                	add    %eax,%eax
801038c6:	83 ec 08             	sub    $0x8,%esp
801038c9:	52                   	push   %edx
801038ca:	50                   	push   %eax
801038cb:	e8 5c ff ff ff       	call   8010382c <ioapicwrite>
801038d0:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
801038d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038d6:	83 c0 08             	add    $0x8,%eax
801038d9:	01 c0                	add    %eax,%eax
801038db:	83 c0 01             	add    $0x1,%eax
801038de:	83 ec 08             	sub    $0x8,%esp
801038e1:	6a 00                	push   $0x0
801038e3:	50                   	push   %eax
801038e4:	e8 43 ff ff ff       	call   8010382c <ioapicwrite>
801038e9:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
801038ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801038f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038f3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801038f6:	7e b9                	jle    801038b1 <ioapicinit+0x6a>
801038f8:	eb 01                	jmp    801038fb <ioapicinit+0xb4>
    return;
801038fa:	90                   	nop
  }
}
801038fb:	c9                   	leave  
801038fc:	c3                   	ret    

801038fd <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801038fd:	55                   	push   %ebp
801038fe:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80103900:	a1 c4 12 13 80       	mov    0x801312c4,%eax
80103905:	85 c0                	test   %eax,%eax
80103907:	74 39                	je     80103942 <ioapicenable+0x45>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80103909:	8b 45 08             	mov    0x8(%ebp),%eax
8010390c:	83 c0 20             	add    $0x20,%eax
8010390f:	89 c2                	mov    %eax,%edx
80103911:	8b 45 08             	mov    0x8(%ebp),%eax
80103914:	83 c0 08             	add    $0x8,%eax
80103917:	01 c0                	add    %eax,%eax
80103919:	52                   	push   %edx
8010391a:	50                   	push   %eax
8010391b:	e8 0c ff ff ff       	call   8010382c <ioapicwrite>
80103920:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80103923:	8b 45 0c             	mov    0xc(%ebp),%eax
80103926:	c1 e0 18             	shl    $0x18,%eax
80103929:	89 c2                	mov    %eax,%edx
8010392b:	8b 45 08             	mov    0x8(%ebp),%eax
8010392e:	83 c0 08             	add    $0x8,%eax
80103931:	01 c0                	add    %eax,%eax
80103933:	83 c0 01             	add    $0x1,%eax
80103936:	52                   	push   %edx
80103937:	50                   	push   %eax
80103938:	e8 ef fe ff ff       	call   8010382c <ioapicwrite>
8010393d:	83 c4 08             	add    $0x8,%esp
80103940:	eb 01                	jmp    80103943 <ioapicenable+0x46>
    return;
80103942:	90                   	nop
}
80103943:	c9                   	leave  
80103944:	c3                   	ret    

80103945 <kinsert>:
struct page_info {
};

int
kinsert(pde_t *pgdir, struct page_info *pp, char *va, int perm)
{
80103945:	55                   	push   %ebp
80103946:	89 e5                	mov    %esp,%ebp

	return 0; //Placeholder so the empty function will compile
80103948:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010394d:	5d                   	pop    %ebp
8010394e:	c3                   	ret    

8010394f <kremove>:

void
kremove(pde_t *pgdir, void *va)
{
8010394f:	55                   	push   %ebp
80103950:	89 e5                	mov    %esp,%ebp

}
80103952:	90                   	nop
80103953:	5d                   	pop    %ebp
80103954:	c3                   	ret    

80103955 <klookup>:

struct page_info *
klookup(pde_t *pgdir, void *va, pte_t **pte_store)
{
80103955:	55                   	push   %ebp
80103956:	89 e5                	mov    %esp,%ebp

	return 0;
80103958:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010395d:	5d                   	pop    %ebp
8010395e:	c3                   	ret    

8010395f <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
8010395f:	55                   	push   %ebp
80103960:	89 e5                	mov    %esp,%ebp
80103962:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80103965:	83 ec 08             	sub    $0x8,%esp
80103968:	68 7e b4 10 80       	push   $0x8010b47e
8010396d:	68 a0 11 13 80       	push   $0x801311a0
80103972:	e8 24 2c 00 00       	call   8010659b <initlock>
80103977:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
8010397a:	c7 05 d4 11 13 80 00 	movl   $0x0,0x801311d4
80103981:	00 00 00 
  freerange(vstart, vend);
80103984:	83 ec 08             	sub    $0x8,%esp
80103987:	ff 75 0c             	pushl  0xc(%ebp)
8010398a:	ff 75 08             	pushl  0x8(%ebp)
8010398d:	e8 2a 00 00 00       	call   801039bc <freerange>
80103992:	83 c4 10             	add    $0x10,%esp
}
80103995:	90                   	nop
80103996:	c9                   	leave  
80103997:	c3                   	ret    

80103998 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80103998:	55                   	push   %ebp
80103999:	89 e5                	mov    %esp,%ebp
8010399b:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
8010399e:	83 ec 08             	sub    $0x8,%esp
801039a1:	ff 75 0c             	pushl  0xc(%ebp)
801039a4:	ff 75 08             	pushl  0x8(%ebp)
801039a7:	e8 10 00 00 00       	call   801039bc <freerange>
801039ac:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
801039af:	c7 05 d4 11 13 80 01 	movl   $0x1,0x801311d4
801039b6:	00 00 00 
}
801039b9:	90                   	nop
801039ba:	c9                   	leave  
801039bb:	c3                   	ret    

801039bc <freerange>:

void
freerange(void *vstart, void *vend)
{
801039bc:	55                   	push   %ebp
801039bd:	89 e5                	mov    %esp,%ebp
801039bf:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801039c2:	8b 45 08             	mov    0x8(%ebp),%eax
801039c5:	05 ff 0f 00 00       	add    $0xfff,%eax
801039ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801039cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801039d2:	eb 15                	jmp    801039e9 <freerange+0x2d>
    kfree(p);
801039d4:	83 ec 0c             	sub    $0xc,%esp
801039d7:	ff 75 f4             	pushl  -0xc(%ebp)
801039da:	e8 1a 00 00 00       	call   801039f9 <kfree>
801039df:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801039e2:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801039e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039ec:	05 00 10 00 00       	add    $0x1000,%eax
801039f1:	39 45 0c             	cmp    %eax,0xc(%ebp)
801039f4:	73 de                	jae    801039d4 <freerange+0x18>
}
801039f6:	90                   	nop
801039f7:	c9                   	leave  
801039f8:	c3                   	ret    

801039f9 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801039f9:	55                   	push   %ebp
801039fa:	89 e5                	mov    %esp,%ebp
801039fc:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801039ff:	8b 45 08             	mov    0x8(%ebp),%eax
80103a02:	25 ff 0f 00 00       	and    $0xfff,%eax
80103a07:	85 c0                	test   %eax,%eax
80103a09:	75 18                	jne    80103a23 <kfree+0x2a>
80103a0b:	81 7d 08 68 4e 13 80 	cmpl   $0x80134e68,0x8(%ebp)
80103a12:	72 0f                	jb     80103a23 <kfree+0x2a>
80103a14:	8b 45 08             	mov    0x8(%ebp),%eax
80103a17:	05 00 00 00 80       	add    $0x80000000,%eax
80103a1c:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80103a21:	76 0d                	jbe    80103a30 <kfree+0x37>
    panic("kfree");
80103a23:	83 ec 0c             	sub    $0xc,%esp
80103a26:	68 83 b4 10 80       	push   $0x8010b483
80103a2b:	e8 0e d4 ff ff       	call   80100e3e <panic>

  // Fill with junk to catch dangling refs.
  //memset(v, 1, PGSIZE); //Commented out for the lab2 exercise

  if(kmem.use_lock)
80103a30:	a1 d4 11 13 80       	mov    0x801311d4,%eax
80103a35:	85 c0                	test   %eax,%eax
80103a37:	74 10                	je     80103a49 <kfree+0x50>
    acquire(&kmem.lock);
80103a39:	83 ec 0c             	sub    $0xc,%esp
80103a3c:	68 a0 11 13 80       	push   $0x801311a0
80103a41:	e8 77 2b 00 00       	call   801065bd <acquire>
80103a46:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80103a49:	8b 45 08             	mov    0x8(%ebp),%eax
80103a4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80103a4f:	8b 15 d8 11 13 80    	mov    0x801311d8,%edx
80103a55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a58:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80103a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a5d:	a3 d8 11 13 80       	mov    %eax,0x801311d8
  if(kmem.use_lock)
80103a62:	a1 d4 11 13 80       	mov    0x801311d4,%eax
80103a67:	85 c0                	test   %eax,%eax
80103a69:	74 10                	je     80103a7b <kfree+0x82>
    release(&kmem.lock);
80103a6b:	83 ec 0c             	sub    $0xc,%esp
80103a6e:	68 a0 11 13 80       	push   $0x801311a0
80103a73:	e8 b1 2b 00 00       	call   80106629 <release>
80103a78:	83 c4 10             	add    $0x10,%esp
}
80103a7b:	90                   	nop
80103a7c:	c9                   	leave  
80103a7d:	c3                   	ret    

80103a7e <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103a7e:	55                   	push   %ebp
80103a7f:	89 e5                	mov    %esp,%ebp
80103a81:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80103a84:	a1 d4 11 13 80       	mov    0x801311d4,%eax
80103a89:	85 c0                	test   %eax,%eax
80103a8b:	74 10                	je     80103a9d <kalloc+0x1f>
    acquire(&kmem.lock);
80103a8d:	83 ec 0c             	sub    $0xc,%esp
80103a90:	68 a0 11 13 80       	push   $0x801311a0
80103a95:	e8 23 2b 00 00       	call   801065bd <acquire>
80103a9a:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80103a9d:	a1 d8 11 13 80       	mov    0x801311d8,%eax
80103aa2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80103aa5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103aa9:	74 0a                	je     80103ab5 <kalloc+0x37>
    kmem.freelist = r->next;
80103aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aae:	8b 00                	mov    (%eax),%eax
80103ab0:	a3 d8 11 13 80       	mov    %eax,0x801311d8
  if(kmem.use_lock)
80103ab5:	a1 d4 11 13 80       	mov    0x801311d4,%eax
80103aba:	85 c0                	test   %eax,%eax
80103abc:	74 10                	je     80103ace <kalloc+0x50>
    release(&kmem.lock);
80103abe:	83 ec 0c             	sub    $0xc,%esp
80103ac1:	68 a0 11 13 80       	push   $0x801311a0
80103ac6:	e8 5e 2b 00 00       	call   80106629 <release>
80103acb:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80103ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103ad1:	c9                   	leave  
80103ad2:	c3                   	ret    

80103ad3 <inb>:
{
80103ad3:	55                   	push   %ebp
80103ad4:	89 e5                	mov    %esp,%ebp
80103ad6:	83 ec 14             	sub    $0x14,%esp
80103ad9:	8b 45 08             	mov    0x8(%ebp),%eax
80103adc:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103ae0:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103ae4:	89 c2                	mov    %eax,%edx
80103ae6:	ec                   	in     (%dx),%al
80103ae7:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103aea:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103aee:	c9                   	leave  
80103aef:	c3                   	ret    

80103af0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80103af6:	6a 64                	push   $0x64
80103af8:	e8 d6 ff ff ff       	call   80103ad3 <inb>
80103afd:	83 c4 04             	add    $0x4,%esp
80103b00:	0f b6 c0             	movzbl %al,%eax
80103b03:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80103b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b09:	83 e0 01             	and    $0x1,%eax
80103b0c:	85 c0                	test   %eax,%eax
80103b0e:	75 0a                	jne    80103b1a <kbdgetc+0x2a>
    return -1;
80103b10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b15:	e9 23 01 00 00       	jmp    80103c3d <kbdgetc+0x14d>
  data = inb(KBDATAP);
80103b1a:	6a 60                	push   $0x60
80103b1c:	e8 b2 ff ff ff       	call   80103ad3 <inb>
80103b21:	83 c4 04             	add    $0x4,%esp
80103b24:	0f b6 c0             	movzbl %al,%eax
80103b27:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80103b2a:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80103b31:	75 17                	jne    80103b4a <kbdgetc+0x5a>
    shift |= E0ESC;
80103b33:	a1 bc 96 12 80       	mov    0x801296bc,%eax
80103b38:	83 c8 40             	or     $0x40,%eax
80103b3b:	a3 bc 96 12 80       	mov    %eax,0x801296bc
    return 0;
80103b40:	b8 00 00 00 00       	mov    $0x0,%eax
80103b45:	e9 f3 00 00 00       	jmp    80103c3d <kbdgetc+0x14d>
  } else if(data & 0x80){
80103b4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b4d:	25 80 00 00 00       	and    $0x80,%eax
80103b52:	85 c0                	test   %eax,%eax
80103b54:	74 45                	je     80103b9b <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80103b56:	a1 bc 96 12 80       	mov    0x801296bc,%eax
80103b5b:	83 e0 40             	and    $0x40,%eax
80103b5e:	85 c0                	test   %eax,%eax
80103b60:	75 08                	jne    80103b6a <kbdgetc+0x7a>
80103b62:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b65:	83 e0 7f             	and    $0x7f,%eax
80103b68:	eb 03                	jmp    80103b6d <kbdgetc+0x7d>
80103b6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b6d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80103b70:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b73:	05 20 70 12 80       	add    $0x80127020,%eax
80103b78:	0f b6 00             	movzbl (%eax),%eax
80103b7b:	83 c8 40             	or     $0x40,%eax
80103b7e:	0f b6 c0             	movzbl %al,%eax
80103b81:	f7 d0                	not    %eax
80103b83:	89 c2                	mov    %eax,%edx
80103b85:	a1 bc 96 12 80       	mov    0x801296bc,%eax
80103b8a:	21 d0                	and    %edx,%eax
80103b8c:	a3 bc 96 12 80       	mov    %eax,0x801296bc
    return 0;
80103b91:	b8 00 00 00 00       	mov    $0x0,%eax
80103b96:	e9 a2 00 00 00       	jmp    80103c3d <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80103b9b:	a1 bc 96 12 80       	mov    0x801296bc,%eax
80103ba0:	83 e0 40             	and    $0x40,%eax
80103ba3:	85 c0                	test   %eax,%eax
80103ba5:	74 14                	je     80103bbb <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103ba7:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80103bae:	a1 bc 96 12 80       	mov    0x801296bc,%eax
80103bb3:	83 e0 bf             	and    $0xffffffbf,%eax
80103bb6:	a3 bc 96 12 80       	mov    %eax,0x801296bc
  }

  shift |= shiftcode[data];
80103bbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103bbe:	05 20 70 12 80       	add    $0x80127020,%eax
80103bc3:	0f b6 00             	movzbl (%eax),%eax
80103bc6:	0f b6 d0             	movzbl %al,%edx
80103bc9:	a1 bc 96 12 80       	mov    0x801296bc,%eax
80103bce:	09 d0                	or     %edx,%eax
80103bd0:	a3 bc 96 12 80       	mov    %eax,0x801296bc
  shift ^= togglecode[data];
80103bd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103bd8:	05 20 71 12 80       	add    $0x80127120,%eax
80103bdd:	0f b6 00             	movzbl (%eax),%eax
80103be0:	0f b6 d0             	movzbl %al,%edx
80103be3:	a1 bc 96 12 80       	mov    0x801296bc,%eax
80103be8:	31 d0                	xor    %edx,%eax
80103bea:	a3 bc 96 12 80       	mov    %eax,0x801296bc
  c = charcode[shift & (CTL | SHIFT)][data];
80103bef:	a1 bc 96 12 80       	mov    0x801296bc,%eax
80103bf4:	83 e0 03             	and    $0x3,%eax
80103bf7:	8b 14 85 20 75 12 80 	mov    -0x7fed8ae0(,%eax,4),%edx
80103bfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103c01:	01 d0                	add    %edx,%eax
80103c03:	0f b6 00             	movzbl (%eax),%eax
80103c06:	0f b6 c0             	movzbl %al,%eax
80103c09:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80103c0c:	a1 bc 96 12 80       	mov    0x801296bc,%eax
80103c11:	83 e0 08             	and    $0x8,%eax
80103c14:	85 c0                	test   %eax,%eax
80103c16:	74 22                	je     80103c3a <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80103c18:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80103c1c:	76 0c                	jbe    80103c2a <kbdgetc+0x13a>
80103c1e:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80103c22:	77 06                	ja     80103c2a <kbdgetc+0x13a>
      c += 'A' - 'a';
80103c24:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80103c28:	eb 10                	jmp    80103c3a <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80103c2a:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80103c2e:	76 0a                	jbe    80103c3a <kbdgetc+0x14a>
80103c30:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80103c34:	77 04                	ja     80103c3a <kbdgetc+0x14a>
      c += 'a' - 'A';
80103c36:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80103c3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103c3d:	c9                   	leave  
80103c3e:	c3                   	ret    

80103c3f <kbdintr>:

void
kbdintr(void)
{
80103c3f:	55                   	push   %ebp
80103c40:	89 e5                	mov    %esp,%ebp
80103c42:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80103c45:	83 ec 0c             	sub    $0xc,%esp
80103c48:	68 f0 3a 10 80       	push   $0x80103af0
80103c4d:	e8 29 d5 ff ff       	call   8010117b <consoleintr>
80103c52:	83 c4 10             	add    $0x10,%esp
}
80103c55:	90                   	nop
80103c56:	c9                   	leave  
80103c57:	c3                   	ret    

80103c58 <inb>:
{
80103c58:	55                   	push   %ebp
80103c59:	89 e5                	mov    %esp,%ebp
80103c5b:	83 ec 14             	sub    $0x14,%esp
80103c5e:	8b 45 08             	mov    0x8(%ebp),%eax
80103c61:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103c65:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103c69:	89 c2                	mov    %eax,%edx
80103c6b:	ec                   	in     (%dx),%al
80103c6c:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103c6f:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103c73:	c9                   	leave  
80103c74:	c3                   	ret    

80103c75 <outb>:
{
80103c75:	55                   	push   %ebp
80103c76:	89 e5                	mov    %esp,%ebp
80103c78:	83 ec 08             	sub    $0x8,%esp
80103c7b:	8b 55 08             	mov    0x8(%ebp),%edx
80103c7e:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c81:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103c85:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103c88:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103c8c:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103c90:	ee                   	out    %al,(%dx)
}
80103c91:	90                   	nop
80103c92:	c9                   	leave  
80103c93:	c3                   	ret    

80103c94 <readeflags>:
{
80103c94:	55                   	push   %ebp
80103c95:	89 e5                	mov    %esp,%ebp
80103c97:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c9a:	9c                   	pushf  
80103c9b:	58                   	pop    %eax
80103c9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80103c9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103ca2:	c9                   	leave  
80103ca3:	c3                   	ret    

80103ca4 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80103ca4:	55                   	push   %ebp
80103ca5:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80103ca7:	a1 dc 11 13 80       	mov    0x801311dc,%eax
80103cac:	8b 55 08             	mov    0x8(%ebp),%edx
80103caf:	c1 e2 02             	shl    $0x2,%edx
80103cb2:	01 c2                	add    %eax,%edx
80103cb4:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cb7:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80103cb9:	a1 dc 11 13 80       	mov    0x801311dc,%eax
80103cbe:	83 c0 20             	add    $0x20,%eax
80103cc1:	8b 00                	mov    (%eax),%eax
}
80103cc3:	90                   	nop
80103cc4:	5d                   	pop    %ebp
80103cc5:	c3                   	ret    

80103cc6 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80103cc6:	55                   	push   %ebp
80103cc7:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80103cc9:	a1 dc 11 13 80       	mov    0x801311dc,%eax
80103cce:	85 c0                	test   %eax,%eax
80103cd0:	0f 84 0b 01 00 00    	je     80103de1 <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80103cd6:	68 3f 01 00 00       	push   $0x13f
80103cdb:	6a 3c                	push   $0x3c
80103cdd:	e8 c2 ff ff ff       	call   80103ca4 <lapicw>
80103ce2:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80103ce5:	6a 0b                	push   $0xb
80103ce7:	68 f8 00 00 00       	push   $0xf8
80103cec:	e8 b3 ff ff ff       	call   80103ca4 <lapicw>
80103cf1:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80103cf4:	68 20 00 02 00       	push   $0x20020
80103cf9:	68 c8 00 00 00       	push   $0xc8
80103cfe:	e8 a1 ff ff ff       	call   80103ca4 <lapicw>
80103d03:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000);
80103d06:	68 80 96 98 00       	push   $0x989680
80103d0b:	68 e0 00 00 00       	push   $0xe0
80103d10:	e8 8f ff ff ff       	call   80103ca4 <lapicw>
80103d15:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80103d18:	68 00 00 01 00       	push   $0x10000
80103d1d:	68 d4 00 00 00       	push   $0xd4
80103d22:	e8 7d ff ff ff       	call   80103ca4 <lapicw>
80103d27:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80103d2a:	68 00 00 01 00       	push   $0x10000
80103d2f:	68 d8 00 00 00       	push   $0xd8
80103d34:	e8 6b ff ff ff       	call   80103ca4 <lapicw>
80103d39:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80103d3c:	a1 dc 11 13 80       	mov    0x801311dc,%eax
80103d41:	83 c0 30             	add    $0x30,%eax
80103d44:	8b 00                	mov    (%eax),%eax
80103d46:	c1 e8 10             	shr    $0x10,%eax
80103d49:	0f b6 c0             	movzbl %al,%eax
80103d4c:	83 f8 03             	cmp    $0x3,%eax
80103d4f:	76 12                	jbe    80103d63 <lapicinit+0x9d>
    lapicw(PCINT, MASKED);
80103d51:	68 00 00 01 00       	push   $0x10000
80103d56:	68 d0 00 00 00       	push   $0xd0
80103d5b:	e8 44 ff ff ff       	call   80103ca4 <lapicw>
80103d60:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80103d63:	6a 33                	push   $0x33
80103d65:	68 dc 00 00 00       	push   $0xdc
80103d6a:	e8 35 ff ff ff       	call   80103ca4 <lapicw>
80103d6f:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80103d72:	6a 00                	push   $0x0
80103d74:	68 a0 00 00 00       	push   $0xa0
80103d79:	e8 26 ff ff ff       	call   80103ca4 <lapicw>
80103d7e:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80103d81:	6a 00                	push   $0x0
80103d83:	68 a0 00 00 00       	push   $0xa0
80103d88:	e8 17 ff ff ff       	call   80103ca4 <lapicw>
80103d8d:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80103d90:	6a 00                	push   $0x0
80103d92:	6a 2c                	push   $0x2c
80103d94:	e8 0b ff ff ff       	call   80103ca4 <lapicw>
80103d99:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80103d9c:	6a 00                	push   $0x0
80103d9e:	68 c4 00 00 00       	push   $0xc4
80103da3:	e8 fc fe ff ff       	call   80103ca4 <lapicw>
80103da8:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80103dab:	68 00 85 08 00       	push   $0x88500
80103db0:	68 c0 00 00 00       	push   $0xc0
80103db5:	e8 ea fe ff ff       	call   80103ca4 <lapicw>
80103dba:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80103dbd:	90                   	nop
80103dbe:	a1 dc 11 13 80       	mov    0x801311dc,%eax
80103dc3:	05 00 03 00 00       	add    $0x300,%eax
80103dc8:	8b 00                	mov    (%eax),%eax
80103dca:	25 00 10 00 00       	and    $0x1000,%eax
80103dcf:	85 c0                	test   %eax,%eax
80103dd1:	75 eb                	jne    80103dbe <lapicinit+0xf8>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80103dd3:	6a 00                	push   $0x0
80103dd5:	6a 20                	push   $0x20
80103dd7:	e8 c8 fe ff ff       	call   80103ca4 <lapicw>
80103ddc:	83 c4 08             	add    $0x8,%esp
80103ddf:	eb 01                	jmp    80103de2 <lapicinit+0x11c>
    return;
80103de1:	90                   	nop
}
80103de2:	c9                   	leave  
80103de3:	c3                   	ret    

80103de4 <cpunum>:

int
cpunum(void)
{
80103de4:	55                   	push   %ebp
80103de5:	89 e5                	mov    %esp,%ebp
80103de7:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80103dea:	e8 a5 fe ff ff       	call   80103c94 <readeflags>
80103def:	25 00 02 00 00       	and    $0x200,%eax
80103df4:	85 c0                	test   %eax,%eax
80103df6:	74 26                	je     80103e1e <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80103df8:	a1 c0 96 12 80       	mov    0x801296c0,%eax
80103dfd:	8d 50 01             	lea    0x1(%eax),%edx
80103e00:	89 15 c0 96 12 80    	mov    %edx,0x801296c0
80103e06:	85 c0                	test   %eax,%eax
80103e08:	75 14                	jne    80103e1e <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80103e0a:	8b 45 04             	mov    0x4(%ebp),%eax
80103e0d:	83 ec 08             	sub    $0x8,%esp
80103e10:	50                   	push   %eax
80103e11:	68 8c b4 10 80       	push   $0x8010b48c
80103e16:	e8 fd cf ff ff       	call   80100e18 <cprintf>
80103e1b:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if (!lapic)
80103e1e:	a1 dc 11 13 80       	mov    0x801311dc,%eax
80103e23:	85 c0                	test   %eax,%eax
80103e25:	75 07                	jne    80103e2e <cpunum+0x4a>
    return 0;
80103e27:	b8 00 00 00 00       	mov    $0x0,%eax
80103e2c:	eb 52                	jmp    80103e80 <cpunum+0x9c>

  apicid = lapic[ID] >> 24;
80103e2e:	a1 dc 11 13 80       	mov    0x801311dc,%eax
80103e33:	83 c0 20             	add    $0x20,%eax
80103e36:	8b 00                	mov    (%eax),%eax
80103e38:	c1 e8 18             	shr    $0x18,%eax
80103e3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < ncpu; ++i) {
80103e3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103e45:	eb 22                	jmp    80103e69 <cpunum+0x85>
    if (cpus[i].apicid == apicid)
80103e47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e4a:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103e50:	05 e0 12 13 80       	add    $0x801312e0,%eax
80103e55:	0f b6 00             	movzbl (%eax),%eax
80103e58:	0f b6 c0             	movzbl %al,%eax
80103e5b:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80103e5e:	75 05                	jne    80103e65 <cpunum+0x81>
      return i;
80103e60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e63:	eb 1b                	jmp    80103e80 <cpunum+0x9c>
  for (i = 0; i < ncpu; ++i) {
80103e65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103e69:	a1 c0 18 13 80       	mov    0x801318c0,%eax
80103e6e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103e71:	7c d4                	jl     80103e47 <cpunum+0x63>
  }
  panic("unknown apicid\n");
80103e73:	83 ec 0c             	sub    $0xc,%esp
80103e76:	68 b8 b4 10 80       	push   $0x8010b4b8
80103e7b:	e8 be cf ff ff       	call   80100e3e <panic>
}
80103e80:	c9                   	leave  
80103e81:	c3                   	ret    

80103e82 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80103e82:	55                   	push   %ebp
80103e83:	89 e5                	mov    %esp,%ebp
  if(lapic)
80103e85:	a1 dc 11 13 80       	mov    0x801311dc,%eax
80103e8a:	85 c0                	test   %eax,%eax
80103e8c:	74 0c                	je     80103e9a <lapiceoi+0x18>
    lapicw(EOI, 0);
80103e8e:	6a 00                	push   $0x0
80103e90:	6a 2c                	push   $0x2c
80103e92:	e8 0d fe ff ff       	call   80103ca4 <lapicw>
80103e97:	83 c4 08             	add    $0x8,%esp
}
80103e9a:	90                   	nop
80103e9b:	c9                   	leave  
80103e9c:	c3                   	ret    

80103e9d <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103e9d:	55                   	push   %ebp
80103e9e:	89 e5                	mov    %esp,%ebp
}
80103ea0:	90                   	nop
80103ea1:	5d                   	pop    %ebp
80103ea2:	c3                   	ret    

80103ea3 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103ea3:	55                   	push   %ebp
80103ea4:	89 e5                	mov    %esp,%ebp
80103ea6:	83 ec 14             	sub    $0x14,%esp
80103ea9:	8b 45 08             	mov    0x8(%ebp),%eax
80103eac:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
80103eaf:	6a 0f                	push   $0xf
80103eb1:	6a 70                	push   $0x70
80103eb3:	e8 bd fd ff ff       	call   80103c75 <outb>
80103eb8:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
80103ebb:	6a 0a                	push   $0xa
80103ebd:	6a 71                	push   $0x71
80103ebf:	e8 b1 fd ff ff       	call   80103c75 <outb>
80103ec4:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103ec7:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103ece:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103ed1:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80103ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ed9:	c1 e8 04             	shr    $0x4,%eax
80103edc:	89 c2                	mov    %eax,%edx
80103ede:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103ee1:	83 c0 02             	add    $0x2,%eax
80103ee4:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103ee7:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103eeb:	c1 e0 18             	shl    $0x18,%eax
80103eee:	50                   	push   %eax
80103eef:	68 c4 00 00 00       	push   $0xc4
80103ef4:	e8 ab fd ff ff       	call   80103ca4 <lapicw>
80103ef9:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103efc:	68 00 c5 00 00       	push   $0xc500
80103f01:	68 c0 00 00 00       	push   $0xc0
80103f06:	e8 99 fd ff ff       	call   80103ca4 <lapicw>
80103f0b:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103f0e:	68 c8 00 00 00       	push   $0xc8
80103f13:	e8 85 ff ff ff       	call   80103e9d <microdelay>
80103f18:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103f1b:	68 00 85 00 00       	push   $0x8500
80103f20:	68 c0 00 00 00       	push   $0xc0
80103f25:	e8 7a fd ff ff       	call   80103ca4 <lapicw>
80103f2a:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103f2d:	6a 64                	push   $0x64
80103f2f:	e8 69 ff ff ff       	call   80103e9d <microdelay>
80103f34:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103f37:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103f3e:	eb 3d                	jmp    80103f7d <lapicstartap+0xda>
    lapicw(ICRHI, apicid<<24);
80103f40:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103f44:	c1 e0 18             	shl    $0x18,%eax
80103f47:	50                   	push   %eax
80103f48:	68 c4 00 00 00       	push   $0xc4
80103f4d:	e8 52 fd ff ff       	call   80103ca4 <lapicw>
80103f52:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
80103f55:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f58:	c1 e8 0c             	shr    $0xc,%eax
80103f5b:	80 cc 06             	or     $0x6,%ah
80103f5e:	50                   	push   %eax
80103f5f:	68 c0 00 00 00       	push   $0xc0
80103f64:	e8 3b fd ff ff       	call   80103ca4 <lapicw>
80103f69:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
80103f6c:	68 c8 00 00 00       	push   $0xc8
80103f71:	e8 27 ff ff ff       	call   80103e9d <microdelay>
80103f76:	83 c4 04             	add    $0x4,%esp
  for(i = 0; i < 2; i++){
80103f79:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103f7d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103f81:	7e bd                	jle    80103f40 <lapicstartap+0x9d>
  }
}
80103f83:	90                   	nop
80103f84:	c9                   	leave  
80103f85:	c3                   	ret    

80103f86 <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
80103f86:	55                   	push   %ebp
80103f87:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
80103f89:	8b 45 08             	mov    0x8(%ebp),%eax
80103f8c:	0f b6 c0             	movzbl %al,%eax
80103f8f:	50                   	push   %eax
80103f90:	6a 70                	push   $0x70
80103f92:	e8 de fc ff ff       	call   80103c75 <outb>
80103f97:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103f9a:	68 c8 00 00 00       	push   $0xc8
80103f9f:	e8 f9 fe ff ff       	call   80103e9d <microdelay>
80103fa4:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
80103fa7:	6a 71                	push   $0x71
80103fa9:	e8 aa fc ff ff       	call   80103c58 <inb>
80103fae:	83 c4 04             	add    $0x4,%esp
80103fb1:	0f b6 c0             	movzbl %al,%eax
}
80103fb4:	c9                   	leave  
80103fb5:	c3                   	ret    

80103fb6 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
80103fb6:	55                   	push   %ebp
80103fb7:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
80103fb9:	6a 00                	push   $0x0
80103fbb:	e8 c6 ff ff ff       	call   80103f86 <cmos_read>
80103fc0:	83 c4 04             	add    $0x4,%esp
80103fc3:	89 c2                	mov    %eax,%edx
80103fc5:	8b 45 08             	mov    0x8(%ebp),%eax
80103fc8:	89 10                	mov    %edx,(%eax)
  r->minute = cmos_read(MINS);
80103fca:	6a 02                	push   $0x2
80103fcc:	e8 b5 ff ff ff       	call   80103f86 <cmos_read>
80103fd1:	83 c4 04             	add    $0x4,%esp
80103fd4:	89 c2                	mov    %eax,%edx
80103fd6:	8b 45 08             	mov    0x8(%ebp),%eax
80103fd9:	89 50 04             	mov    %edx,0x4(%eax)
  r->hour   = cmos_read(HOURS);
80103fdc:	6a 04                	push   $0x4
80103fde:	e8 a3 ff ff ff       	call   80103f86 <cmos_read>
80103fe3:	83 c4 04             	add    $0x4,%esp
80103fe6:	89 c2                	mov    %eax,%edx
80103fe8:	8b 45 08             	mov    0x8(%ebp),%eax
80103feb:	89 50 08             	mov    %edx,0x8(%eax)
  r->day    = cmos_read(DAY);
80103fee:	6a 07                	push   $0x7
80103ff0:	e8 91 ff ff ff       	call   80103f86 <cmos_read>
80103ff5:	83 c4 04             	add    $0x4,%esp
80103ff8:	89 c2                	mov    %eax,%edx
80103ffa:	8b 45 08             	mov    0x8(%ebp),%eax
80103ffd:	89 50 0c             	mov    %edx,0xc(%eax)
  r->month  = cmos_read(MONTH);
80104000:	6a 08                	push   $0x8
80104002:	e8 7f ff ff ff       	call   80103f86 <cmos_read>
80104007:	83 c4 04             	add    $0x4,%esp
8010400a:	89 c2                	mov    %eax,%edx
8010400c:	8b 45 08             	mov    0x8(%ebp),%eax
8010400f:	89 50 10             	mov    %edx,0x10(%eax)
  r->year   = cmos_read(YEAR);
80104012:	6a 09                	push   $0x9
80104014:	e8 6d ff ff ff       	call   80103f86 <cmos_read>
80104019:	83 c4 04             	add    $0x4,%esp
8010401c:	89 c2                	mov    %eax,%edx
8010401e:	8b 45 08             	mov    0x8(%ebp),%eax
80104021:	89 50 14             	mov    %edx,0x14(%eax)
}
80104024:	90                   	nop
80104025:	c9                   	leave  
80104026:	c3                   	ret    

80104027 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80104027:	55                   	push   %ebp
80104028:	89 e5                	mov    %esp,%ebp
8010402a:	83 ec 48             	sub    $0x48,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
8010402d:	6a 0b                	push   $0xb
8010402f:	e8 52 ff ff ff       	call   80103f86 <cmos_read>
80104034:	83 c4 04             	add    $0x4,%esp
80104037:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
8010403a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010403d:	83 e0 04             	and    $0x4,%eax
80104040:	85 c0                	test   %eax,%eax
80104042:	0f 94 c0             	sete   %al
80104045:	0f b6 c0             	movzbl %al,%eax
80104048:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
8010404b:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010404e:	50                   	push   %eax
8010404f:	e8 62 ff ff ff       	call   80103fb6 <fill_rtcdate>
80104054:	83 c4 04             	add    $0x4,%esp
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80104057:	6a 0a                	push   $0xa
80104059:	e8 28 ff ff ff       	call   80103f86 <cmos_read>
8010405e:	83 c4 04             	add    $0x4,%esp
80104061:	25 80 00 00 00       	and    $0x80,%eax
80104066:	85 c0                	test   %eax,%eax
80104068:	75 27                	jne    80104091 <cmostime+0x6a>
        continue;
    fill_rtcdate(&t2);
8010406a:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010406d:	50                   	push   %eax
8010406e:	e8 43 ff ff ff       	call   80103fb6 <fill_rtcdate>
80104073:	83 c4 04             	add    $0x4,%esp
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80104076:	83 ec 04             	sub    $0x4,%esp
80104079:	6a 18                	push   $0x18
8010407b:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010407e:	50                   	push   %eax
8010407f:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104082:	50                   	push   %eax
80104083:	e8 12 28 00 00       	call   8010689a <memcmp>
80104088:	83 c4 10             	add    $0x10,%esp
8010408b:	85 c0                	test   %eax,%eax
8010408d:	74 05                	je     80104094 <cmostime+0x6d>
8010408f:	eb ba                	jmp    8010404b <cmostime+0x24>
        continue;
80104091:	90                   	nop
    fill_rtcdate(&t1);
80104092:	eb b7                	jmp    8010404b <cmostime+0x24>
      break;
80104094:	90                   	nop
  }

  // convert
  if(bcd) {
80104095:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104099:	0f 84 b4 00 00 00    	je     80104153 <cmostime+0x12c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010409f:	8b 45 d8             	mov    -0x28(%ebp),%eax
801040a2:	c1 e8 04             	shr    $0x4,%eax
801040a5:	89 c2                	mov    %eax,%edx
801040a7:	89 d0                	mov    %edx,%eax
801040a9:	c1 e0 02             	shl    $0x2,%eax
801040ac:	01 d0                	add    %edx,%eax
801040ae:	01 c0                	add    %eax,%eax
801040b0:	89 c2                	mov    %eax,%edx
801040b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801040b5:	83 e0 0f             	and    $0xf,%eax
801040b8:	01 d0                	add    %edx,%eax
801040ba:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
801040bd:	8b 45 dc             	mov    -0x24(%ebp),%eax
801040c0:	c1 e8 04             	shr    $0x4,%eax
801040c3:	89 c2                	mov    %eax,%edx
801040c5:	89 d0                	mov    %edx,%eax
801040c7:	c1 e0 02             	shl    $0x2,%eax
801040ca:	01 d0                	add    %edx,%eax
801040cc:	01 c0                	add    %eax,%eax
801040ce:	89 c2                	mov    %eax,%edx
801040d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801040d3:	83 e0 0f             	and    $0xf,%eax
801040d6:	01 d0                	add    %edx,%eax
801040d8:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
801040db:	8b 45 e0             	mov    -0x20(%ebp),%eax
801040de:	c1 e8 04             	shr    $0x4,%eax
801040e1:	89 c2                	mov    %eax,%edx
801040e3:	89 d0                	mov    %edx,%eax
801040e5:	c1 e0 02             	shl    $0x2,%eax
801040e8:	01 d0                	add    %edx,%eax
801040ea:	01 c0                	add    %eax,%eax
801040ec:	89 c2                	mov    %eax,%edx
801040ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
801040f1:	83 e0 0f             	and    $0xf,%eax
801040f4:	01 d0                	add    %edx,%eax
801040f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
801040f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801040fc:	c1 e8 04             	shr    $0x4,%eax
801040ff:	89 c2                	mov    %eax,%edx
80104101:	89 d0                	mov    %edx,%eax
80104103:	c1 e0 02             	shl    $0x2,%eax
80104106:	01 d0                	add    %edx,%eax
80104108:	01 c0                	add    %eax,%eax
8010410a:	89 c2                	mov    %eax,%edx
8010410c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010410f:	83 e0 0f             	and    $0xf,%eax
80104112:	01 d0                	add    %edx,%eax
80104114:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
80104117:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010411a:	c1 e8 04             	shr    $0x4,%eax
8010411d:	89 c2                	mov    %eax,%edx
8010411f:	89 d0                	mov    %edx,%eax
80104121:	c1 e0 02             	shl    $0x2,%eax
80104124:	01 d0                	add    %edx,%eax
80104126:	01 c0                	add    %eax,%eax
80104128:	89 c2                	mov    %eax,%edx
8010412a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010412d:	83 e0 0f             	and    $0xf,%eax
80104130:	01 d0                	add    %edx,%eax
80104132:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
80104135:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104138:	c1 e8 04             	shr    $0x4,%eax
8010413b:	89 c2                	mov    %eax,%edx
8010413d:	89 d0                	mov    %edx,%eax
8010413f:	c1 e0 02             	shl    $0x2,%eax
80104142:	01 d0                	add    %edx,%eax
80104144:	01 c0                	add    %eax,%eax
80104146:	89 c2                	mov    %eax,%edx
80104148:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010414b:	83 e0 0f             	and    $0xf,%eax
8010414e:	01 d0                	add    %edx,%eax
80104150:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
80104153:	8b 45 08             	mov    0x8(%ebp),%eax
80104156:	8b 55 d8             	mov    -0x28(%ebp),%edx
80104159:	89 10                	mov    %edx,(%eax)
8010415b:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010415e:	89 50 04             	mov    %edx,0x4(%eax)
80104161:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104164:	89 50 08             	mov    %edx,0x8(%eax)
80104167:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010416a:	89 50 0c             	mov    %edx,0xc(%eax)
8010416d:	8b 55 e8             	mov    -0x18(%ebp),%edx
80104170:	89 50 10             	mov    %edx,0x10(%eax)
80104173:	8b 55 ec             	mov    -0x14(%ebp),%edx
80104176:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
80104179:	8b 45 08             	mov    0x8(%ebp),%eax
8010417c:	8b 40 14             	mov    0x14(%eax),%eax
8010417f:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
80104185:	8b 45 08             	mov    0x8(%ebp),%eax
80104188:	89 50 14             	mov    %edx,0x14(%eax)
}
8010418b:	90                   	nop
8010418c:	c9                   	leave  
8010418d:	c3                   	ret    

8010418e <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
8010418e:	55                   	push   %ebp
8010418f:	89 e5                	mov    %esp,%ebp
80104191:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80104194:	83 ec 08             	sub    $0x8,%esp
80104197:	68 c8 b4 10 80       	push   $0x8010b4c8
8010419c:	68 e0 11 13 80       	push   $0x801311e0
801041a1:	e8 f5 23 00 00       	call   8010659b <initlock>
801041a6:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
801041a9:	83 ec 08             	sub    $0x8,%esp
801041ac:	8d 45 dc             	lea    -0x24(%ebp),%eax
801041af:	50                   	push   %eax
801041b0:	ff 75 08             	pushl  0x8(%ebp)
801041b3:	e8 83 dd ff ff       	call   80101f3b <readsb>
801041b8:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
801041bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801041be:	a3 14 12 13 80       	mov    %eax,0x80131214
  log.size = sb.nlog;
801041c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801041c6:	a3 18 12 13 80       	mov    %eax,0x80131218
  log.dev = dev;
801041cb:	8b 45 08             	mov    0x8(%ebp),%eax
801041ce:	a3 24 12 13 80       	mov    %eax,0x80131224
  recover_from_log();
801041d3:	e8 b2 01 00 00       	call   8010438a <recover_from_log>
}
801041d8:	90                   	nop
801041d9:	c9                   	leave  
801041da:	c3                   	ret    

801041db <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801041db:	55                   	push   %ebp
801041dc:	89 e5                	mov    %esp,%ebp
801041de:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801041e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801041e8:	e9 95 00 00 00       	jmp    80104282 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801041ed:	8b 15 14 12 13 80    	mov    0x80131214,%edx
801041f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041f6:	01 d0                	add    %edx,%eax
801041f8:	83 c0 01             	add    $0x1,%eax
801041fb:	89 c2                	mov    %eax,%edx
801041fd:	a1 24 12 13 80       	mov    0x80131224,%eax
80104202:	83 ec 08             	sub    $0x8,%esp
80104205:	52                   	push   %edx
80104206:	50                   	push   %eax
80104207:	e8 b7 c9 ff ff       	call   80100bc3 <bread>
8010420c:	83 c4 10             	add    $0x10,%esp
8010420f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80104212:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104215:	83 c0 10             	add    $0x10,%eax
80104218:	8b 04 85 ec 11 13 80 	mov    -0x7fecee14(,%eax,4),%eax
8010421f:	89 c2                	mov    %eax,%edx
80104221:	a1 24 12 13 80       	mov    0x80131224,%eax
80104226:	83 ec 08             	sub    $0x8,%esp
80104229:	52                   	push   %edx
8010422a:	50                   	push   %eax
8010422b:	e8 93 c9 ff ff       	call   80100bc3 <bread>
80104230:	83 c4 10             	add    $0x10,%esp
80104233:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80104236:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104239:	8d 50 18             	lea    0x18(%eax),%edx
8010423c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010423f:	83 c0 18             	add    $0x18,%eax
80104242:	83 ec 04             	sub    $0x4,%esp
80104245:	68 00 02 00 00       	push   $0x200
8010424a:	52                   	push   %edx
8010424b:	50                   	push   %eax
8010424c:	e8 a1 26 00 00       	call   801068f2 <memmove>
80104251:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80104254:	83 ec 0c             	sub    $0xc,%esp
80104257:	ff 75 ec             	pushl  -0x14(%ebp)
8010425a:	e8 9d c9 ff ff       	call   80100bfc <bwrite>
8010425f:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf);
80104262:	83 ec 0c             	sub    $0xc,%esp
80104265:	ff 75 f0             	pushl  -0x10(%ebp)
80104268:	e8 ce c9 ff ff       	call   80100c3b <brelse>
8010426d:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
80104270:	83 ec 0c             	sub    $0xc,%esp
80104273:	ff 75 ec             	pushl  -0x14(%ebp)
80104276:	e8 c0 c9 ff ff       	call   80100c3b <brelse>
8010427b:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
8010427e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104282:	a1 28 12 13 80       	mov    0x80131228,%eax
80104287:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010428a:	0f 8c 5d ff ff ff    	jl     801041ed <install_trans+0x12>
  }
}
80104290:	90                   	nop
80104291:	c9                   	leave  
80104292:	c3                   	ret    

80104293 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80104293:	55                   	push   %ebp
80104294:	89 e5                	mov    %esp,%ebp
80104296:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80104299:	a1 14 12 13 80       	mov    0x80131214,%eax
8010429e:	89 c2                	mov    %eax,%edx
801042a0:	a1 24 12 13 80       	mov    0x80131224,%eax
801042a5:	83 ec 08             	sub    $0x8,%esp
801042a8:	52                   	push   %edx
801042a9:	50                   	push   %eax
801042aa:	e8 14 c9 ff ff       	call   80100bc3 <bread>
801042af:	83 c4 10             	add    $0x10,%esp
801042b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801042b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801042b8:	83 c0 18             	add    $0x18,%eax
801042bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
801042be:	8b 45 ec             	mov    -0x14(%ebp),%eax
801042c1:	8b 00                	mov    (%eax),%eax
801042c3:	a3 28 12 13 80       	mov    %eax,0x80131228
  for (i = 0; i < log.lh.n; i++) {
801042c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801042cf:	eb 1b                	jmp    801042ec <read_head+0x59>
    log.lh.block[i] = lh->block[i];
801042d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801042d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042d7:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
801042db:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042de:	83 c2 10             	add    $0x10,%edx
801042e1:	89 04 95 ec 11 13 80 	mov    %eax,-0x7fecee14(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801042e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042ec:	a1 28 12 13 80       	mov    0x80131228,%eax
801042f1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801042f4:	7c db                	jl     801042d1 <read_head+0x3e>
  }
  brelse(buf);
801042f6:	83 ec 0c             	sub    $0xc,%esp
801042f9:	ff 75 f0             	pushl  -0x10(%ebp)
801042fc:	e8 3a c9 ff ff       	call   80100c3b <brelse>
80104301:	83 c4 10             	add    $0x10,%esp
}
80104304:	90                   	nop
80104305:	c9                   	leave  
80104306:	c3                   	ret    

80104307 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80104307:	55                   	push   %ebp
80104308:	89 e5                	mov    %esp,%ebp
8010430a:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
8010430d:	a1 14 12 13 80       	mov    0x80131214,%eax
80104312:	89 c2                	mov    %eax,%edx
80104314:	a1 24 12 13 80       	mov    0x80131224,%eax
80104319:	83 ec 08             	sub    $0x8,%esp
8010431c:	52                   	push   %edx
8010431d:	50                   	push   %eax
8010431e:	e8 a0 c8 ff ff       	call   80100bc3 <bread>
80104323:	83 c4 10             	add    $0x10,%esp
80104326:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80104329:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010432c:	83 c0 18             	add    $0x18,%eax
8010432f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80104332:	8b 15 28 12 13 80    	mov    0x80131228,%edx
80104338:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010433b:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
8010433d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104344:	eb 1b                	jmp    80104361 <write_head+0x5a>
    hb->block[i] = log.lh.block[i];
80104346:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104349:	83 c0 10             	add    $0x10,%eax
8010434c:	8b 0c 85 ec 11 13 80 	mov    -0x7fecee14(,%eax,4),%ecx
80104353:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104356:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104359:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010435d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104361:	a1 28 12 13 80       	mov    0x80131228,%eax
80104366:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104369:	7c db                	jl     80104346 <write_head+0x3f>
  }
  bwrite(buf);
8010436b:	83 ec 0c             	sub    $0xc,%esp
8010436e:	ff 75 f0             	pushl  -0x10(%ebp)
80104371:	e8 86 c8 ff ff       	call   80100bfc <bwrite>
80104376:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80104379:	83 ec 0c             	sub    $0xc,%esp
8010437c:	ff 75 f0             	pushl  -0x10(%ebp)
8010437f:	e8 b7 c8 ff ff       	call   80100c3b <brelse>
80104384:	83 c4 10             	add    $0x10,%esp
}
80104387:	90                   	nop
80104388:	c9                   	leave  
80104389:	c3                   	ret    

8010438a <recover_from_log>:

static void
recover_from_log(void)
{
8010438a:	55                   	push   %ebp
8010438b:	89 e5                	mov    %esp,%ebp
8010438d:	83 ec 08             	sub    $0x8,%esp
  read_head();
80104390:	e8 fe fe ff ff       	call   80104293 <read_head>
  install_trans(); // if committed, copy from log to disk
80104395:	e8 41 fe ff ff       	call   801041db <install_trans>
  log.lh.n = 0;
8010439a:	c7 05 28 12 13 80 00 	movl   $0x0,0x80131228
801043a1:	00 00 00 
  write_head(); // clear the log
801043a4:	e8 5e ff ff ff       	call   80104307 <write_head>
}
801043a9:	90                   	nop
801043aa:	c9                   	leave  
801043ab:	c3                   	ret    

801043ac <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
801043ac:	55                   	push   %ebp
801043ad:	89 e5                	mov    %esp,%ebp
801043af:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
801043b2:	83 ec 0c             	sub    $0xc,%esp
801043b5:	68 e0 11 13 80       	push   $0x801311e0
801043ba:	e8 fe 21 00 00       	call   801065bd <acquire>
801043bf:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
801043c2:	a1 20 12 13 80       	mov    0x80131220,%eax
801043c7:	85 c0                	test   %eax,%eax
801043c9:	74 17                	je     801043e2 <begin_op+0x36>
      sleep(&log, &log.lock);
801043cb:	83 ec 08             	sub    $0x8,%esp
801043ce:	68 e0 11 13 80       	push   $0x801311e0
801043d3:	68 e0 11 13 80       	push   $0x801311e0
801043d8:	e8 de 1e 00 00       	call   801062bb <sleep>
801043dd:	83 c4 10             	add    $0x10,%esp
801043e0:	eb e0                	jmp    801043c2 <begin_op+0x16>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801043e2:	8b 0d 28 12 13 80    	mov    0x80131228,%ecx
801043e8:	a1 1c 12 13 80       	mov    0x8013121c,%eax
801043ed:	8d 50 01             	lea    0x1(%eax),%edx
801043f0:	89 d0                	mov    %edx,%eax
801043f2:	c1 e0 02             	shl    $0x2,%eax
801043f5:	01 d0                	add    %edx,%eax
801043f7:	01 c0                	add    %eax,%eax
801043f9:	01 c8                	add    %ecx,%eax
801043fb:	83 f8 1e             	cmp    $0x1e,%eax
801043fe:	7e 17                	jle    80104417 <begin_op+0x6b>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80104400:	83 ec 08             	sub    $0x8,%esp
80104403:	68 e0 11 13 80       	push   $0x801311e0
80104408:	68 e0 11 13 80       	push   $0x801311e0
8010440d:	e8 a9 1e 00 00       	call   801062bb <sleep>
80104412:	83 c4 10             	add    $0x10,%esp
80104415:	eb ab                	jmp    801043c2 <begin_op+0x16>
    } else {
      log.outstanding += 1;
80104417:	a1 1c 12 13 80       	mov    0x8013121c,%eax
8010441c:	83 c0 01             	add    $0x1,%eax
8010441f:	a3 1c 12 13 80       	mov    %eax,0x8013121c
      release(&log.lock);
80104424:	83 ec 0c             	sub    $0xc,%esp
80104427:	68 e0 11 13 80       	push   $0x801311e0
8010442c:	e8 f8 21 00 00       	call   80106629 <release>
80104431:	83 c4 10             	add    $0x10,%esp
      break;
80104434:	90                   	nop
    }
  }
}
80104435:	90                   	nop
80104436:	c9                   	leave  
80104437:	c3                   	ret    

80104438 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80104438:	55                   	push   %ebp
80104439:	89 e5                	mov    %esp,%ebp
8010443b:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
8010443e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
80104445:	83 ec 0c             	sub    $0xc,%esp
80104448:	68 e0 11 13 80       	push   $0x801311e0
8010444d:	e8 6b 21 00 00       	call   801065bd <acquire>
80104452:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80104455:	a1 1c 12 13 80       	mov    0x8013121c,%eax
8010445a:	83 e8 01             	sub    $0x1,%eax
8010445d:	a3 1c 12 13 80       	mov    %eax,0x8013121c
  if(log.committing)
80104462:	a1 20 12 13 80       	mov    0x80131220,%eax
80104467:	85 c0                	test   %eax,%eax
80104469:	74 0d                	je     80104478 <end_op+0x40>
    panic("log.committing");
8010446b:	83 ec 0c             	sub    $0xc,%esp
8010446e:	68 cc b4 10 80       	push   $0x8010b4cc
80104473:	e8 c6 c9 ff ff       	call   80100e3e <panic>
  if(log.outstanding == 0){
80104478:	a1 1c 12 13 80       	mov    0x8013121c,%eax
8010447d:	85 c0                	test   %eax,%eax
8010447f:	75 13                	jne    80104494 <end_op+0x5c>
    do_commit = 1;
80104481:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
80104488:	c7 05 20 12 13 80 01 	movl   $0x1,0x80131220
8010448f:	00 00 00 
80104492:	eb 10                	jmp    801044a4 <end_op+0x6c>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80104494:	83 ec 0c             	sub    $0xc,%esp
80104497:	68 e0 11 13 80       	push   $0x801311e0
8010449c:	e8 08 1f 00 00       	call   801063a9 <wakeup>
801044a1:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
801044a4:	83 ec 0c             	sub    $0xc,%esp
801044a7:	68 e0 11 13 80       	push   $0x801311e0
801044ac:	e8 78 21 00 00       	call   80106629 <release>
801044b1:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
801044b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801044b8:	74 3f                	je     801044f9 <end_op+0xc1>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
801044ba:	e8 f5 00 00 00       	call   801045b4 <commit>
    acquire(&log.lock);
801044bf:	83 ec 0c             	sub    $0xc,%esp
801044c2:	68 e0 11 13 80       	push   $0x801311e0
801044c7:	e8 f1 20 00 00       	call   801065bd <acquire>
801044cc:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
801044cf:	c7 05 20 12 13 80 00 	movl   $0x0,0x80131220
801044d6:	00 00 00 
    wakeup(&log);
801044d9:	83 ec 0c             	sub    $0xc,%esp
801044dc:	68 e0 11 13 80       	push   $0x801311e0
801044e1:	e8 c3 1e 00 00       	call   801063a9 <wakeup>
801044e6:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
801044e9:	83 ec 0c             	sub    $0xc,%esp
801044ec:	68 e0 11 13 80       	push   $0x801311e0
801044f1:	e8 33 21 00 00       	call   80106629 <release>
801044f6:	83 c4 10             	add    $0x10,%esp
  }
}
801044f9:	90                   	nop
801044fa:	c9                   	leave  
801044fb:	c3                   	ret    

801044fc <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
801044fc:	55                   	push   %ebp
801044fd:	89 e5                	mov    %esp,%ebp
801044ff:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80104502:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104509:	e9 95 00 00 00       	jmp    801045a3 <write_log+0xa7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
8010450e:	8b 15 14 12 13 80    	mov    0x80131214,%edx
80104514:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104517:	01 d0                	add    %edx,%eax
80104519:	83 c0 01             	add    $0x1,%eax
8010451c:	89 c2                	mov    %eax,%edx
8010451e:	a1 24 12 13 80       	mov    0x80131224,%eax
80104523:	83 ec 08             	sub    $0x8,%esp
80104526:	52                   	push   %edx
80104527:	50                   	push   %eax
80104528:	e8 96 c6 ff ff       	call   80100bc3 <bread>
8010452d:	83 c4 10             	add    $0x10,%esp
80104530:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80104533:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104536:	83 c0 10             	add    $0x10,%eax
80104539:	8b 04 85 ec 11 13 80 	mov    -0x7fecee14(,%eax,4),%eax
80104540:	89 c2                	mov    %eax,%edx
80104542:	a1 24 12 13 80       	mov    0x80131224,%eax
80104547:	83 ec 08             	sub    $0x8,%esp
8010454a:	52                   	push   %edx
8010454b:	50                   	push   %eax
8010454c:	e8 72 c6 ff ff       	call   80100bc3 <bread>
80104551:	83 c4 10             	add    $0x10,%esp
80104554:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
80104557:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010455a:	8d 50 18             	lea    0x18(%eax),%edx
8010455d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104560:	83 c0 18             	add    $0x18,%eax
80104563:	83 ec 04             	sub    $0x4,%esp
80104566:	68 00 02 00 00       	push   $0x200
8010456b:	52                   	push   %edx
8010456c:	50                   	push   %eax
8010456d:	e8 80 23 00 00       	call   801068f2 <memmove>
80104572:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
80104575:	83 ec 0c             	sub    $0xc,%esp
80104578:	ff 75 f0             	pushl  -0x10(%ebp)
8010457b:	e8 7c c6 ff ff       	call   80100bfc <bwrite>
80104580:	83 c4 10             	add    $0x10,%esp
    brelse(from);
80104583:	83 ec 0c             	sub    $0xc,%esp
80104586:	ff 75 ec             	pushl  -0x14(%ebp)
80104589:	e8 ad c6 ff ff       	call   80100c3b <brelse>
8010458e:	83 c4 10             	add    $0x10,%esp
    brelse(to);
80104591:	83 ec 0c             	sub    $0xc,%esp
80104594:	ff 75 f0             	pushl  -0x10(%ebp)
80104597:	e8 9f c6 ff ff       	call   80100c3b <brelse>
8010459c:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
8010459f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801045a3:	a1 28 12 13 80       	mov    0x80131228,%eax
801045a8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801045ab:	0f 8c 5d ff ff ff    	jl     8010450e <write_log+0x12>
  }
}
801045b1:	90                   	nop
801045b2:	c9                   	leave  
801045b3:	c3                   	ret    

801045b4 <commit>:

static void
commit()
{
801045b4:	55                   	push   %ebp
801045b5:	89 e5                	mov    %esp,%ebp
801045b7:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
801045ba:	a1 28 12 13 80       	mov    0x80131228,%eax
801045bf:	85 c0                	test   %eax,%eax
801045c1:	7e 1e                	jle    801045e1 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
801045c3:	e8 34 ff ff ff       	call   801044fc <write_log>
    write_head();    // Write header to disk -- the real commit
801045c8:	e8 3a fd ff ff       	call   80104307 <write_head>
    install_trans(); // Now install writes to home locations
801045cd:	e8 09 fc ff ff       	call   801041db <install_trans>
    log.lh.n = 0;
801045d2:	c7 05 28 12 13 80 00 	movl   $0x0,0x80131228
801045d9:	00 00 00 
    write_head();    // Erase the transaction from the log
801045dc:	e8 26 fd ff ff       	call   80104307 <write_head>
  }
}
801045e1:	90                   	nop
801045e2:	c9                   	leave  
801045e3:	c3                   	ret    

801045e4 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801045e4:	55                   	push   %ebp
801045e5:	89 e5                	mov    %esp,%ebp
801045e7:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801045ea:	a1 28 12 13 80       	mov    0x80131228,%eax
801045ef:	83 f8 1d             	cmp    $0x1d,%eax
801045f2:	7f 12                	jg     80104606 <log_write+0x22>
801045f4:	a1 28 12 13 80       	mov    0x80131228,%eax
801045f9:	8b 15 18 12 13 80    	mov    0x80131218,%edx
801045ff:	83 ea 01             	sub    $0x1,%edx
80104602:	39 d0                	cmp    %edx,%eax
80104604:	7c 0d                	jl     80104613 <log_write+0x2f>
    panic("too big a transaction");
80104606:	83 ec 0c             	sub    $0xc,%esp
80104609:	68 db b4 10 80       	push   $0x8010b4db
8010460e:	e8 2b c8 ff ff       	call   80100e3e <panic>
  if (log.outstanding < 1)
80104613:	a1 1c 12 13 80       	mov    0x8013121c,%eax
80104618:	85 c0                	test   %eax,%eax
8010461a:	7f 0d                	jg     80104629 <log_write+0x45>
    panic("log_write outside of trans");
8010461c:	83 ec 0c             	sub    $0xc,%esp
8010461f:	68 f1 b4 10 80       	push   $0x8010b4f1
80104624:	e8 15 c8 ff ff       	call   80100e3e <panic>

  acquire(&log.lock);
80104629:	83 ec 0c             	sub    $0xc,%esp
8010462c:	68 e0 11 13 80       	push   $0x801311e0
80104631:	e8 87 1f 00 00       	call   801065bd <acquire>
80104636:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
80104639:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104640:	eb 1d                	jmp    8010465f <log_write+0x7b>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80104642:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104645:	83 c0 10             	add    $0x10,%eax
80104648:	8b 04 85 ec 11 13 80 	mov    -0x7fecee14(,%eax,4),%eax
8010464f:	89 c2                	mov    %eax,%edx
80104651:	8b 45 08             	mov    0x8(%ebp),%eax
80104654:	8b 40 08             	mov    0x8(%eax),%eax
80104657:	39 c2                	cmp    %eax,%edx
80104659:	74 10                	je     8010466b <log_write+0x87>
  for (i = 0; i < log.lh.n; i++) {
8010465b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010465f:	a1 28 12 13 80       	mov    0x80131228,%eax
80104664:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104667:	7c d9                	jl     80104642 <log_write+0x5e>
80104669:	eb 01                	jmp    8010466c <log_write+0x88>
      break;
8010466b:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
8010466c:	8b 45 08             	mov    0x8(%ebp),%eax
8010466f:	8b 40 08             	mov    0x8(%eax),%eax
80104672:	89 c2                	mov    %eax,%edx
80104674:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104677:	83 c0 10             	add    $0x10,%eax
8010467a:	89 14 85 ec 11 13 80 	mov    %edx,-0x7fecee14(,%eax,4)
  if (i == log.lh.n)
80104681:	a1 28 12 13 80       	mov    0x80131228,%eax
80104686:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104689:	75 0d                	jne    80104698 <log_write+0xb4>
    log.lh.n++;
8010468b:	a1 28 12 13 80       	mov    0x80131228,%eax
80104690:	83 c0 01             	add    $0x1,%eax
80104693:	a3 28 12 13 80       	mov    %eax,0x80131228
  b->flags |= B_DIRTY; // prevent eviction
80104698:	8b 45 08             	mov    0x8(%ebp),%eax
8010469b:	8b 00                	mov    (%eax),%eax
8010469d:	83 c8 04             	or     $0x4,%eax
801046a0:	89 c2                	mov    %eax,%edx
801046a2:	8b 45 08             	mov    0x8(%ebp),%eax
801046a5:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
801046a7:	83 ec 0c             	sub    $0xc,%esp
801046aa:	68 e0 11 13 80       	push   $0x801311e0
801046af:	e8 75 1f 00 00       	call   80106629 <release>
801046b4:	83 c4 10             	add    $0x10,%esp
}
801046b7:	90                   	nop
801046b8:	c9                   	leave  
801046b9:	c3                   	ret    

801046ba <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801046ba:	55                   	push   %ebp
801046bb:	89 e5                	mov    %esp,%ebp
801046bd:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801046c0:	8b 55 08             	mov    0x8(%ebp),%edx
801046c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801046c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801046c9:	f0 87 02             	lock xchg %eax,(%edx)
801046cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801046cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801046d2:	c9                   	leave  
801046d3:	c3                   	ret    

801046d4 <main>:

// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int main(void)
{
801046d4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801046d8:	83 e4 f0             	and    $0xfffffff0,%esp
801046db:	ff 71 fc             	pushl  -0x4(%ecx)
801046de:	55                   	push   %ebp
801046df:	89 e5                	mov    %esp,%ebp
801046e1:	51                   	push   %ecx
801046e2:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4 * 1024 * 1024)); // phys page allocator
801046e5:	83 ec 08             	sub    $0x8,%esp
801046e8:	68 00 00 40 80       	push   $0x80400000
801046ed:	68 68 4e 13 80       	push   $0x80134e68
801046f2:	e8 68 f2 ff ff       	call   8010395f <kinit1>
801046f7:	83 c4 10             	add    $0x10,%esp
  kvmalloc();                        // kernel page table
801046fa:	e8 d6 4f 00 00       	call   801096d5 <kvmalloc>
  uartinit();                        // serial port
801046ff:	e8 96 3c 00 00       	call   8010839a <uartinit>

  mpinit();    // detect other processors
80104704:	e8 e9 03 00 00       	call   80104af2 <mpinit>
  lapicinit(); // interrupt controller
80104709:	e8 b8 f5 ff ff       	call   80103cc6 <lapicinit>
  seginit();   // segment descriptors
8010470e:	e8 92 49 00 00       	call   801090a5 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80104713:	e8 cc f6 ff ff       	call   80103de4 <cpunum>
80104718:	83 ec 08             	sub    $0x8,%esp
8010471b:	50                   	push   %eax
8010471c:	68 0c b5 10 80       	push   $0x8010b50c
80104721:	e8 f2 c6 ff ff       	call   80100e18 <cprintf>
80104726:	83 c4 10             	add    $0x10,%esp
  picinit();     // another interrupt controller
80104729:	e8 42 0d 00 00       	call   80105470 <picinit>
  ioapicinit();  // another interrupt controller
8010472e:	e8 14 f1 ff ff       	call   80103847 <ioapicinit>
  consoleinit(); // console hardware
80104733:	e8 8b cd ff ff       	call   801014c3 <consoleinit>
  uartinit();    // serial port (Have to call it twice to get interrupt output)
80104738:	e8 5d 3c 00 00       	call   8010839a <uartinit>

  // cprintf("6828 decimal is %o octal!\n", 6828);

  pinit();    // process table
8010473d:	e8 96 12 00 00       	call   801059d8 <pinit>
  tvinit();   // trap vectors
80104742:	e8 32 38 00 00       	call   80107f79 <tvinit>
  binit();    // buffer cache
80104747:	e8 f5 c2 ff ff       	call   80100a41 <binit>
  fileinit(); // file table
8010474c:	e8 97 d2 ff ff       	call   801019e8 <fileinit>
  ideinit();  // disk
80104751:	e8 c5 ec ff ff       	call   8010341b <ideinit>
  pci_init();
80104756:	e8 58 0c 00 00       	call   801053b3 <pci_init>
  if (!ismp)
8010475b:	a1 c4 12 13 80       	mov    0x801312c4,%eax
80104760:	85 c0                	test   %eax,%eax
80104762:	75 05                	jne    80104769 <main+0x95>
    timerinit();                              // uniprocessor timer
80104764:	e8 6d 37 00 00       	call   80107ed6 <timerinit>
  startothers();                              // start other processors
80104769:	e8 78 00 00 00       	call   801047e6 <startothers>
  kinit2(P2V(4 * 1024 * 1024), P2V(PHYSTOP)); // must come after startothers()
8010476e:	83 ec 08             	sub    $0x8,%esp
80104771:	68 00 00 00 8e       	push   $0x8e000000
80104776:	68 00 00 40 80       	push   $0x80400000
8010477b:	e8 18 f2 ff ff       	call   80103998 <kinit2>
80104780:	83 c4 10             	add    $0x10,%esp

  userinit(); // first user process
80104783:	e8 5e 13 00 00       	call   80105ae6 <userinit>
  mpmain();   // finish this processor's setup
80104788:	e8 1a 00 00 00       	call   801047a7 <mpmain>

8010478d <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
8010478d:	55                   	push   %ebp
8010478e:	89 e5                	mov    %esp,%ebp
80104790:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80104793:	e8 55 4f 00 00       	call   801096ed <switchkvm>
  seginit();
80104798:	e8 08 49 00 00       	call   801090a5 <seginit>
  lapicinit();
8010479d:	e8 24 f5 ff ff       	call   80103cc6 <lapicinit>
  mpmain();
801047a2:	e8 00 00 00 00       	call   801047a7 <mpmain>

801047a7 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801047a7:	55                   	push   %ebp
801047a8:	89 e5                	mov    %esp,%ebp
801047aa:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
801047ad:	e8 32 f6 ff ff       	call   80103de4 <cpunum>
801047b2:	83 ec 08             	sub    $0x8,%esp
801047b5:	50                   	push   %eax
801047b6:	68 23 b5 10 80       	push   $0x8010b523
801047bb:	e8 58 c6 ff ff       	call   80100e18 <cprintf>
801047c0:	83 c4 10             	add    $0x10,%esp
  idtinit();              // load idt register
801047c3:	e8 27 39 00 00       	call   801080ef <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
801047c8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801047ce:	05 a8 00 00 00       	add    $0xa8,%eax
801047d3:	83 ec 08             	sub    $0x8,%esp
801047d6:	6a 01                	push   $0x1
801047d8:	50                   	push   %eax
801047d9:	e8 dc fe ff ff       	call   801046ba <xchg>
801047de:	83 c4 10             	add    $0x10,%esp
  test_backtrace(5);

  while (1)
    monitor(0);
#else
  scheduler(); // start running processes
801047e1:	e8 f3 18 00 00       	call   801060d9 <scheduler>

801047e6 <startothers>:
pde_t entrypgdir[]; // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
801047e6:	55                   	push   %ebp
801047e7:	89 e5                	mov    %esp,%ebp
801047e9:	83 ec 18             	sub    $0x18,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
801047ec:	c7 45 f0 00 70 00 80 	movl   $0x80007000,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801047f3:	b8 8a 00 00 00       	mov    $0x8a,%eax
801047f8:	83 ec 04             	sub    $0x4,%esp
801047fb:	50                   	push   %eax
801047fc:	68 84 95 12 80       	push   $0x80129584
80104801:	ff 75 f0             	pushl  -0x10(%ebp)
80104804:	e8 e9 20 00 00       	call   801068f2 <memmove>
80104809:	83 c4 10             	add    $0x10,%esp

  for (c = cpus; c < cpus + ncpu; c++)
8010480c:	c7 45 f4 e0 12 13 80 	movl   $0x801312e0,-0xc(%ebp)
80104813:	e9 84 00 00 00       	jmp    8010489c <startothers+0xb6>
  {
    if (c == cpus + cpunum()) // We've started already.
80104818:	e8 c7 f5 ff ff       	call   80103de4 <cpunum>
8010481d:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80104823:	05 e0 12 13 80       	add    $0x801312e0,%eax
80104828:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010482b:	74 67                	je     80104894 <startothers+0xae>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
8010482d:	e8 4c f2 ff ff       	call   80103a7e <kalloc>
80104832:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void **)(code - 4) = stack + KSTACKSIZE;
80104835:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104838:	83 e8 04             	sub    $0x4,%eax
8010483b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010483e:	81 c2 00 10 00 00    	add    $0x1000,%edx
80104844:	89 10                	mov    %edx,(%eax)
    *(void **)(code - 8) = mpenter;
80104846:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104849:	83 e8 08             	sub    $0x8,%eax
8010484c:	c7 00 8d 47 10 80    	movl   $0x8010478d,(%eax)
    *(int **)(code - 12) = (void *)V2P(entrypgdir);
80104852:	b8 00 80 12 80       	mov    $0x80128000,%eax
80104857:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
8010485d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104860:	83 e8 0c             	sub    $0xc,%eax
80104863:	89 10                	mov    %edx,(%eax)

    lapicstartap(c->apicid, V2P(code));
80104865:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104868:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
8010486e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104871:	0f b6 00             	movzbl (%eax),%eax
80104874:	0f b6 c0             	movzbl %al,%eax
80104877:	83 ec 08             	sub    $0x8,%esp
8010487a:	52                   	push   %edx
8010487b:	50                   	push   %eax
8010487c:	e8 22 f6 ff ff       	call   80103ea3 <lapicstartap>
80104881:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while (c->started == 0)
80104884:	90                   	nop
80104885:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104888:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010488e:	85 c0                	test   %eax,%eax
80104890:	74 f3                	je     80104885 <startothers+0x9f>
80104892:	eb 01                	jmp    80104895 <startothers+0xaf>
      continue;
80104894:	90                   	nop
  for (c = cpus; c < cpus + ncpu; c++)
80104895:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
8010489c:	a1 c0 18 13 80       	mov    0x801318c0,%eax
801048a1:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801048a7:	05 e0 12 13 80       	add    $0x801312e0,%eax
801048ac:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801048af:	0f 82 63 ff ff ff    	jb     80104818 <startothers+0x32>
      ;
  }
}
801048b5:	90                   	nop
801048b6:	c9                   	leave  
801048b7:	c3                   	ret    

801048b8 <inb>:
{
801048b8:	55                   	push   %ebp
801048b9:	89 e5                	mov    %esp,%ebp
801048bb:	83 ec 14             	sub    $0x14,%esp
801048be:	8b 45 08             	mov    0x8(%ebp),%eax
801048c1:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801048c5:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801048c9:	89 c2                	mov    %eax,%edx
801048cb:	ec                   	in     (%dx),%al
801048cc:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801048cf:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801048d3:	c9                   	leave  
801048d4:	c3                   	ret    

801048d5 <outb>:
{
801048d5:	55                   	push   %ebp
801048d6:	89 e5                	mov    %esp,%ebp
801048d8:	83 ec 08             	sub    $0x8,%esp
801048db:	8b 55 08             	mov    0x8(%ebp),%edx
801048de:	8b 45 0c             	mov    0xc(%ebp),%eax
801048e1:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801048e5:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801048e8:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801048ec:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801048f0:	ee                   	out    %al,(%dx)
}
801048f1:	90                   	nop
801048f2:	c9                   	leave  
801048f3:	c3                   	ret    

801048f4 <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
801048f4:	55                   	push   %ebp
801048f5:	89 e5                	mov    %esp,%ebp
801048f7:	83 ec 10             	sub    $0x10,%esp
  int i, sum;

  sum = 0;
801048fa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80104901:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80104908:	eb 15                	jmp    8010491f <sum+0x2b>
    sum += addr[i];
8010490a:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010490d:	8b 45 08             	mov    0x8(%ebp),%eax
80104910:	01 d0                	add    %edx,%eax
80104912:	0f b6 00             	movzbl (%eax),%eax
80104915:	0f b6 c0             	movzbl %al,%eax
80104918:	01 45 f8             	add    %eax,-0x8(%ebp)
  for(i=0; i<len; i++)
8010491b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010491f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104922:	3b 45 0c             	cmp    0xc(%ebp),%eax
80104925:	7c e3                	jl     8010490a <sum+0x16>
  return sum;
80104927:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
8010492a:	c9                   	leave  
8010492b:	c3                   	ret    

8010492c <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010492c:	55                   	push   %ebp
8010492d:	89 e5                	mov    %esp,%ebp
8010492f:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80104932:	8b 45 08             	mov    0x8(%ebp),%eax
80104935:	05 00 00 00 80       	add    $0x80000000,%eax
8010493a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
8010493d:	8b 55 0c             	mov    0xc(%ebp),%edx
80104940:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104943:	01 d0                	add    %edx,%eax
80104945:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80104948:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010494b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010494e:	eb 36                	jmp    80104986 <mpsearch1+0x5a>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80104950:	83 ec 04             	sub    $0x4,%esp
80104953:	6a 04                	push   $0x4
80104955:	68 34 b5 10 80       	push   $0x8010b534
8010495a:	ff 75 f4             	pushl  -0xc(%ebp)
8010495d:	e8 38 1f 00 00       	call   8010689a <memcmp>
80104962:	83 c4 10             	add    $0x10,%esp
80104965:	85 c0                	test   %eax,%eax
80104967:	75 19                	jne    80104982 <mpsearch1+0x56>
80104969:	83 ec 08             	sub    $0x8,%esp
8010496c:	6a 10                	push   $0x10
8010496e:	ff 75 f4             	pushl  -0xc(%ebp)
80104971:	e8 7e ff ff ff       	call   801048f4 <sum>
80104976:	83 c4 10             	add    $0x10,%esp
80104979:	84 c0                	test   %al,%al
8010497b:	75 05                	jne    80104982 <mpsearch1+0x56>
      return (struct mp*)p;
8010497d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104980:	eb 11                	jmp    80104993 <mpsearch1+0x67>
  for(p = addr; p < e; p += sizeof(struct mp))
80104982:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80104986:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104989:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010498c:	72 c2                	jb     80104950 <mpsearch1+0x24>
  return 0;
8010498e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104993:	c9                   	leave  
80104994:	c3                   	ret    

80104995 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80104995:	55                   	push   %ebp
80104996:	89 e5                	mov    %esp,%ebp
80104998:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
8010499b:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801049a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049a5:	83 c0 0f             	add    $0xf,%eax
801049a8:	0f b6 00             	movzbl (%eax),%eax
801049ab:	0f b6 c0             	movzbl %al,%eax
801049ae:	c1 e0 08             	shl    $0x8,%eax
801049b1:	89 c2                	mov    %eax,%edx
801049b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049b6:	83 c0 0e             	add    $0xe,%eax
801049b9:	0f b6 00             	movzbl (%eax),%eax
801049bc:	0f b6 c0             	movzbl %al,%eax
801049bf:	09 d0                	or     %edx,%eax
801049c1:	c1 e0 04             	shl    $0x4,%eax
801049c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
801049c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801049cb:	74 21                	je     801049ee <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
801049cd:	83 ec 08             	sub    $0x8,%esp
801049d0:	68 00 04 00 00       	push   $0x400
801049d5:	ff 75 f0             	pushl  -0x10(%ebp)
801049d8:	e8 4f ff ff ff       	call   8010492c <mpsearch1>
801049dd:	83 c4 10             	add    $0x10,%esp
801049e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
801049e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801049e7:	74 51                	je     80104a3a <mpsearch+0xa5>
      return mp;
801049e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801049ec:	eb 61                	jmp    80104a4f <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801049ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f1:	83 c0 14             	add    $0x14,%eax
801049f4:	0f b6 00             	movzbl (%eax),%eax
801049f7:	0f b6 c0             	movzbl %al,%eax
801049fa:	c1 e0 08             	shl    $0x8,%eax
801049fd:	89 c2                	mov    %eax,%edx
801049ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a02:	83 c0 13             	add    $0x13,%eax
80104a05:	0f b6 00             	movzbl (%eax),%eax
80104a08:	0f b6 c0             	movzbl %al,%eax
80104a0b:	09 d0                	or     %edx,%eax
80104a0d:	c1 e0 0a             	shl    $0xa,%eax
80104a10:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80104a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a16:	2d 00 04 00 00       	sub    $0x400,%eax
80104a1b:	83 ec 08             	sub    $0x8,%esp
80104a1e:	68 00 04 00 00       	push   $0x400
80104a23:	50                   	push   %eax
80104a24:	e8 03 ff ff ff       	call   8010492c <mpsearch1>
80104a29:	83 c4 10             	add    $0x10,%esp
80104a2c:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104a2f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80104a33:	74 05                	je     80104a3a <mpsearch+0xa5>
      return mp;
80104a35:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a38:	eb 15                	jmp    80104a4f <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80104a3a:	83 ec 08             	sub    $0x8,%esp
80104a3d:	68 00 00 01 00       	push   $0x10000
80104a42:	68 00 00 0f 00       	push   $0xf0000
80104a47:	e8 e0 fe ff ff       	call   8010492c <mpsearch1>
80104a4c:	83 c4 10             	add    $0x10,%esp
}
80104a4f:	c9                   	leave  
80104a50:	c3                   	ret    

80104a51 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80104a51:	55                   	push   %ebp
80104a52:	89 e5                	mov    %esp,%ebp
80104a54:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80104a57:	e8 39 ff ff ff       	call   80104995 <mpsearch>
80104a5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104a5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104a63:	74 0a                	je     80104a6f <mpconfig+0x1e>
80104a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a68:	8b 40 04             	mov    0x4(%eax),%eax
80104a6b:	85 c0                	test   %eax,%eax
80104a6d:	75 07                	jne    80104a76 <mpconfig+0x25>
    return 0;
80104a6f:	b8 00 00 00 00       	mov    $0x0,%eax
80104a74:	eb 7a                	jmp    80104af0 <mpconfig+0x9f>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80104a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a79:	8b 40 04             	mov    0x4(%eax),%eax
80104a7c:	05 00 00 00 80       	add    $0x80000000,%eax
80104a81:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80104a84:	83 ec 04             	sub    $0x4,%esp
80104a87:	6a 04                	push   $0x4
80104a89:	68 39 b5 10 80       	push   $0x8010b539
80104a8e:	ff 75 f0             	pushl  -0x10(%ebp)
80104a91:	e8 04 1e 00 00       	call   8010689a <memcmp>
80104a96:	83 c4 10             	add    $0x10,%esp
80104a99:	85 c0                	test   %eax,%eax
80104a9b:	74 07                	je     80104aa4 <mpconfig+0x53>
    return 0;
80104a9d:	b8 00 00 00 00       	mov    $0x0,%eax
80104aa2:	eb 4c                	jmp    80104af0 <mpconfig+0x9f>
  if(conf->version != 1 && conf->version != 4)
80104aa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104aa7:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80104aab:	3c 01                	cmp    $0x1,%al
80104aad:	74 12                	je     80104ac1 <mpconfig+0x70>
80104aaf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ab2:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80104ab6:	3c 04                	cmp    $0x4,%al
80104ab8:	74 07                	je     80104ac1 <mpconfig+0x70>
    return 0;
80104aba:	b8 00 00 00 00       	mov    $0x0,%eax
80104abf:	eb 2f                	jmp    80104af0 <mpconfig+0x9f>
  if(sum((uchar*)conf, conf->length) != 0)
80104ac1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ac4:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80104ac8:	0f b7 c0             	movzwl %ax,%eax
80104acb:	83 ec 08             	sub    $0x8,%esp
80104ace:	50                   	push   %eax
80104acf:	ff 75 f0             	pushl  -0x10(%ebp)
80104ad2:	e8 1d fe ff ff       	call   801048f4 <sum>
80104ad7:	83 c4 10             	add    $0x10,%esp
80104ada:	84 c0                	test   %al,%al
80104adc:	74 07                	je     80104ae5 <mpconfig+0x94>
    return 0;
80104ade:	b8 00 00 00 00       	mov    $0x0,%eax
80104ae3:	eb 0b                	jmp    80104af0 <mpconfig+0x9f>
  *pmp = mp;
80104ae5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ae8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104aeb:	89 10                	mov    %edx,(%eax)
  return conf;
80104aed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80104af0:	c9                   	leave  
80104af1:	c3                   	ret    

80104af2 <mpinit>:

void
mpinit(void)
{
80104af2:	55                   	push   %ebp
80104af3:	89 e5                	mov    %esp,%ebp
80104af5:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80104af8:	83 ec 0c             	sub    $0xc,%esp
80104afb:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104afe:	50                   	push   %eax
80104aff:	e8 4d ff ff ff       	call   80104a51 <mpconfig>
80104b04:	83 c4 10             	add    $0x10,%esp
80104b07:	89 45 f0             	mov    %eax,-0x10(%ebp)
80104b0a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104b0e:	0f 84 1f 01 00 00    	je     80104c33 <mpinit+0x141>
    return;
  ismp = 1;
80104b14:	c7 05 c4 12 13 80 01 	movl   $0x1,0x801312c4
80104b1b:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80104b1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b21:	8b 40 24             	mov    0x24(%eax),%eax
80104b24:	a3 dc 11 13 80       	mov    %eax,0x801311dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104b29:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b2c:	83 c0 2c             	add    $0x2c,%eax
80104b2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104b32:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b35:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80104b39:	0f b7 d0             	movzwl %ax,%edx
80104b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b3f:	01 d0                	add    %edx,%eax
80104b41:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104b44:	eb 7e                	jmp    80104bc4 <mpinit+0xd2>
    switch(*p){
80104b46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b49:	0f b6 00             	movzbl (%eax),%eax
80104b4c:	0f b6 c0             	movzbl %al,%eax
80104b4f:	83 f8 04             	cmp    $0x4,%eax
80104b52:	77 65                	ja     80104bb9 <mpinit+0xc7>
80104b54:	8b 04 85 40 b5 10 80 	mov    -0x7fef4ac0(,%eax,4),%eax
80104b5b:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80104b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b60:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(ncpu < NCPU) {
80104b63:	a1 c0 18 13 80       	mov    0x801318c0,%eax
80104b68:	83 f8 07             	cmp    $0x7,%eax
80104b6b:	7f 28                	jg     80104b95 <mpinit+0xa3>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80104b6d:	8b 15 c0 18 13 80    	mov    0x801318c0,%edx
80104b73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104b76:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80104b7a:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
80104b80:	81 c2 e0 12 13 80    	add    $0x801312e0,%edx
80104b86:	88 02                	mov    %al,(%edx)
        ncpu++;
80104b88:	a1 c0 18 13 80       	mov    0x801318c0,%eax
80104b8d:	83 c0 01             	add    $0x1,%eax
80104b90:	a3 c0 18 13 80       	mov    %eax,0x801318c0
      }
      p += sizeof(struct mpproc);
80104b95:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80104b99:	eb 29                	jmp    80104bc4 <mpinit+0xd2>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80104b9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b9e:	89 45 e8             	mov    %eax,-0x18(%ebp)
      ioapicid = ioapic->apicno;
80104ba1:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104ba4:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80104ba8:	a2 c0 12 13 80       	mov    %al,0x801312c0
      p += sizeof(struct mpioapic);
80104bad:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80104bb1:	eb 11                	jmp    80104bc4 <mpinit+0xd2>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80104bb3:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80104bb7:	eb 0b                	jmp    80104bc4 <mpinit+0xd2>
    default:
      ismp = 0;
80104bb9:	c7 05 c4 12 13 80 00 	movl   $0x0,0x801312c4
80104bc0:	00 00 00 
      break;
80104bc3:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104bc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bc7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80104bca:	0f 82 76 ff ff ff    	jb     80104b46 <mpinit+0x54>
    }
  }
  if(!ismp){
80104bd0:	a1 c4 12 13 80       	mov    0x801312c4,%eax
80104bd5:	85 c0                	test   %eax,%eax
80104bd7:	75 1d                	jne    80104bf6 <mpinit+0x104>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80104bd9:	c7 05 c0 18 13 80 01 	movl   $0x1,0x801318c0
80104be0:	00 00 00 
    lapic = 0;
80104be3:	c7 05 dc 11 13 80 00 	movl   $0x0,0x801311dc
80104bea:	00 00 00 
    ioapicid = 0;
80104bed:	c6 05 c0 12 13 80 00 	movb   $0x0,0x801312c0
    return;
80104bf4:	eb 3e                	jmp    80104c34 <mpinit+0x142>
  }

  if(mp->imcrp){
80104bf6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104bf9:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80104bfd:	84 c0                	test   %al,%al
80104bff:	74 33                	je     80104c34 <mpinit+0x142>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80104c01:	83 ec 08             	sub    $0x8,%esp
80104c04:	6a 70                	push   $0x70
80104c06:	6a 22                	push   $0x22
80104c08:	e8 c8 fc ff ff       	call   801048d5 <outb>
80104c0d:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80104c10:	83 ec 0c             	sub    $0xc,%esp
80104c13:	6a 23                	push   $0x23
80104c15:	e8 9e fc ff ff       	call   801048b8 <inb>
80104c1a:	83 c4 10             	add    $0x10,%esp
80104c1d:	83 c8 01             	or     $0x1,%eax
80104c20:	0f b6 c0             	movzbl %al,%eax
80104c23:	83 ec 08             	sub    $0x8,%esp
80104c26:	50                   	push   %eax
80104c27:	6a 23                	push   $0x23
80104c29:	e8 a7 fc ff ff       	call   801048d5 <outb>
80104c2e:	83 c4 10             	add    $0x10,%esp
80104c31:	eb 01                	jmp    80104c34 <mpinit+0x142>
    return;
80104c33:	90                   	nop
  }
}
80104c34:	c9                   	leave  
80104c35:	c3                   	ret    

80104c36 <inl>:
{
80104c36:	55                   	push   %ebp
80104c37:	89 e5                	mov    %esp,%ebp
80104c39:	83 ec 10             	sub    $0x10,%esp
  asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
80104c3c:	8b 45 08             	mov    0x8(%ebp),%eax
80104c3f:	89 c2                	mov    %eax,%edx
80104c41:	ed                   	in     (%dx),%eax
80104c42:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return data;
80104c45:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104c48:	c9                   	leave  
80104c49:	c3                   	ret    

80104c4a <outl>:
{
80104c4a:	55                   	push   %ebp
80104c4b:	89 e5                	mov    %esp,%ebp
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
80104c4d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c50:	8b 55 08             	mov    0x8(%ebp),%edx
80104c53:	ef                   	out    %eax,(%dx)
}
80104c54:	90                   	nop
80104c55:	5d                   	pop    %ebp
80104c56:	c3                   	ret    

80104c57 <pci_conf1_set_addr>:
static void
pci_conf1_set_addr(uint32_t bus,
                   uint32_t dev,
                   uint32_t func,
                   uint32_t offset)
{
80104c57:	55                   	push   %ebp
80104c58:	89 e5                	mov    %esp,%ebp
80104c5a:	83 ec 18             	sub    $0x18,%esp
  assert(bus < 256);
80104c5d:	81 7d 08 ff 00 00 00 	cmpl   $0xff,0x8(%ebp)
80104c64:	76 0d                	jbe    80104c73 <pci_conf1_set_addr+0x1c>
80104c66:	83 ec 0c             	sub    $0xc,%esp
80104c69:	68 54 b5 10 80       	push   $0x8010b554
80104c6e:	e8 cb c1 ff ff       	call   80100e3e <panic>
  assert(dev < 32);
80104c73:	83 7d 0c 1f          	cmpl   $0x1f,0xc(%ebp)
80104c77:	76 0d                	jbe    80104c86 <pci_conf1_set_addr+0x2f>
80104c79:	83 ec 0c             	sub    $0xc,%esp
80104c7c:	68 54 b5 10 80       	push   $0x8010b554
80104c81:	e8 b8 c1 ff ff       	call   80100e3e <panic>
  assert(func < 8);
80104c86:	83 7d 10 07          	cmpl   $0x7,0x10(%ebp)
80104c8a:	76 0d                	jbe    80104c99 <pci_conf1_set_addr+0x42>
80104c8c:	83 ec 0c             	sub    $0xc,%esp
80104c8f:	68 54 b5 10 80       	push   $0x8010b554
80104c94:	e8 a5 c1 ff ff       	call   80100e3e <panic>
  assert(offset < 256);
80104c99:	81 7d 14 ff 00 00 00 	cmpl   $0xff,0x14(%ebp)
80104ca0:	76 0d                	jbe    80104caf <pci_conf1_set_addr+0x58>
80104ca2:	83 ec 0c             	sub    $0xc,%esp
80104ca5:	68 54 b5 10 80       	push   $0x8010b554
80104caa:	e8 8f c1 ff ff       	call   80100e3e <panic>
  assert((offset & 0x3) == 0);
80104caf:	8b 45 14             	mov    0x14(%ebp),%eax
80104cb2:	83 e0 03             	and    $0x3,%eax
80104cb5:	85 c0                	test   %eax,%eax
80104cb7:	74 0d                	je     80104cc6 <pci_conf1_set_addr+0x6f>
80104cb9:	83 ec 0c             	sub    $0xc,%esp
80104cbc:	68 54 b5 10 80       	push   $0x8010b554
80104cc1:	e8 78 c1 ff ff       	call   80100e3e <panic>

  uint32_t v = (1 << 31) | // config-space
               (bus << 16) | (dev << 11) | (func << 8) | (offset);
80104cc6:	8b 45 08             	mov    0x8(%ebp),%eax
80104cc9:	c1 e0 10             	shl    $0x10,%eax
80104ccc:	89 c2                	mov    %eax,%edx
80104cce:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cd1:	c1 e0 0b             	shl    $0xb,%eax
80104cd4:	09 c2                	or     %eax,%edx
80104cd6:	8b 45 10             	mov    0x10(%ebp),%eax
80104cd9:	c1 e0 08             	shl    $0x8,%eax
80104cdc:	09 d0                	or     %edx,%eax
80104cde:	0b 45 14             	or     0x14(%ebp),%eax
  uint32_t v = (1 << 31) | // config-space
80104ce1:	0d 00 00 00 80       	or     $0x80000000,%eax
80104ce6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outl(pci_conf1_addr_ioport, v);
80104ce9:	a1 08 90 12 80       	mov    0x80129008,%eax
80104cee:	83 ec 08             	sub    $0x8,%esp
80104cf1:	ff 75 f4             	pushl  -0xc(%ebp)
80104cf4:	50                   	push   %eax
80104cf5:	e8 50 ff ff ff       	call   80104c4a <outl>
80104cfa:	83 c4 10             	add    $0x10,%esp
}
80104cfd:	90                   	nop
80104cfe:	c9                   	leave  
80104cff:	c3                   	ret    

80104d00 <pci_conf_read>:

static uint32_t
pci_conf_read(struct pci_func *f, uint32_t off)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	83 ec 08             	sub    $0x8,%esp
  pci_conf1_set_addr(f->bus->busno, f->dev, f->func, off);
80104d06:	8b 45 08             	mov    0x8(%ebp),%eax
80104d09:	8b 48 08             	mov    0x8(%eax),%ecx
80104d0c:	8b 45 08             	mov    0x8(%ebp),%eax
80104d0f:	8b 50 04             	mov    0x4(%eax),%edx
80104d12:	8b 45 08             	mov    0x8(%ebp),%eax
80104d15:	8b 00                	mov    (%eax),%eax
80104d17:	8b 40 04             	mov    0x4(%eax),%eax
80104d1a:	ff 75 0c             	pushl  0xc(%ebp)
80104d1d:	51                   	push   %ecx
80104d1e:	52                   	push   %edx
80104d1f:	50                   	push   %eax
80104d20:	e8 32 ff ff ff       	call   80104c57 <pci_conf1_set_addr>
80104d25:	83 c4 10             	add    $0x10,%esp
  return inl(pci_conf1_data_ioport);
80104d28:	a1 0c 90 12 80       	mov    0x8012900c,%eax
80104d2d:	83 ec 0c             	sub    $0xc,%esp
80104d30:	50                   	push   %eax
80104d31:	e8 00 ff ff ff       	call   80104c36 <inl>
80104d36:	83 c4 10             	add    $0x10,%esp
}
80104d39:	c9                   	leave  
80104d3a:	c3                   	ret    

80104d3b <pci_conf_write>:

static void
pci_conf_write(struct pci_func *f, uint32_t off, uint32_t v)
{
80104d3b:	55                   	push   %ebp
80104d3c:	89 e5                	mov    %esp,%ebp
80104d3e:	83 ec 08             	sub    $0x8,%esp
  pci_conf1_set_addr(f->bus->busno, f->dev, f->func, off);
80104d41:	8b 45 08             	mov    0x8(%ebp),%eax
80104d44:	8b 48 08             	mov    0x8(%eax),%ecx
80104d47:	8b 45 08             	mov    0x8(%ebp),%eax
80104d4a:	8b 50 04             	mov    0x4(%eax),%edx
80104d4d:	8b 45 08             	mov    0x8(%ebp),%eax
80104d50:	8b 00                	mov    (%eax),%eax
80104d52:	8b 40 04             	mov    0x4(%eax),%eax
80104d55:	ff 75 0c             	pushl  0xc(%ebp)
80104d58:	51                   	push   %ecx
80104d59:	52                   	push   %edx
80104d5a:	50                   	push   %eax
80104d5b:	e8 f7 fe ff ff       	call   80104c57 <pci_conf1_set_addr>
80104d60:	83 c4 10             	add    $0x10,%esp
  outl(pci_conf1_data_ioport, v);
80104d63:	a1 0c 90 12 80       	mov    0x8012900c,%eax
80104d68:	83 ec 08             	sub    $0x8,%esp
80104d6b:	ff 75 10             	pushl  0x10(%ebp)
80104d6e:	50                   	push   %eax
80104d6f:	e8 d6 fe ff ff       	call   80104c4a <outl>
80104d74:	83 c4 10             	add    $0x10,%esp
}
80104d77:	90                   	nop
80104d78:	c9                   	leave  
80104d79:	c3                   	ret    

80104d7a <pci_attach_match>:

static int __attribute__((warn_unused_result))
pci_attach_match(uint32_t key1, uint32_t key2,
                 struct pci_driver *list, struct pci_func *pcif)
{
80104d7a:	55                   	push   %ebp
80104d7b:	89 e5                	mov    %esp,%ebp
80104d7d:	83 ec 18             	sub    $0x18,%esp
  uint32_t i;

  for (i = 0; list[i].attachfn; i++)
80104d80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104d87:	e9 a2 00 00 00       	jmp    80104e2e <pci_attach_match+0xb4>
  {
    if (list[i].key1 == key1 && list[i].key2 == key2)
80104d8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d8f:	89 d0                	mov    %edx,%eax
80104d91:	01 c0                	add    %eax,%eax
80104d93:	01 d0                	add    %edx,%eax
80104d95:	c1 e0 02             	shl    $0x2,%eax
80104d98:	89 c2                	mov    %eax,%edx
80104d9a:	8b 45 10             	mov    0x10(%ebp),%eax
80104d9d:	01 d0                	add    %edx,%eax
80104d9f:	8b 00                	mov    (%eax),%eax
80104da1:	39 45 08             	cmp    %eax,0x8(%ebp)
80104da4:	0f 85 80 00 00 00    	jne    80104e2a <pci_attach_match+0xb0>
80104daa:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104dad:	89 d0                	mov    %edx,%eax
80104daf:	01 c0                	add    %eax,%eax
80104db1:	01 d0                	add    %edx,%eax
80104db3:	c1 e0 02             	shl    $0x2,%eax
80104db6:	89 c2                	mov    %eax,%edx
80104db8:	8b 45 10             	mov    0x10(%ebp),%eax
80104dbb:	01 d0                	add    %edx,%eax
80104dbd:	8b 40 04             	mov    0x4(%eax),%eax
80104dc0:	39 45 0c             	cmp    %eax,0xc(%ebp)
80104dc3:	75 65                	jne    80104e2a <pci_attach_match+0xb0>
    {
      int r = list[i].attachfn(pcif);
80104dc5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104dc8:	89 d0                	mov    %edx,%eax
80104dca:	01 c0                	add    %eax,%eax
80104dcc:	01 d0                	add    %edx,%eax
80104dce:	c1 e0 02             	shl    $0x2,%eax
80104dd1:	89 c2                	mov    %eax,%edx
80104dd3:	8b 45 10             	mov    0x10(%ebp),%eax
80104dd6:	01 d0                	add    %edx,%eax
80104dd8:	8b 40 08             	mov    0x8(%eax),%eax
80104ddb:	83 ec 0c             	sub    $0xc,%esp
80104dde:	ff 75 14             	pushl  0x14(%ebp)
80104de1:	ff d0                	call   *%eax
80104de3:	83 c4 10             	add    $0x10,%esp
80104de6:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if (r > 0)
80104de9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104ded:	7e 05                	jle    80104df4 <pci_attach_match+0x7a>
      {
        //cprintf("attchfn failed!\n");
        return r;
80104def:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104df2:	eb 5d                	jmp    80104e51 <pci_attach_match+0xd7>
      }
      if (r < 0)
80104df4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104df8:	79 30                	jns    80104e2a <pci_attach_match+0xb0>
        cprintf("pci_attach_match: attaching "
                "%x.%x (%p): e\n",
                key1, key2, list[i].attachfn, r);
80104dfa:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104dfd:	89 d0                	mov    %edx,%eax
80104dff:	01 c0                	add    %eax,%eax
80104e01:	01 d0                	add    %edx,%eax
80104e03:	c1 e0 02             	shl    $0x2,%eax
80104e06:	89 c2                	mov    %eax,%edx
80104e08:	8b 45 10             	mov    0x10(%ebp),%eax
80104e0b:	01 d0                	add    %edx,%eax
        cprintf("pci_attach_match: attaching "
80104e0d:	8b 40 08             	mov    0x8(%eax),%eax
80104e10:	83 ec 0c             	sub    $0xc,%esp
80104e13:	ff 75 f0             	pushl  -0x10(%ebp)
80104e16:	50                   	push   %eax
80104e17:	ff 75 0c             	pushl  0xc(%ebp)
80104e1a:	ff 75 08             	pushl  0x8(%ebp)
80104e1d:	68 68 b5 10 80       	push   $0x8010b568
80104e22:	e8 f1 bf ff ff       	call   80100e18 <cprintf>
80104e27:	83 c4 20             	add    $0x20,%esp
  for (i = 0; list[i].attachfn; i++)
80104e2a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104e2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e31:	89 d0                	mov    %edx,%eax
80104e33:	01 c0                	add    %eax,%eax
80104e35:	01 d0                	add    %edx,%eax
80104e37:	c1 e0 02             	shl    $0x2,%eax
80104e3a:	89 c2                	mov    %eax,%edx
80104e3c:	8b 45 10             	mov    0x10(%ebp),%eax
80104e3f:	01 d0                	add    %edx,%eax
80104e41:	8b 40 08             	mov    0x8(%eax),%eax
80104e44:	85 c0                	test   %eax,%eax
80104e46:	0f 85 40 ff ff ff    	jne    80104d8c <pci_attach_match+0x12>
    }
    //cprintf("No match for key1 and key2\n");
  }
  return 0;
80104e4c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104e51:	c9                   	leave  
80104e52:	c3                   	ret    

80104e53 <pci_attach>:

static int
pci_attach(struct pci_func *f)
{
80104e53:	55                   	push   %ebp
80104e54:	89 e5                	mov    %esp,%ebp
80104e56:	83 ec 08             	sub    $0x8,%esp
  return pci_attach_match(PCI_CLASS(f->dev_class),
                          PCI_SUBCLASS(f->dev_class),
80104e59:	8b 45 08             	mov    0x8(%ebp),%eax
80104e5c:	8b 40 10             	mov    0x10(%eax),%eax
80104e5f:	c1 e8 10             	shr    $0x10,%eax
  return pci_attach_match(PCI_CLASS(f->dev_class),
80104e62:	0f b6 c0             	movzbl %al,%eax
80104e65:	8b 55 08             	mov    0x8(%ebp),%edx
80104e68:	8b 52 10             	mov    0x10(%edx),%edx
80104e6b:	c1 ea 18             	shr    $0x18,%edx
80104e6e:	ff 75 08             	pushl  0x8(%ebp)
80104e71:	68 10 90 12 80       	push   $0x80129010
80104e76:	50                   	push   %eax
80104e77:	52                   	push   %edx
80104e78:	e8 fd fe ff ff       	call   80104d7a <pci_attach_match>
80104e7d:	83 c4 10             	add    $0x10,%esp
                          &pci_attach_class[0], f) ||
80104e80:	85 c0                	test   %eax,%eax
80104e82:	75 2a                	jne    80104eae <pci_attach+0x5b>
         pci_attach_match(PCI_VENDOR(f->dev_id),
                          PCI_PRODUCT(f->dev_id),
80104e84:	8b 45 08             	mov    0x8(%ebp),%eax
80104e87:	8b 40 0c             	mov    0xc(%eax),%eax
         pci_attach_match(PCI_VENDOR(f->dev_id),
80104e8a:	c1 e8 10             	shr    $0x10,%eax
80104e8d:	89 c2                	mov    %eax,%edx
80104e8f:	8b 45 08             	mov    0x8(%ebp),%eax
80104e92:	8b 40 0c             	mov    0xc(%eax),%eax
80104e95:	0f b7 c0             	movzwl %ax,%eax
80104e98:	ff 75 08             	pushl  0x8(%ebp)
80104e9b:	68 28 90 12 80       	push   $0x80129028
80104ea0:	52                   	push   %edx
80104ea1:	50                   	push   %eax
80104ea2:	e8 d3 fe ff ff       	call   80104d7a <pci_attach_match>
80104ea7:	83 c4 10             	add    $0x10,%esp
                          &pci_attach_class[0], f) ||
80104eaa:	85 c0                	test   %eax,%eax
80104eac:	74 07                	je     80104eb5 <pci_attach+0x62>
80104eae:	b8 01 00 00 00       	mov    $0x1,%eax
80104eb3:	eb 05                	jmp    80104eba <pci_attach+0x67>
80104eb5:	b8 00 00 00 00       	mov    $0x0,%eax
                          &pci_attach_vendor[0], f);
}
80104eba:	c9                   	leave  
80104ebb:	c3                   	ret    

80104ebc <pci_print_func>:
        [0x6] = "Bridge device",
};

static void
pci_print_func(struct pci_func *f)
{
80104ebc:	55                   	push   %ebp
80104ebd:	89 e5                	mov    %esp,%ebp
80104ebf:	57                   	push   %edi
80104ec0:	56                   	push   %esi
80104ec1:	53                   	push   %ebx
80104ec2:	83 ec 2c             	sub    $0x2c,%esp
  const char *class = pci_class[0];
80104ec5:	a1 40 90 12 80       	mov    0x80129040,%eax
80104eca:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  if (PCI_CLASS(f->dev_class) < sizeof(pci_class) / sizeof(pci_class[0]))
80104ecd:	8b 45 08             	mov    0x8(%ebp),%eax
80104ed0:	8b 40 10             	mov    0x10(%eax),%eax
80104ed3:	c1 e8 18             	shr    $0x18,%eax
80104ed6:	83 f8 06             	cmp    $0x6,%eax
80104ed9:	77 13                	ja     80104eee <pci_print_func+0x32>
    class = pci_class[PCI_CLASS(f->dev_class)];
80104edb:	8b 45 08             	mov    0x8(%ebp),%eax
80104ede:	8b 40 10             	mov    0x10(%eax),%eax
80104ee1:	c1 e8 18             	shr    $0x18,%eax
80104ee4:	8b 04 85 40 90 12 80 	mov    -0x7fed6fc0(,%eax,4),%eax
80104eeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  cprintf("PCI: %02x:%02x.%d: %04x:%04x: class: %x.%x (%s) irq: %d\n",
          f->bus->busno, f->dev, f->func,
          PCI_VENDOR(f->dev_id), PCI_PRODUCT(f->dev_id),
          PCI_CLASS(f->dev_class), PCI_SUBCLASS(f->dev_class), class,
          f->irq_line);
80104eee:	8b 45 08             	mov    0x8(%ebp),%eax
80104ef1:	0f b6 40 44          	movzbl 0x44(%eax),%eax
  cprintf("PCI: %02x:%02x.%d: %04x:%04x: class: %x.%x (%s) irq: %d\n",
80104ef5:	0f b6 d0             	movzbl %al,%edx
          PCI_CLASS(f->dev_class), PCI_SUBCLASS(f->dev_class), class,
80104ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80104efb:	8b 40 10             	mov    0x10(%eax),%eax
80104efe:	c1 e8 10             	shr    $0x10,%eax
  cprintf("PCI: %02x:%02x.%d: %04x:%04x: class: %x.%x (%s) irq: %d\n",
80104f01:	0f b6 f8             	movzbl %al,%edi
          PCI_CLASS(f->dev_class), PCI_SUBCLASS(f->dev_class), class,
80104f04:	8b 45 08             	mov    0x8(%ebp),%eax
80104f07:	8b 40 10             	mov    0x10(%eax),%eax
  cprintf("PCI: %02x:%02x.%d: %04x:%04x: class: %x.%x (%s) irq: %d\n",
80104f0a:	c1 e8 18             	shr    $0x18,%eax
80104f0d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
          PCI_VENDOR(f->dev_id), PCI_PRODUCT(f->dev_id),
80104f10:	8b 45 08             	mov    0x8(%ebp),%eax
80104f13:	8b 40 0c             	mov    0xc(%eax),%eax
  cprintf("PCI: %02x:%02x.%d: %04x:%04x: class: %x.%x (%s) irq: %d\n",
80104f16:	c1 e8 10             	shr    $0x10,%eax
80104f19:	89 45 d0             	mov    %eax,-0x30(%ebp)
          PCI_VENDOR(f->dev_id), PCI_PRODUCT(f->dev_id),
80104f1c:	8b 45 08             	mov    0x8(%ebp),%eax
80104f1f:	8b 40 0c             	mov    0xc(%eax),%eax
  cprintf("PCI: %02x:%02x.%d: %04x:%04x: class: %x.%x (%s) irq: %d\n",
80104f22:	0f b7 f0             	movzwl %ax,%esi
80104f25:	8b 45 08             	mov    0x8(%ebp),%eax
80104f28:	8b 58 08             	mov    0x8(%eax),%ebx
80104f2b:	8b 45 08             	mov    0x8(%ebp),%eax
80104f2e:	8b 48 04             	mov    0x4(%eax),%ecx
          f->bus->busno, f->dev, f->func,
80104f31:	8b 45 08             	mov    0x8(%ebp),%eax
80104f34:	8b 00                	mov    (%eax),%eax
  cprintf("PCI: %02x:%02x.%d: %04x:%04x: class: %x.%x (%s) irq: %d\n",
80104f36:	8b 40 04             	mov    0x4(%eax),%eax
80104f39:	83 ec 08             	sub    $0x8,%esp
80104f3c:	52                   	push   %edx
80104f3d:	ff 75 e4             	pushl  -0x1c(%ebp)
80104f40:	57                   	push   %edi
80104f41:	ff 75 d4             	pushl  -0x2c(%ebp)
80104f44:	ff 75 d0             	pushl  -0x30(%ebp)
80104f47:	56                   	push   %esi
80104f48:	53                   	push   %ebx
80104f49:	51                   	push   %ecx
80104f4a:	50                   	push   %eax
80104f4b:	68 08 b6 10 80       	push   $0x8010b608
80104f50:	e8 c3 be ff ff       	call   80100e18 <cprintf>
80104f55:	83 c4 30             	add    $0x30,%esp
}
80104f58:	90                   	nop
80104f59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f5c:	5b                   	pop    %ebx
80104f5d:	5e                   	pop    %esi
80104f5e:	5f                   	pop    %edi
80104f5f:	5d                   	pop    %ebp
80104f60:	c3                   	ret    

80104f61 <pci_scan_bus>:

static int
pci_scan_bus(struct pci_bus *bus)
{
80104f61:	55                   	push   %ebp
80104f62:	89 e5                	mov    %esp,%ebp
80104f64:	57                   	push   %edi
80104f65:	56                   	push   %esi
80104f66:	81 ec f0 00 00 00    	sub    $0xf0,%esp
  int totaldev = 0;
80104f6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  struct pci_func df;

  memset(&df, 0, sizeof(df));
80104f73:	83 ec 04             	sub    $0x4,%esp
80104f76:	6a 48                	push   $0x48
80104f78:	6a 00                	push   $0x0
80104f7a:	8d 45 a4             	lea    -0x5c(%ebp),%eax
80104f7d:	50                   	push   %eax
80104f7e:	e8 b0 18 00 00       	call   80106833 <memset>
80104f83:	83 c4 10             	add    $0x10,%esp
  df.bus = bus;
80104f86:	8b 45 08             	mov    0x8(%ebp),%eax
80104f89:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  for (df.dev = 0; df.dev < 32; df.dev++)
80104f8c:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%ebp)
80104f93:	e9 37 01 00 00       	jmp    801050cf <pci_scan_bus+0x16e>
  {
    uint32_t bhlc = pci_conf_read(&df, PCI_BHLC_REG);
80104f98:	83 ec 08             	sub    $0x8,%esp
80104f9b:	6a 0c                	push   $0xc
80104f9d:	8d 45 a4             	lea    -0x5c(%ebp),%eax
80104fa0:	50                   	push   %eax
80104fa1:	e8 5a fd ff ff       	call   80104d00 <pci_conf_read>
80104fa6:	83 c4 10             	add    $0x10,%esp
80104fa9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (PCI_HDRTYPE_TYPE(bhlc) > 1) // Unsupported or no device
80104fac:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104faf:	c1 e8 10             	shr    $0x10,%eax
80104fb2:	83 e0 7f             	and    $0x7f,%eax
80104fb5:	83 f8 01             	cmp    $0x1,%eax
80104fb8:	0f 87 07 01 00 00    	ja     801050c5 <pci_scan_bus+0x164>
      continue;

    totaldev++;
80104fbe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

    struct pci_func f = df;
80104fc2:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
80104fc8:	8d 55 a4             	lea    -0x5c(%ebp),%edx
80104fcb:	b9 12 00 00 00       	mov    $0x12,%ecx
80104fd0:	89 c7                	mov    %eax,%edi
80104fd2:	89 d6                	mov    %edx,%esi
80104fd4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    for (f.func = 0; f.func < (PCI_HDRTYPE_MULTIFN(bhlc) ? 8 : 1);
80104fd6:	c7 85 1c ff ff ff 00 	movl   $0x0,-0xe4(%ebp)
80104fdd:	00 00 00 
80104fe0:	e9 b7 00 00 00       	jmp    8010509c <pci_scan_bus+0x13b>
         f.func++)
    {
      struct pci_func af = f;
80104fe5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80104feb:	8d 95 14 ff ff ff    	lea    -0xec(%ebp),%edx
80104ff1:	b9 12 00 00 00       	mov    $0x12,%ecx
80104ff6:	89 c7                	mov    %eax,%edi
80104ff8:	89 d6                	mov    %edx,%esi
80104ffa:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

      af.dev_id = pci_conf_read(&f, PCI_ID_REG);
80104ffc:	83 ec 08             	sub    $0x8,%esp
80104fff:	6a 00                	push   $0x0
80105001:	8d 85 14 ff ff ff    	lea    -0xec(%ebp),%eax
80105007:	50                   	push   %eax
80105008:	e8 f3 fc ff ff       	call   80104d00 <pci_conf_read>
8010500d:	83 c4 10             	add    $0x10,%esp
80105010:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
      if (PCI_VENDOR(af.dev_id) == 0xffff)
80105016:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010501c:	0f b7 c0             	movzwl %ax,%eax
8010501f:	3d ff ff 00 00       	cmp    $0xffff,%eax
80105024:	74 66                	je     8010508c <pci_scan_bus+0x12b>
        continue;

      uint32_t intr = pci_conf_read(&af, PCI_INTERRUPT_REG);
80105026:	83 ec 08             	sub    $0x8,%esp
80105029:	6a 3c                	push   $0x3c
8010502b:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105031:	50                   	push   %eax
80105032:	e8 c9 fc ff ff       	call   80104d00 <pci_conf_read>
80105037:	83 c4 10             	add    $0x10,%esp
8010503a:	89 45 ec             	mov    %eax,-0x14(%ebp)
      af.irq_line = PCI_INTERRUPT_LINE(intr);
8010503d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105040:	88 45 a0             	mov    %al,-0x60(%ebp)

      af.dev_class = pci_conf_read(&af, PCI_CLASS_REG);
80105043:	83 ec 08             	sub    $0x8,%esp
80105046:	6a 08                	push   $0x8
80105048:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
8010504e:	50                   	push   %eax
8010504f:	e8 ac fc ff ff       	call   80104d00 <pci_conf_read>
80105054:	83 c4 10             	add    $0x10,%esp
80105057:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
      if (pci_show_devs)
8010505d:	a1 00 90 12 80       	mov    0x80129000,%eax
80105062:	85 c0                	test   %eax,%eax
80105064:	74 12                	je     80105078 <pci_scan_bus+0x117>
        pci_print_func(&af);
80105066:	83 ec 0c             	sub    $0xc,%esp
80105069:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
8010506f:	50                   	push   %eax
80105070:	e8 47 fe ff ff       	call   80104ebc <pci_print_func>
80105075:	83 c4 10             	add    $0x10,%esp
      pci_attach(&af);
80105078:	83 ec 0c             	sub    $0xc,%esp
8010507b:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105081:	50                   	push   %eax
80105082:	e8 cc fd ff ff       	call   80104e53 <pci_attach>
80105087:	83 c4 10             	add    $0x10,%esp
8010508a:	eb 01                	jmp    8010508d <pci_scan_bus+0x12c>
        continue;
8010508c:	90                   	nop
         f.func++)
8010508d:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
80105093:	83 c0 01             	add    $0x1,%eax
80105096:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
    for (f.func = 0; f.func < (PCI_HDRTYPE_MULTIFN(bhlc) ? 8 : 1);
8010509c:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
801050a2:	8b 55 f0             	mov    -0x10(%ebp),%edx
801050a5:	81 e2 00 00 80 00    	and    $0x800000,%edx
801050ab:	85 d2                	test   %edx,%edx
801050ad:	74 07                	je     801050b6 <pci_scan_bus+0x155>
801050af:	ba 08 00 00 00       	mov    $0x8,%edx
801050b4:	eb 05                	jmp    801050bb <pci_scan_bus+0x15a>
801050b6:	ba 01 00 00 00       	mov    $0x1,%edx
801050bb:	39 c2                	cmp    %eax,%edx
801050bd:	0f 87 22 ff ff ff    	ja     80104fe5 <pci_scan_bus+0x84>
801050c3:	eb 01                	jmp    801050c6 <pci_scan_bus+0x165>
      continue;
801050c5:	90                   	nop
  for (df.dev = 0; df.dev < 32; df.dev++)
801050c6:	8b 45 a8             	mov    -0x58(%ebp),%eax
801050c9:	83 c0 01             	add    $0x1,%eax
801050cc:	89 45 a8             	mov    %eax,-0x58(%ebp)
801050cf:	8b 45 a8             	mov    -0x58(%ebp),%eax
801050d2:	83 f8 1f             	cmp    $0x1f,%eax
801050d5:	0f 86 bd fe ff ff    	jbe    80104f98 <pci_scan_bus+0x37>
    }
  }

  return totaldev;
801050db:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801050de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050e1:	5e                   	pop    %esi
801050e2:	5f                   	pop    %edi
801050e3:	5d                   	pop    %ebp
801050e4:	c3                   	ret    

801050e5 <pci_bridge_attach>:

static int
pci_bridge_attach(struct pci_func *pcif)
{
801050e5:	55                   	push   %ebp
801050e6:	89 e5                	mov    %esp,%ebp
801050e8:	56                   	push   %esi
801050e9:	53                   	push   %ebx
801050ea:	83 ec 10             	sub    $0x10,%esp
  uint32_t ioreg = pci_conf_read(pcif, PCI_BRIDGE_STATIO_REG);
801050ed:	83 ec 08             	sub    $0x8,%esp
801050f0:	6a 1c                	push   $0x1c
801050f2:	ff 75 08             	pushl  0x8(%ebp)
801050f5:	e8 06 fc ff ff       	call   80104d00 <pci_conf_read>
801050fa:	83 c4 10             	add    $0x10,%esp
801050fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  uint32_t busreg = pci_conf_read(pcif, PCI_BRIDGE_BUS_REG);
80105100:	83 ec 08             	sub    $0x8,%esp
80105103:	6a 18                	push   $0x18
80105105:	ff 75 08             	pushl  0x8(%ebp)
80105108:	e8 f3 fb ff ff       	call   80104d00 <pci_conf_read>
8010510d:	83 c4 10             	add    $0x10,%esp
80105110:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if (PCI_BRIDGE_IO_32BITS(ioreg))
80105113:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105116:	83 e0 0f             	and    $0xf,%eax
80105119:	83 f8 01             	cmp    $0x1,%eax
8010511c:	75 2b                	jne    80105149 <pci_bridge_attach+0x64>
  {
    cprintf("PCI: %02x:%02x.%d: 32-bit bridge IO not supported.\n",
8010511e:	8b 45 08             	mov    0x8(%ebp),%eax
80105121:	8b 48 08             	mov    0x8(%eax),%ecx
80105124:	8b 45 08             	mov    0x8(%ebp),%eax
80105127:	8b 50 04             	mov    0x4(%eax),%edx
            pcif->bus->busno, pcif->dev, pcif->func);
8010512a:	8b 45 08             	mov    0x8(%ebp),%eax
8010512d:	8b 00                	mov    (%eax),%eax
    cprintf("PCI: %02x:%02x.%d: 32-bit bridge IO not supported.\n",
8010512f:	8b 40 04             	mov    0x4(%eax),%eax
80105132:	51                   	push   %ecx
80105133:	52                   	push   %edx
80105134:	50                   	push   %eax
80105135:	68 44 b6 10 80       	push   $0x8010b644
8010513a:	e8 d9 bc ff ff       	call   80100e18 <cprintf>
8010513f:	83 c4 10             	add    $0x10,%esp
    return 0;
80105142:	b8 00 00 00 00       	mov    $0x0,%eax
80105147:	eb 77                	jmp    801051c0 <pci_bridge_attach+0xdb>
  }

  struct pci_bus nbus;
  memset(&nbus, 0, sizeof(nbus));
80105149:	83 ec 04             	sub    $0x4,%esp
8010514c:	6a 08                	push   $0x8
8010514e:	6a 00                	push   $0x0
80105150:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105153:	50                   	push   %eax
80105154:	e8 da 16 00 00       	call   80106833 <memset>
80105159:	83 c4 10             	add    $0x10,%esp
  nbus.parent_bridge = pcif;
8010515c:	8b 45 08             	mov    0x8(%ebp),%eax
8010515f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  nbus.busno = (busreg >> PCI_BRIDGE_BUS_SECONDARY_SHIFT) & 0xff;
80105162:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105165:	c1 e8 08             	shr    $0x8,%eax
80105168:	0f b6 c0             	movzbl %al,%eax
8010516b:	89 45 ec             	mov    %eax,-0x14(%ebp)

  if (pci_show_devs)
8010516e:	a1 00 90 12 80       	mov    0x80129000,%eax
80105173:	85 c0                	test   %eax,%eax
80105175:	74 35                	je     801051ac <pci_bridge_attach+0xc7>
    cprintf("PCI: %02x:%02x.%d: bridge to PCI bus %d--%d\n",
            pcif->bus->busno, pcif->dev, pcif->func,
            nbus.busno,
            (busreg >> PCI_BRIDGE_BUS_SUBORDINATE_SHIFT) & 0xff);
80105177:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010517a:	c1 e8 10             	shr    $0x10,%eax
    cprintf("PCI: %02x:%02x.%d: bridge to PCI bus %d--%d\n",
8010517d:	0f b6 f0             	movzbl %al,%esi
80105180:	8b 5d ec             	mov    -0x14(%ebp),%ebx
80105183:	8b 45 08             	mov    0x8(%ebp),%eax
80105186:	8b 48 08             	mov    0x8(%eax),%ecx
80105189:	8b 45 08             	mov    0x8(%ebp),%eax
8010518c:	8b 50 04             	mov    0x4(%eax),%edx
            pcif->bus->busno, pcif->dev, pcif->func,
8010518f:	8b 45 08             	mov    0x8(%ebp),%eax
80105192:	8b 00                	mov    (%eax),%eax
    cprintf("PCI: %02x:%02x.%d: bridge to PCI bus %d--%d\n",
80105194:	8b 40 04             	mov    0x4(%eax),%eax
80105197:	83 ec 08             	sub    $0x8,%esp
8010519a:	56                   	push   %esi
8010519b:	53                   	push   %ebx
8010519c:	51                   	push   %ecx
8010519d:	52                   	push   %edx
8010519e:	50                   	push   %eax
8010519f:	68 78 b6 10 80       	push   $0x8010b678
801051a4:	e8 6f bc ff ff       	call   80100e18 <cprintf>
801051a9:	83 c4 20             	add    $0x20,%esp

  pci_scan_bus(&nbus);
801051ac:	83 ec 0c             	sub    $0xc,%esp
801051af:	8d 45 e8             	lea    -0x18(%ebp),%eax
801051b2:	50                   	push   %eax
801051b3:	e8 a9 fd ff ff       	call   80104f61 <pci_scan_bus>
801051b8:	83 c4 10             	add    $0x10,%esp
  return 1;
801051bb:	b8 01 00 00 00       	mov    $0x1,%eax
}
801051c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051c3:	5b                   	pop    %ebx
801051c4:	5e                   	pop    %esi
801051c5:	5d                   	pop    %ebp
801051c6:	c3                   	ret    

801051c7 <pci_func_enable>:

// External PCI subsystem interface

void pci_func_enable(struct pci_func *f)
{
801051c7:	55                   	push   %ebp
801051c8:	89 e5                	mov    %esp,%ebp
801051ca:	56                   	push   %esi
801051cb:	53                   	push   %ebx
801051cc:	83 ec 20             	sub    $0x20,%esp
  pci_conf_write(f, PCI_COMMAND_STATUS_REG,
801051cf:	83 ec 04             	sub    $0x4,%esp
801051d2:	6a 07                	push   $0x7
801051d4:	6a 04                	push   $0x4
801051d6:	ff 75 08             	pushl  0x8(%ebp)
801051d9:	e8 5d fb ff ff       	call   80104d3b <pci_conf_write>
801051de:	83 c4 10             	add    $0x10,%esp
                     PCI_COMMAND_MEM_ENABLE |
                     PCI_COMMAND_MASTER_ENABLE);

  uint32_t bar_width;
  uint32_t bar;
  for (bar = PCI_MAPREG_START; bar < PCI_MAPREG_END;
801051e1:	c7 45 f0 10 00 00 00 	movl   $0x10,-0x10(%ebp)
801051e8:	e9 77 01 00 00       	jmp    80105364 <pci_func_enable+0x19d>
       bar += bar_width)
  {
    uint32_t oldv = pci_conf_read(f, bar);
801051ed:	83 ec 08             	sub    $0x8,%esp
801051f0:	ff 75 f0             	pushl  -0x10(%ebp)
801051f3:	ff 75 08             	pushl  0x8(%ebp)
801051f6:	e8 05 fb ff ff       	call   80104d00 <pci_conf_read>
801051fb:	83 c4 10             	add    $0x10,%esp
801051fe:	89 45 e4             	mov    %eax,-0x1c(%ebp)

    bar_width = 4;
80105201:	c7 45 f4 04 00 00 00 	movl   $0x4,-0xc(%ebp)
    pci_conf_write(f, bar, 0xffffffff);
80105208:	83 ec 04             	sub    $0x4,%esp
8010520b:	6a ff                	push   $0xffffffff
8010520d:	ff 75 f0             	pushl  -0x10(%ebp)
80105210:	ff 75 08             	pushl  0x8(%ebp)
80105213:	e8 23 fb ff ff       	call   80104d3b <pci_conf_write>
80105218:	83 c4 10             	add    $0x10,%esp
    uint32_t rv = pci_conf_read(f, bar);
8010521b:	83 ec 08             	sub    $0x8,%esp
8010521e:	ff 75 f0             	pushl  -0x10(%ebp)
80105221:	ff 75 08             	pushl  0x8(%ebp)
80105224:	e8 d7 fa ff ff       	call   80104d00 <pci_conf_read>
80105229:	83 c4 10             	add    $0x10,%esp
8010522c:	89 45 e0             	mov    %eax,-0x20(%ebp)

    if (rv == 0)
8010522f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80105233:	0f 84 24 01 00 00    	je     8010535d <pci_func_enable+0x196>
      continue;

    int regnum = PCI_MAPREG_NUM(bar);
80105239:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010523c:	83 e8 10             	sub    $0x10,%eax
8010523f:	c1 e8 02             	shr    $0x2,%eax
80105242:	89 45 dc             	mov    %eax,-0x24(%ebp)
    uint32_t base, size;
    if (PCI_MAPREG_TYPE(rv) == PCI_MAPREG_TYPE_MEM)
80105245:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105248:	83 e0 01             	and    $0x1,%eax
8010524b:	85 c0                	test   %eax,%eax
8010524d:	75 4d                	jne    8010529c <pci_func_enable+0xd5>
    {
      if (PCI_MAPREG_MEM_TYPE(rv) == PCI_MAPREG_MEM_TYPE_64BIT)
8010524f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105252:	83 e0 06             	and    $0x6,%eax
80105255:	83 f8 04             	cmp    $0x4,%eax
80105258:	75 07                	jne    80105261 <pci_func_enable+0x9a>
        bar_width = 8;
8010525a:	c7 45 f4 08 00 00 00 	movl   $0x8,-0xc(%ebp)

      size = PCI_MAPREG_MEM_SIZE(rv);
80105261:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105264:	83 e0 f0             	and    $0xfffffff0,%eax
80105267:	f7 d8                	neg    %eax
80105269:	23 45 e0             	and    -0x20(%ebp),%eax
8010526c:	83 e0 f0             	and    $0xfffffff0,%eax
8010526f:	89 45 e8             	mov    %eax,-0x18(%ebp)
      base = PCI_MAPREG_MEM_ADDR(oldv);
80105272:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105275:	83 e0 f0             	and    $0xfffffff0,%eax
80105278:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if (pci_show_addrs)
8010527b:	a1 04 90 12 80       	mov    0x80129004,%eax
80105280:	85 c0                	test   %eax,%eax
80105282:	74 51                	je     801052d5 <pci_func_enable+0x10e>
        cprintf("  mem region %d: %d bytes at 0x%x\n",
80105284:	ff 75 ec             	pushl  -0x14(%ebp)
80105287:	ff 75 e8             	pushl  -0x18(%ebp)
8010528a:	ff 75 dc             	pushl  -0x24(%ebp)
8010528d:	68 a8 b6 10 80       	push   $0x8010b6a8
80105292:	e8 81 bb ff ff       	call   80100e18 <cprintf>
80105297:	83 c4 10             	add    $0x10,%esp
8010529a:	eb 39                	jmp    801052d5 <pci_func_enable+0x10e>
                regnum, size, base);
    }
    else
    {
      size = PCI_MAPREG_IO_SIZE(rv);
8010529c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010529f:	83 e0 fc             	and    $0xfffffffc,%eax
801052a2:	f7 d8                	neg    %eax
801052a4:	23 45 e0             	and    -0x20(%ebp),%eax
801052a7:	83 e0 fc             	and    $0xfffffffc,%eax
801052aa:	89 45 e8             	mov    %eax,-0x18(%ebp)
      base = PCI_MAPREG_IO_ADDR(oldv);
801052ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801052b0:	83 e0 fc             	and    $0xfffffffc,%eax
801052b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if (pci_show_addrs)
801052b6:	a1 04 90 12 80       	mov    0x80129004,%eax
801052bb:	85 c0                	test   %eax,%eax
801052bd:	74 16                	je     801052d5 <pci_func_enable+0x10e>
        cprintf("  io region %d: %d bytes at 0x%x\n",
801052bf:	ff 75 ec             	pushl  -0x14(%ebp)
801052c2:	ff 75 e8             	pushl  -0x18(%ebp)
801052c5:	ff 75 dc             	pushl  -0x24(%ebp)
801052c8:	68 cc b6 10 80       	push   $0x8010b6cc
801052cd:	e8 46 bb ff ff       	call   80100e18 <cprintf>
801052d2:	83 c4 10             	add    $0x10,%esp
                regnum, size, base);
    }

    pci_conf_write(f, bar, oldv);
801052d5:	83 ec 04             	sub    $0x4,%esp
801052d8:	ff 75 e4             	pushl  -0x1c(%ebp)
801052db:	ff 75 f0             	pushl  -0x10(%ebp)
801052de:	ff 75 08             	pushl  0x8(%ebp)
801052e1:	e8 55 fa ff ff       	call   80104d3b <pci_conf_write>
801052e6:	83 c4 10             	add    $0x10,%esp
    f->reg_base[regnum] = base;
801052e9:	8b 45 08             	mov    0x8(%ebp),%eax
801052ec:	8b 55 dc             	mov    -0x24(%ebp),%edx
801052ef:	8d 4a 04             	lea    0x4(%edx),%ecx
801052f2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801052f5:	89 54 88 04          	mov    %edx,0x4(%eax,%ecx,4)
    f->reg_size[regnum] = size;
801052f9:	8b 45 08             	mov    0x8(%ebp),%eax
801052fc:	8b 55 dc             	mov    -0x24(%ebp),%edx
801052ff:	8d 4a 08             	lea    0x8(%edx),%ecx
80105302:	8b 55 e8             	mov    -0x18(%ebp),%edx
80105305:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)

    if (size && !base)
80105309:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010530d:	74 4f                	je     8010535e <pci_func_enable+0x197>
8010530f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105313:	75 49                	jne    8010535e <pci_func_enable+0x197>
      cprintf("PCI device %02x:%02x.%d (%04x:%04x) "
              "may be misconfigured: "
              "region %d: base 0x%x, size %d\n",
              f->bus->busno, f->dev, f->func,
              PCI_VENDOR(f->dev_id), PCI_PRODUCT(f->dev_id),
80105315:	8b 45 08             	mov    0x8(%ebp),%eax
80105318:	8b 40 0c             	mov    0xc(%eax),%eax
      cprintf("PCI device %02x:%02x.%d (%04x:%04x) "
8010531b:	c1 e8 10             	shr    $0x10,%eax
8010531e:	89 c6                	mov    %eax,%esi
              PCI_VENDOR(f->dev_id), PCI_PRODUCT(f->dev_id),
80105320:	8b 45 08             	mov    0x8(%ebp),%eax
80105323:	8b 40 0c             	mov    0xc(%eax),%eax
      cprintf("PCI device %02x:%02x.%d (%04x:%04x) "
80105326:	0f b7 d8             	movzwl %ax,%ebx
80105329:	8b 45 08             	mov    0x8(%ebp),%eax
8010532c:	8b 48 08             	mov    0x8(%eax),%ecx
8010532f:	8b 45 08             	mov    0x8(%ebp),%eax
80105332:	8b 50 04             	mov    0x4(%eax),%edx
              f->bus->busno, f->dev, f->func,
80105335:	8b 45 08             	mov    0x8(%ebp),%eax
80105338:	8b 00                	mov    (%eax),%eax
      cprintf("PCI device %02x:%02x.%d (%04x:%04x) "
8010533a:	8b 40 04             	mov    0x4(%eax),%eax
8010533d:	83 ec 0c             	sub    $0xc,%esp
80105340:	ff 75 e8             	pushl  -0x18(%ebp)
80105343:	ff 75 ec             	pushl  -0x14(%ebp)
80105346:	ff 75 dc             	pushl  -0x24(%ebp)
80105349:	56                   	push   %esi
8010534a:	53                   	push   %ebx
8010534b:	51                   	push   %ecx
8010534c:	52                   	push   %edx
8010534d:	50                   	push   %eax
8010534e:	68 f0 b6 10 80       	push   $0x8010b6f0
80105353:	e8 c0 ba ff ff       	call   80100e18 <cprintf>
80105358:	83 c4 30             	add    $0x30,%esp
8010535b:	eb 01                	jmp    8010535e <pci_func_enable+0x197>
      continue;
8010535d:	90                   	nop
       bar += bar_width)
8010535e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105361:	01 45 f0             	add    %eax,-0x10(%ebp)
  for (bar = PCI_MAPREG_START; bar < PCI_MAPREG_END;
80105364:	83 7d f0 27          	cmpl   $0x27,-0x10(%ebp)
80105368:	0f 86 7f fe ff ff    	jbe    801051ed <pci_func_enable+0x26>
              regnum, base, size);
  }

  cprintf("PCI function %02x:%02x.%d (%04x:%04x) enabled\n",
          f->bus->busno, f->dev, f->func,
          PCI_VENDOR(f->dev_id), PCI_PRODUCT(f->dev_id));
8010536e:	8b 45 08             	mov    0x8(%ebp),%eax
80105371:	8b 40 0c             	mov    0xc(%eax),%eax
  cprintf("PCI function %02x:%02x.%d (%04x:%04x) enabled\n",
80105374:	c1 e8 10             	shr    $0x10,%eax
80105377:	89 c6                	mov    %eax,%esi
          PCI_VENDOR(f->dev_id), PCI_PRODUCT(f->dev_id));
80105379:	8b 45 08             	mov    0x8(%ebp),%eax
8010537c:	8b 40 0c             	mov    0xc(%eax),%eax
  cprintf("PCI function %02x:%02x.%d (%04x:%04x) enabled\n",
8010537f:	0f b7 d8             	movzwl %ax,%ebx
80105382:	8b 45 08             	mov    0x8(%ebp),%eax
80105385:	8b 48 08             	mov    0x8(%eax),%ecx
80105388:	8b 45 08             	mov    0x8(%ebp),%eax
8010538b:	8b 50 04             	mov    0x4(%eax),%edx
          f->bus->busno, f->dev, f->func,
8010538e:	8b 45 08             	mov    0x8(%ebp),%eax
80105391:	8b 00                	mov    (%eax),%eax
  cprintf("PCI function %02x:%02x.%d (%04x:%04x) enabled\n",
80105393:	8b 40 04             	mov    0x4(%eax),%eax
80105396:	83 ec 08             	sub    $0x8,%esp
80105399:	56                   	push   %esi
8010539a:	53                   	push   %ebx
8010539b:	51                   	push   %ecx
8010539c:	52                   	push   %edx
8010539d:	50                   	push   %eax
8010539e:	68 4c b7 10 80       	push   $0x8010b74c
801053a3:	e8 70 ba ff ff       	call   80100e18 <cprintf>
801053a8:	83 c4 20             	add    $0x20,%esp
}
801053ab:	90                   	nop
801053ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053af:	5b                   	pop    %ebx
801053b0:	5e                   	pop    %esi
801053b1:	5d                   	pop    %ebp
801053b2:	c3                   	ret    

801053b3 <pci_init>:

int pci_init(void)
{
801053b3:	55                   	push   %ebp
801053b4:	89 e5                	mov    %esp,%ebp
801053b6:	83 ec 08             	sub    $0x8,%esp
  static struct pci_bus root_bus;

  memset(&root_bus, 0, sizeof(root_bus));
801053b9:	83 ec 04             	sub    $0x4,%esp
801053bc:	6a 08                	push   $0x8
801053be:	6a 00                	push   $0x0
801053c0:	68 c4 96 12 80       	push   $0x801296c4
801053c5:	e8 69 14 00 00       	call   80106833 <memset>
801053ca:	83 c4 10             	add    $0x10,%esp

  return pci_scan_bus(&root_bus);
801053cd:	83 ec 0c             	sub    $0xc,%esp
801053d0:	68 c4 96 12 80       	push   $0x801296c4
801053d5:	e8 87 fb ff ff       	call   80104f61 <pci_scan_bus>
801053da:	83 c4 10             	add    $0x10,%esp
}
801053dd:	c9                   	leave  
801053de:	c3                   	ret    

801053df <outb>:
{
801053df:	55                   	push   %ebp
801053e0:	89 e5                	mov    %esp,%ebp
801053e2:	83 ec 08             	sub    $0x8,%esp
801053e5:	8b 55 08             	mov    0x8(%ebp),%edx
801053e8:	8b 45 0c             	mov    0xc(%ebp),%eax
801053eb:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801053ef:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801053f2:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801053f6:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801053fa:	ee                   	out    %al,(%dx)
}
801053fb:	90                   	nop
801053fc:	c9                   	leave  
801053fd:	c3                   	ret    

801053fe <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
801053fe:	55                   	push   %ebp
801053ff:	89 e5                	mov    %esp,%ebp
80105401:	83 ec 04             	sub    $0x4,%esp
80105404:	8b 45 08             	mov    0x8(%ebp),%eax
80105407:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
8010540b:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010540f:	66 a3 5c 90 12 80    	mov    %ax,0x8012905c
  outb(IO_PIC1+1, mask);
80105415:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80105419:	0f b6 c0             	movzbl %al,%eax
8010541c:	50                   	push   %eax
8010541d:	6a 21                	push   $0x21
8010541f:	e8 bb ff ff ff       	call   801053df <outb>
80105424:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80105427:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010542b:	66 c1 e8 08          	shr    $0x8,%ax
8010542f:	0f b6 c0             	movzbl %al,%eax
80105432:	50                   	push   %eax
80105433:	68 a1 00 00 00       	push   $0xa1
80105438:	e8 a2 ff ff ff       	call   801053df <outb>
8010543d:	83 c4 08             	add    $0x8,%esp
}
80105440:	90                   	nop
80105441:	c9                   	leave  
80105442:	c3                   	ret    

80105443 <picenable>:

void
picenable(int irq)
{
80105443:	55                   	push   %ebp
80105444:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80105446:	8b 45 08             	mov    0x8(%ebp),%eax
80105449:	ba 01 00 00 00       	mov    $0x1,%edx
8010544e:	89 c1                	mov    %eax,%ecx
80105450:	d3 e2                	shl    %cl,%edx
80105452:	89 d0                	mov    %edx,%eax
80105454:	f7 d0                	not    %eax
80105456:	89 c2                	mov    %eax,%edx
80105458:	0f b7 05 5c 90 12 80 	movzwl 0x8012905c,%eax
8010545f:	21 d0                	and    %edx,%eax
80105461:	0f b7 c0             	movzwl %ax,%eax
80105464:	50                   	push   %eax
80105465:	e8 94 ff ff ff       	call   801053fe <picsetmask>
8010546a:	83 c4 04             	add    $0x4,%esp
}
8010546d:	90                   	nop
8010546e:	c9                   	leave  
8010546f:	c3                   	ret    

80105470 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80105473:	68 ff 00 00 00       	push   $0xff
80105478:	6a 21                	push   $0x21
8010547a:	e8 60 ff ff ff       	call   801053df <outb>
8010547f:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80105482:	68 ff 00 00 00       	push   $0xff
80105487:	68 a1 00 00 00       	push   $0xa1
8010548c:	e8 4e ff ff ff       	call   801053df <outb>
80105491:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80105494:	6a 11                	push   $0x11
80105496:	6a 20                	push   $0x20
80105498:	e8 42 ff ff ff       	call   801053df <outb>
8010549d:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
801054a0:	6a 20                	push   $0x20
801054a2:	6a 21                	push   $0x21
801054a4:	e8 36 ff ff ff       	call   801053df <outb>
801054a9:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
801054ac:	6a 04                	push   $0x4
801054ae:	6a 21                	push   $0x21
801054b0:	e8 2a ff ff ff       	call   801053df <outb>
801054b5:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
801054b8:	6a 03                	push   $0x3
801054ba:	6a 21                	push   $0x21
801054bc:	e8 1e ff ff ff       	call   801053df <outb>
801054c1:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
801054c4:	6a 11                	push   $0x11
801054c6:	68 a0 00 00 00       	push   $0xa0
801054cb:	e8 0f ff ff ff       	call   801053df <outb>
801054d0:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
801054d3:	6a 28                	push   $0x28
801054d5:	68 a1 00 00 00       	push   $0xa1
801054da:	e8 00 ff ff ff       	call   801053df <outb>
801054df:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
801054e2:	6a 02                	push   $0x2
801054e4:	68 a1 00 00 00       	push   $0xa1
801054e9:	e8 f1 fe ff ff       	call   801053df <outb>
801054ee:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
801054f1:	6a 03                	push   $0x3
801054f3:	68 a1 00 00 00       	push   $0xa1
801054f8:	e8 e2 fe ff ff       	call   801053df <outb>
801054fd:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80105500:	6a 68                	push   $0x68
80105502:	6a 20                	push   $0x20
80105504:	e8 d6 fe ff ff       	call   801053df <outb>
80105509:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
8010550c:	6a 0a                	push   $0xa
8010550e:	6a 20                	push   $0x20
80105510:	e8 ca fe ff ff       	call   801053df <outb>
80105515:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80105518:	6a 68                	push   $0x68
8010551a:	68 a0 00 00 00       	push   $0xa0
8010551f:	e8 bb fe ff ff       	call   801053df <outb>
80105524:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80105527:	6a 0a                	push   $0xa
80105529:	68 a0 00 00 00       	push   $0xa0
8010552e:	e8 ac fe ff ff       	call   801053df <outb>
80105533:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80105536:	0f b7 05 5c 90 12 80 	movzwl 0x8012905c,%eax
8010553d:	66 83 f8 ff          	cmp    $0xffff,%ax
80105541:	74 13                	je     80105556 <picinit+0xe6>
    picsetmask(irqmask);
80105543:	0f b7 05 5c 90 12 80 	movzwl 0x8012905c,%eax
8010554a:	0f b7 c0             	movzwl %ax,%eax
8010554d:	50                   	push   %eax
8010554e:	e8 ab fe ff ff       	call   801053fe <picsetmask>
80105553:	83 c4 04             	add    $0x4,%esp
}
80105556:	90                   	nop
80105557:	c9                   	leave  
80105558:	c3                   	ret    

80105559 <pipealloc>:
  struct selproc selprocwrite;
};

int
pipealloc(struct file **f0, struct file **f1)
{
80105559:	55                   	push   %ebp
8010555a:	89 e5                	mov    %esp,%ebp
8010555c:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
8010555f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80105566:	8b 45 0c             	mov    0xc(%ebp),%eax
80105569:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010556f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105572:	8b 10                	mov    (%eax),%edx
80105574:	8b 45 08             	mov    0x8(%ebp),%eax
80105577:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80105579:	e8 88 c4 ff ff       	call   80101a06 <filealloc>
8010557e:	89 c2                	mov    %eax,%edx
80105580:	8b 45 08             	mov    0x8(%ebp),%eax
80105583:	89 10                	mov    %edx,(%eax)
80105585:	8b 45 08             	mov    0x8(%ebp),%eax
80105588:	8b 00                	mov    (%eax),%eax
8010558a:	85 c0                	test   %eax,%eax
8010558c:	0f 84 f2 00 00 00    	je     80105684 <pipealloc+0x12b>
80105592:	e8 6f c4 ff ff       	call   80101a06 <filealloc>
80105597:	89 c2                	mov    %eax,%edx
80105599:	8b 45 0c             	mov    0xc(%ebp),%eax
8010559c:	89 10                	mov    %edx,(%eax)
8010559e:	8b 45 0c             	mov    0xc(%ebp),%eax
801055a1:	8b 00                	mov    (%eax),%eax
801055a3:	85 c0                	test   %eax,%eax
801055a5:	0f 84 d9 00 00 00    	je     80105684 <pipealloc+0x12b>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801055ab:	e8 ce e4 ff ff       	call   80103a7e <kalloc>
801055b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801055b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801055b7:	0f 84 ca 00 00 00    	je     80105687 <pipealloc+0x12e>
    goto bad;
  p->readopen = 1;
801055bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055c0:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801055c7:	00 00 00 
  p->writeopen = 1;
801055ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055cd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801055d4:	00 00 00 
  p->nwrite = 0;
801055d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055da:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801055e1:	00 00 00 
  p->nread = 0;
801055e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e7:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801055ee:	00 00 00 
  
  initselproc(&p->selprocread);
801055f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055f4:	05 44 02 00 00       	add    $0x244,%eax
801055f9:	83 ec 0c             	sub    $0xc,%esp
801055fc:	50                   	push   %eax
801055fd:	e8 49 48 00 00       	call   80109e4b <initselproc>
80105602:	83 c4 10             	add    $0x10,%esp
  initselproc(&p->selprocwrite);
80105605:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105608:	05 c8 02 00 00       	add    $0x2c8,%eax
8010560d:	83 ec 0c             	sub    $0xc,%esp
80105610:	50                   	push   %eax
80105611:	e8 35 48 00 00       	call   80109e4b <initselproc>
80105616:	83 c4 10             	add    $0x10,%esp
 
  initlock(&p->lock, "pipe");
80105619:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010561c:	83 ec 08             	sub    $0x8,%esp
8010561f:	68 7b b7 10 80       	push   $0x8010b77b
80105624:	50                   	push   %eax
80105625:	e8 71 0f 00 00       	call   8010659b <initlock>
8010562a:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010562d:	8b 45 08             	mov    0x8(%ebp),%eax
80105630:	8b 00                	mov    (%eax),%eax
80105632:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80105638:	8b 45 08             	mov    0x8(%ebp),%eax
8010563b:	8b 00                	mov    (%eax),%eax
8010563d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80105641:	8b 45 08             	mov    0x8(%ebp),%eax
80105644:	8b 00                	mov    (%eax),%eax
80105646:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010564a:	8b 45 08             	mov    0x8(%ebp),%eax
8010564d:	8b 00                	mov    (%eax),%eax
8010564f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105652:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80105655:	8b 45 0c             	mov    0xc(%ebp),%eax
80105658:	8b 00                	mov    (%eax),%eax
8010565a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80105660:	8b 45 0c             	mov    0xc(%ebp),%eax
80105663:	8b 00                	mov    (%eax),%eax
80105665:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80105669:	8b 45 0c             	mov    0xc(%ebp),%eax
8010566c:	8b 00                	mov    (%eax),%eax
8010566e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80105672:	8b 45 0c             	mov    0xc(%ebp),%eax
80105675:	8b 00                	mov    (%eax),%eax
80105677:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010567a:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
8010567d:	b8 00 00 00 00       	mov    $0x0,%eax
80105682:	eb 51                	jmp    801056d5 <pipealloc+0x17c>

//PAGEBREAK: 20
 bad:
80105684:	90                   	nop
80105685:	eb 01                	jmp    80105688 <pipealloc+0x12f>
    goto bad;
80105687:	90                   	nop
  if(p)
80105688:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010568c:	74 0e                	je     8010569c <pipealloc+0x143>
    kfree((char*)p);
8010568e:	83 ec 0c             	sub    $0xc,%esp
80105691:	ff 75 f4             	pushl  -0xc(%ebp)
80105694:	e8 60 e3 ff ff       	call   801039f9 <kfree>
80105699:	83 c4 10             	add    $0x10,%esp
  if(*f0)
8010569c:	8b 45 08             	mov    0x8(%ebp),%eax
8010569f:	8b 00                	mov    (%eax),%eax
801056a1:	85 c0                	test   %eax,%eax
801056a3:	74 11                	je     801056b6 <pipealloc+0x15d>
    fileclose(*f0);
801056a5:	8b 45 08             	mov    0x8(%ebp),%eax
801056a8:	8b 00                	mov    (%eax),%eax
801056aa:	83 ec 0c             	sub    $0xc,%esp
801056ad:	50                   	push   %eax
801056ae:	e8 11 c4 ff ff       	call   80101ac4 <fileclose>
801056b3:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801056b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801056b9:	8b 00                	mov    (%eax),%eax
801056bb:	85 c0                	test   %eax,%eax
801056bd:	74 11                	je     801056d0 <pipealloc+0x177>
    fileclose(*f1);
801056bf:	8b 45 0c             	mov    0xc(%ebp),%eax
801056c2:	8b 00                	mov    (%eax),%eax
801056c4:	83 ec 0c             	sub    $0xc,%esp
801056c7:	50                   	push   %eax
801056c8:	e8 f7 c3 ff ff       	call   80101ac4 <fileclose>
801056cd:	83 c4 10             	add    $0x10,%esp
  return -1;
801056d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056d5:	c9                   	leave  
801056d6:	c3                   	ret    

801056d7 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801056d7:	55                   	push   %ebp
801056d8:	89 e5                	mov    %esp,%ebp
801056da:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
801056dd:	8b 45 08             	mov    0x8(%ebp),%eax
801056e0:	83 ec 0c             	sub    $0xc,%esp
801056e3:	50                   	push   %eax
801056e4:	e8 d4 0e 00 00       	call   801065bd <acquire>
801056e9:	83 c4 10             	add    $0x10,%esp
  if(writable){
801056ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801056f0:	74 23                	je     80105715 <pipeclose+0x3e>
    p->writeopen = 0;
801056f2:	8b 45 08             	mov    0x8(%ebp),%eax
801056f5:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801056fc:	00 00 00 
    // Wake up anything waiting to read
    // Lab 4: Your code here.
    
    wakeup(&p->nread);
801056ff:	8b 45 08             	mov    0x8(%ebp),%eax
80105702:	05 34 02 00 00       	add    $0x234,%eax
80105707:	83 ec 0c             	sub    $0xc,%esp
8010570a:	50                   	push   %eax
8010570b:	e8 99 0c 00 00       	call   801063a9 <wakeup>
80105710:	83 c4 10             	add    $0x10,%esp
80105713:	eb 21                	jmp    80105736 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80105715:	8b 45 08             	mov    0x8(%ebp),%eax
80105718:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
8010571f:	00 00 00 
    // Wake up anything waiting to write
    // LAB 4: Your code here
    
    wakeup(&p->nwrite);
80105722:	8b 45 08             	mov    0x8(%ebp),%eax
80105725:	05 38 02 00 00       	add    $0x238,%eax
8010572a:	83 ec 0c             	sub    $0xc,%esp
8010572d:	50                   	push   %eax
8010572e:	e8 76 0c 00 00       	call   801063a9 <wakeup>
80105733:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80105736:	8b 45 08             	mov    0x8(%ebp),%eax
80105739:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
8010573f:	85 c0                	test   %eax,%eax
80105741:	75 2c                	jne    8010576f <pipeclose+0x98>
80105743:	8b 45 08             	mov    0x8(%ebp),%eax
80105746:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010574c:	85 c0                	test   %eax,%eax
8010574e:	75 1f                	jne    8010576f <pipeclose+0x98>
    release(&p->lock);
80105750:	8b 45 08             	mov    0x8(%ebp),%eax
80105753:	83 ec 0c             	sub    $0xc,%esp
80105756:	50                   	push   %eax
80105757:	e8 cd 0e 00 00       	call   80106629 <release>
8010575c:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
8010575f:	83 ec 0c             	sub    $0xc,%esp
80105762:	ff 75 08             	pushl  0x8(%ebp)
80105765:	e8 8f e2 ff ff       	call   801039f9 <kfree>
8010576a:	83 c4 10             	add    $0x10,%esp
8010576d:	eb 0f                	jmp    8010577e <pipeclose+0xa7>
  } else
    release(&p->lock);
8010576f:	8b 45 08             	mov    0x8(%ebp),%eax
80105772:	83 ec 0c             	sub    $0xc,%esp
80105775:	50                   	push   %eax
80105776:	e8 ae 0e 00 00       	call   80106629 <release>
8010577b:	83 c4 10             	add    $0x10,%esp
}
8010577e:	90                   	nop
8010577f:	c9                   	leave  
80105780:	c3                   	ret    

80105781 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80105781:	55                   	push   %ebp
80105782:	89 e5                	mov    %esp,%ebp
80105784:	53                   	push   %ebx
80105785:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80105788:	8b 45 08             	mov    0x8(%ebp),%eax
8010578b:	83 ec 0c             	sub    $0xc,%esp
8010578e:	50                   	push   %eax
8010578f:	e8 29 0e 00 00       	call   801065bd <acquire>
80105794:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80105797:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010579e:	e9 c6 00 00 00       	jmp    80105869 <pipewrite+0xe8>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
801057a3:	8b 45 08             	mov    0x8(%ebp),%eax
801057a6:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801057ac:	85 c0                	test   %eax,%eax
801057ae:	74 0d                	je     801057bd <pipewrite+0x3c>
801057b0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057b6:	8b 40 24             	mov    0x24(%eax),%eax
801057b9:	85 c0                	test   %eax,%eax
801057bb:	74 19                	je     801057d6 <pipewrite+0x55>
        release(&p->lock);
801057bd:	8b 45 08             	mov    0x8(%ebp),%eax
801057c0:	83 ec 0c             	sub    $0xc,%esp
801057c3:	50                   	push   %eax
801057c4:	e8 60 0e 00 00       	call   80106629 <release>
801057c9:	83 c4 10             	add    $0x10,%esp
        return -1;
801057cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057d1:	e9 c1 00 00 00       	jmp    80105897 <pipewrite+0x116>
      }
      wakeupselect(&p->selprocread);
801057d6:	8b 45 08             	mov    0x8(%ebp),%eax
801057d9:	05 44 02 00 00       	add    $0x244,%eax
801057de:	83 ec 0c             	sub    $0xc,%esp
801057e1:	50                   	push   %eax
801057e2:	e8 41 47 00 00       	call   80109f28 <wakeupselect>
801057e7:	83 c4 10             	add    $0x10,%esp
      wakeup(&p->nread);
801057ea:	8b 45 08             	mov    0x8(%ebp),%eax
801057ed:	05 34 02 00 00       	add    $0x234,%eax
801057f2:	83 ec 0c             	sub    $0xc,%esp
801057f5:	50                   	push   %eax
801057f6:	e8 ae 0b 00 00       	call   801063a9 <wakeup>
801057fb:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801057fe:	8b 45 08             	mov    0x8(%ebp),%eax
80105801:	8b 55 08             	mov    0x8(%ebp),%edx
80105804:	81 c2 38 02 00 00    	add    $0x238,%edx
8010580a:	83 ec 08             	sub    $0x8,%esp
8010580d:	50                   	push   %eax
8010580e:	52                   	push   %edx
8010580f:	e8 a7 0a 00 00       	call   801062bb <sleep>
80105814:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80105817:	8b 45 08             	mov    0x8(%ebp),%eax
8010581a:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80105820:	8b 45 08             	mov    0x8(%ebp),%eax
80105823:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80105829:	05 00 02 00 00       	add    $0x200,%eax
8010582e:	39 c2                	cmp    %eax,%edx
80105830:	0f 84 6d ff ff ff    	je     801057a3 <pipewrite+0x22>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80105836:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105839:	8b 45 0c             	mov    0xc(%ebp),%eax
8010583c:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010583f:	8b 45 08             	mov    0x8(%ebp),%eax
80105842:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80105848:	8d 48 01             	lea    0x1(%eax),%ecx
8010584b:	8b 55 08             	mov    0x8(%ebp),%edx
8010584e:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80105854:	25 ff 01 00 00       	and    $0x1ff,%eax
80105859:	89 c1                	mov    %eax,%ecx
8010585b:	0f b6 13             	movzbl (%ebx),%edx
8010585e:	8b 45 08             	mov    0x8(%ebp),%eax
80105861:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
  for(i = 0; i < n; i++){
80105865:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105869:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010586c:	3b 45 10             	cmp    0x10(%ebp),%eax
8010586f:	7c a6                	jl     80105817 <pipewrite+0x96>
  }
  
  // Wake up anything waiting to read
  // LAB 4: Your code here
  
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80105871:	8b 45 08             	mov    0x8(%ebp),%eax
80105874:	05 34 02 00 00       	add    $0x234,%eax
80105879:	83 ec 0c             	sub    $0xc,%esp
8010587c:	50                   	push   %eax
8010587d:	e8 27 0b 00 00       	call   801063a9 <wakeup>
80105882:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80105885:	8b 45 08             	mov    0x8(%ebp),%eax
80105888:	83 ec 0c             	sub    $0xc,%esp
8010588b:	50                   	push   %eax
8010588c:	e8 98 0d 00 00       	call   80106629 <release>
80105891:	83 c4 10             	add    $0x10,%esp
  return n;
80105894:	8b 45 10             	mov    0x10(%ebp),%eax
}
80105897:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010589a:	c9                   	leave  
8010589b:	c3                   	ret    

8010589c <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
8010589c:	55                   	push   %ebp
8010589d:	89 e5                	mov    %esp,%ebp
8010589f:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801058a2:	8b 45 08             	mov    0x8(%ebp),%eax
801058a5:	83 ec 0c             	sub    $0xc,%esp
801058a8:	50                   	push   %eax
801058a9:	e8 0f 0d 00 00       	call   801065bd <acquire>
801058ae:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801058b1:	eb 3f                	jmp    801058f2 <piperead+0x56>
    if(proc->killed){
801058b3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058b9:	8b 40 24             	mov    0x24(%eax),%eax
801058bc:	85 c0                	test   %eax,%eax
801058be:	74 19                	je     801058d9 <piperead+0x3d>
      release(&p->lock);
801058c0:	8b 45 08             	mov    0x8(%ebp),%eax
801058c3:	83 ec 0c             	sub    $0xc,%esp
801058c6:	50                   	push   %eax
801058c7:	e8 5d 0d 00 00       	call   80106629 <release>
801058cc:	83 c4 10             	add    $0x10,%esp
      return -1;
801058cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058d4:	e9 be 00 00 00       	jmp    80105997 <piperead+0xfb>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801058d9:	8b 45 08             	mov    0x8(%ebp),%eax
801058dc:	8b 55 08             	mov    0x8(%ebp),%edx
801058df:	81 c2 34 02 00 00    	add    $0x234,%edx
801058e5:	83 ec 08             	sub    $0x8,%esp
801058e8:	50                   	push   %eax
801058e9:	52                   	push   %edx
801058ea:	e8 cc 09 00 00       	call   801062bb <sleep>
801058ef:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801058f2:	8b 45 08             	mov    0x8(%ebp),%eax
801058f5:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801058fb:	8b 45 08             	mov    0x8(%ebp),%eax
801058fe:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80105904:	39 c2                	cmp    %eax,%edx
80105906:	75 0d                	jne    80105915 <piperead+0x79>
80105908:	8b 45 08             	mov    0x8(%ebp),%eax
8010590b:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80105911:	85 c0                	test   %eax,%eax
80105913:	75 9e                	jne    801058b3 <piperead+0x17>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80105915:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010591c:	eb 48                	jmp    80105966 <piperead+0xca>
    if(p->nread == p->nwrite)
8010591e:	8b 45 08             	mov    0x8(%ebp),%eax
80105921:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80105927:	8b 45 08             	mov    0x8(%ebp),%eax
8010592a:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80105930:	39 c2                	cmp    %eax,%edx
80105932:	74 3c                	je     80105970 <piperead+0xd4>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80105934:	8b 45 08             	mov    0x8(%ebp),%eax
80105937:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010593d:	8d 48 01             	lea    0x1(%eax),%ecx
80105940:	8b 55 08             	mov    0x8(%ebp),%edx
80105943:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80105949:	25 ff 01 00 00       	and    $0x1ff,%eax
8010594e:	89 c1                	mov    %eax,%ecx
80105950:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105953:	8b 45 0c             	mov    0xc(%ebp),%eax
80105956:	01 c2                	add    %eax,%edx
80105958:	8b 45 08             	mov    0x8(%ebp),%eax
8010595b:	0f b6 44 08 34       	movzbl 0x34(%eax,%ecx,1),%eax
80105960:	88 02                	mov    %al,(%edx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80105962:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80105966:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105969:	3b 45 10             	cmp    0x10(%ebp),%eax
8010596c:	7c b0                	jl     8010591e <piperead+0x82>
8010596e:	eb 01                	jmp    80105971 <piperead+0xd5>
      break;
80105970:	90                   	nop
  }
  
  // Wake up anything waiting to write
  // LAB 4: Your code here
  
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80105971:	8b 45 08             	mov    0x8(%ebp),%eax
80105974:	05 38 02 00 00       	add    $0x238,%eax
80105979:	83 ec 0c             	sub    $0xc,%esp
8010597c:	50                   	push   %eax
8010597d:	e8 27 0a 00 00       	call   801063a9 <wakeup>
80105982:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80105985:	8b 45 08             	mov    0x8(%ebp),%eax
80105988:	83 ec 0c             	sub    $0xc,%esp
8010598b:	50                   	push   %eax
8010598c:	e8 98 0c 00 00       	call   80106629 <release>
80105991:	83 c4 10             	add    $0x10,%esp
  return i;
80105994:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105997:	c9                   	leave  
80105998:	c3                   	ret    

80105999 <pipewriteable>:
 * 1. Return -1 if the pipe is not open for reading or the process has been killed.
 * 2. Check if the pipe is writeable and return 1 if yes and 0 if not.
 */
int
pipewriteable(struct pipe *p)
{
80105999:	55                   	push   %ebp
8010599a:	89 e5                	mov    %esp,%ebp
    // LAB 4: Your code here
    return 0;
8010599c:	b8 00 00 00 00       	mov    $0x0,%eax
}
801059a1:	5d                   	pop    %ebp
801059a2:	c3                   	ret    

801059a3 <pipereadable>:
 * 1. If the process has been killed, return -1.
 * 2. If the pipe is non-empty or closed, return 1; otherwise 0.
 */
int
pipereadable(struct pipe *p)
{
801059a3:	55                   	push   %ebp
801059a4:	89 e5                	mov    %esp,%ebp
    // LAB 4: Your code here
    return 0;
801059a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
801059ab:	5d                   	pop    %ebp
801059ac:	c3                   	ret    

801059ad <pipeselect>:
 * 1. Use addselid to add the selid channel to the list of wakeups
 *
 */
int
pipeselect(struct pipe *p, int * selid, struct spinlock * lk)
{
801059ad:	55                   	push   %ebp
801059ae:	89 e5                	mov    %esp,%ebp
       
    // LAB 4: Your code here.

    return 0;
801059b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
801059b5:	5d                   	pop    %ebp
801059b6:	c3                   	ret    

801059b7 <pipeclrsel>:
 *
 * 1. Clear a selid from the list of wakeups.
 */
int
pipeclrsel(struct pipe *p, int * selid)
{
801059b7:	55                   	push   %ebp
801059b8:	89 e5                	mov    %esp,%ebp

    // LAB 4: Your code here.

    return 0;
801059ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
801059bf:	5d                   	pop    %ebp
801059c0:	c3                   	ret    

801059c1 <readeflags>:
{
801059c1:	55                   	push   %ebp
801059c2:	89 e5                	mov    %esp,%ebp
801059c4:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801059c7:	9c                   	pushf  
801059c8:	58                   	pop    %eax
801059c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801059cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801059cf:	c9                   	leave  
801059d0:	c3                   	ret    

801059d1 <sti>:
{
801059d1:	55                   	push   %ebp
801059d2:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801059d4:	fb                   	sti    
}
801059d5:	90                   	nop
801059d6:	5d                   	pop    %ebp
801059d7:	c3                   	ret    

801059d8 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801059d8:	55                   	push   %ebp
801059d9:	89 e5                	mov    %esp,%ebp
801059db:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
801059de:	83 ec 08             	sub    $0x8,%esp
801059e1:	68 80 b7 10 80       	push   $0x8010b780
801059e6:	68 e0 18 13 80       	push   $0x801318e0
801059eb:	e8 ab 0b 00 00       	call   8010659b <initlock>
801059f0:	83 c4 10             	add    $0x10,%esp
}
801059f3:	90                   	nop
801059f4:	c9                   	leave  
801059f5:	c3                   	ret    

801059f6 <allocproc>:
// state required to run in the kernel.
// Otherwise return 0.
// Must hold ptable.lock.
static struct proc*
allocproc(void)
{
801059f6:	55                   	push   %ebp
801059f7:	89 e5                	mov    %esp,%ebp
801059f9:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801059fc:	c7 45 f4 14 19 13 80 	movl   $0x80131914,-0xc(%ebp)
80105a03:	eb 11                	jmp    80105a16 <allocproc+0x20>
    if(p->state == UNUSED)
80105a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a08:	8b 40 0c             	mov    0xc(%eax),%eax
80105a0b:	85 c0                	test   %eax,%eax
80105a0d:	74 1a                	je     80105a29 <allocproc+0x33>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105a0f:	81 45 f4 b4 00 00 00 	addl   $0xb4,-0xc(%ebp)
80105a16:	81 7d f4 14 46 13 80 	cmpl   $0x80134614,-0xc(%ebp)
80105a1d:	72 e6                	jb     80105a05 <allocproc+0xf>
      goto found;
  return 0;
80105a1f:	b8 00 00 00 00       	mov    $0x0,%eax
80105a24:	e9 bb 00 00 00       	jmp    80105ae4 <allocproc+0xee>
      goto found;
80105a29:	90                   	nop

found:
  p->state = EMBRYO;
80105a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a2d:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
80105a34:	a1 60 90 12 80       	mov    0x80129060,%eax
80105a39:	8d 50 01             	lea    0x1(%eax),%edx
80105a3c:	89 15 60 90 12 80    	mov    %edx,0x80129060
80105a42:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a45:	89 42 10             	mov    %eax,0x10(%edx)

  initlock(&p->selectlock, "select");
80105a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a4b:	83 e8 80             	sub    $0xffffff80,%eax
80105a4e:	83 ec 08             	sub    $0x8,%esp
80105a51:	68 87 b7 10 80       	push   $0x8010b787
80105a56:	50                   	push   %eax
80105a57:	e8 3f 0b 00 00       	call   8010659b <initlock>
80105a5c:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80105a5f:	e8 1a e0 ff ff       	call   80103a7e <kalloc>
80105a64:	89 c2                	mov    %eax,%edx
80105a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a69:	89 50 08             	mov    %edx,0x8(%eax)
80105a6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a6f:	8b 40 08             	mov    0x8(%eax),%eax
80105a72:	85 c0                	test   %eax,%eax
80105a74:	75 11                	jne    80105a87 <allocproc+0x91>
    p->state = UNUSED;
80105a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a79:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80105a80:	b8 00 00 00 00       	mov    $0x0,%eax
80105a85:	eb 5d                	jmp    80105ae4 <allocproc+0xee>
  }
  sp = p->kstack + KSTACKSIZE;
80105a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a8a:	8b 40 08             	mov    0x8(%eax),%eax
80105a8d:	05 00 10 00 00       	add    $0x1000,%eax
80105a92:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80105a95:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
80105a99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a9c:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a9f:	89 50 18             	mov    %edx,0x18(%eax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80105aa2:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
80105aa6:	ba 33 7f 10 80       	mov    $0x80107f33,%edx
80105aab:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105aae:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80105ab0:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
80105ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ab7:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105aba:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80105abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ac0:	8b 40 1c             	mov    0x1c(%eax),%eax
80105ac3:	83 ec 04             	sub    $0x4,%esp
80105ac6:	6a 14                	push   $0x14
80105ac8:	6a 00                	push   $0x0
80105aca:	50                   	push   %eax
80105acb:	e8 63 0d 00 00       	call   80106833 <memset>
80105ad0:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80105ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ad6:	8b 40 1c             	mov    0x1c(%eax),%eax
80105ad9:	ba 75 62 10 80       	mov    $0x80106275,%edx
80105ade:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80105ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105ae4:	c9                   	leave  
80105ae5:	c3                   	ret    

80105ae6 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80105ae6:	55                   	push   %ebp
80105ae7:	89 e5                	mov    %esp,%ebp
80105ae9:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  acquire(&ptable.lock);
80105aec:	83 ec 0c             	sub    $0xc,%esp
80105aef:	68 e0 18 13 80       	push   $0x801318e0
80105af4:	e8 c4 0a 00 00       	call   801065bd <acquire>
80105af9:	83 c4 10             	add    $0x10,%esp

  p = allocproc();
80105afc:	e8 f5 fe ff ff       	call   801059f6 <allocproc>
80105b01:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
80105b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b07:	a3 cc 96 12 80       	mov    %eax,0x801296cc
  if((p->pgdir = setupkvm()) == 0)
80105b0c:	e8 39 3b 00 00       	call   8010964a <setupkvm>
80105b11:	89 c2                	mov    %eax,%edx
80105b13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b16:	89 50 04             	mov    %edx,0x4(%eax)
80105b19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b1c:	8b 40 04             	mov    0x4(%eax),%eax
80105b1f:	85 c0                	test   %eax,%eax
80105b21:	75 0d                	jne    80105b30 <userinit+0x4a>
    panic("userinit: out of memory?");
80105b23:	83 ec 0c             	sub    $0xc,%esp
80105b26:	68 8e b7 10 80       	push   $0x8010b78e
80105b2b:	e8 0e b3 ff ff       	call   80100e3e <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80105b30:	ba 2c 00 00 00       	mov    $0x2c,%edx
80105b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b38:	8b 40 04             	mov    0x4(%eax),%eax
80105b3b:	83 ec 04             	sub    $0x4,%esp
80105b3e:	52                   	push   %edx
80105b3f:	68 58 95 12 80       	push   $0x80129558
80105b44:	50                   	push   %eax
80105b45:	e8 35 3d 00 00       	call   8010987f <inituvm>
80105b4a:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
80105b4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b50:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80105b56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b59:	8b 40 18             	mov    0x18(%eax),%eax
80105b5c:	83 ec 04             	sub    $0x4,%esp
80105b5f:	6a 4c                	push   $0x4c
80105b61:	6a 00                	push   $0x0
80105b63:	50                   	push   %eax
80105b64:	e8 ca 0c 00 00       	call   80106833 <memset>
80105b69:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80105b6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b6f:	8b 40 18             	mov    0x18(%eax),%eax
80105b72:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80105b78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b7b:	8b 40 18             	mov    0x18(%eax),%eax
80105b7e:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
80105b84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b87:	8b 50 18             	mov    0x18(%eax),%edx
80105b8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b8d:	8b 40 18             	mov    0x18(%eax),%eax
80105b90:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80105b94:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80105b98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b9b:	8b 50 18             	mov    0x18(%eax),%edx
80105b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ba1:	8b 40 18             	mov    0x18(%eax),%eax
80105ba4:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80105ba8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80105bac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105baf:	8b 40 18             	mov    0x18(%eax),%eax
80105bb2:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80105bb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bbc:	8b 40 18             	mov    0x18(%eax),%eax
80105bbf:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80105bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bc9:	8b 40 18             	mov    0x18(%eax),%eax
80105bcc:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80105bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bd6:	83 c0 6c             	add    $0x6c,%eax
80105bd9:	83 ec 04             	sub    $0x4,%esp
80105bdc:	6a 10                	push   $0x10
80105bde:	68 a7 b7 10 80       	push   $0x8010b7a7
80105be3:	50                   	push   %eax
80105be4:	e8 7d 0e 00 00       	call   80106a66 <safestrcpy>
80105be9:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
80105bec:	83 ec 0c             	sub    $0xc,%esp
80105bef:	68 b0 b7 10 80       	push   $0x8010b7b0
80105bf4:	e8 11 d5 ff ff       	call   8010310a <namei>
80105bf9:	83 c4 10             	add    $0x10,%esp
80105bfc:	89 c2                	mov    %eax,%edx
80105bfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c01:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
80105c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c07:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
80105c0e:	83 ec 0c             	sub    $0xc,%esp
80105c11:	68 e0 18 13 80       	push   $0x801318e0
80105c16:	e8 0e 0a 00 00       	call   80106629 <release>
80105c1b:	83 c4 10             	add    $0x10,%esp
}
80105c1e:	90                   	nop
80105c1f:	c9                   	leave  
80105c20:	c3                   	ret    

80105c21 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80105c21:	55                   	push   %ebp
80105c22:	89 e5                	mov    %esp,%ebp
80105c24:	83 ec 18             	sub    $0x18,%esp
  uint sz;

  sz = proc->sz;
80105c27:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c2d:	8b 00                	mov    (%eax),%eax
80105c2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80105c32:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80105c36:	7e 31                	jle    80105c69 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80105c38:	8b 55 08             	mov    0x8(%ebp),%edx
80105c3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c3e:	01 c2                	add    %eax,%edx
80105c40:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c46:	8b 40 04             	mov    0x4(%eax),%eax
80105c49:	83 ec 04             	sub    $0x4,%esp
80105c4c:	52                   	push   %edx
80105c4d:	ff 75 f4             	pushl  -0xc(%ebp)
80105c50:	50                   	push   %eax
80105c51:	e8 66 3d 00 00       	call   801099bc <allocuvm>
80105c56:	83 c4 10             	add    $0x10,%esp
80105c59:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c5c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c60:	75 3e                	jne    80105ca0 <growproc+0x7f>
      return -1;
80105c62:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c67:	eb 59                	jmp    80105cc2 <growproc+0xa1>
  } else if(n < 0){
80105c69:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80105c6d:	79 31                	jns    80105ca0 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80105c6f:	8b 55 08             	mov    0x8(%ebp),%edx
80105c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c75:	01 c2                	add    %eax,%edx
80105c77:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c7d:	8b 40 04             	mov    0x4(%eax),%eax
80105c80:	83 ec 04             	sub    $0x4,%esp
80105c83:	52                   	push   %edx
80105c84:	ff 75 f4             	pushl  -0xc(%ebp)
80105c87:	50                   	push   %eax
80105c88:	e8 34 3e 00 00       	call   80109ac1 <deallocuvm>
80105c8d:	83 c4 10             	add    $0x10,%esp
80105c90:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c93:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c97:	75 07                	jne    80105ca0 <growproc+0x7f>
      return -1;
80105c99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c9e:	eb 22                	jmp    80105cc2 <growproc+0xa1>
  }
  proc->sz = sz;
80105ca0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ca6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ca9:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
80105cab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105cb1:	83 ec 0c             	sub    $0xc,%esp
80105cb4:	50                   	push   %eax
80105cb5:	e8 4c 3a 00 00       	call   80109706 <switchuvm>
80105cba:	83 c4 10             	add    $0x10,%esp
  return 0;
80105cbd:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105cc2:	c9                   	leave  
80105cc3:	c3                   	ret    

80105cc4 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80105cc4:	55                   	push   %ebp
80105cc5:	89 e5                	mov    %esp,%ebp
80105cc7:	57                   	push   %edi
80105cc8:	56                   	push   %esi
80105cc9:	53                   	push   %ebx
80105cca:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  acquire(&ptable.lock);
80105ccd:	83 ec 0c             	sub    $0xc,%esp
80105cd0:	68 e0 18 13 80       	push   $0x801318e0
80105cd5:	e8 e3 08 00 00       	call   801065bd <acquire>
80105cda:	83 c4 10             	add    $0x10,%esp

  // Allocate process.
  if((np = allocproc()) == 0){
80105cdd:	e8 14 fd ff ff       	call   801059f6 <allocproc>
80105ce2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ce5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80105ce9:	75 1a                	jne    80105d05 <fork+0x41>
    release(&ptable.lock);
80105ceb:	83 ec 0c             	sub    $0xc,%esp
80105cee:	68 e0 18 13 80       	push   $0x801318e0
80105cf3:	e8 31 09 00 00       	call   80106629 <release>
80105cf8:	83 c4 10             	add    $0x10,%esp
    return -1;
80105cfb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d00:	e9 6a 01 00 00       	jmp    80105e6f <fork+0x1ab>
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80105d05:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d0b:	8b 10                	mov    (%eax),%edx
80105d0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d13:	8b 40 04             	mov    0x4(%eax),%eax
80105d16:	83 ec 08             	sub    $0x8,%esp
80105d19:	52                   	push   %edx
80105d1a:	50                   	push   %eax
80105d1b:	e8 2f 3f 00 00       	call   80109c4f <copyuvm>
80105d20:	83 c4 10             	add    $0x10,%esp
80105d23:	89 c2                	mov    %eax,%edx
80105d25:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d28:	89 50 04             	mov    %edx,0x4(%eax)
80105d2b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d2e:	8b 40 04             	mov    0x4(%eax),%eax
80105d31:	85 c0                	test   %eax,%eax
80105d33:	75 40                	jne    80105d75 <fork+0xb1>
    kfree(np->kstack);
80105d35:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d38:	8b 40 08             	mov    0x8(%eax),%eax
80105d3b:	83 ec 0c             	sub    $0xc,%esp
80105d3e:	50                   	push   %eax
80105d3f:	e8 b5 dc ff ff       	call   801039f9 <kfree>
80105d44:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80105d47:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d4a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80105d51:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d54:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    release(&ptable.lock);
80105d5b:	83 ec 0c             	sub    $0xc,%esp
80105d5e:	68 e0 18 13 80       	push   $0x801318e0
80105d63:	e8 c1 08 00 00       	call   80106629 <release>
80105d68:	83 c4 10             	add    $0x10,%esp
    return -1;
80105d6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d70:	e9 fa 00 00 00       	jmp    80105e6f <fork+0x1ab>
  }
  np->sz = proc->sz;
80105d75:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d7b:	8b 10                	mov    (%eax),%edx
80105d7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d80:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80105d82:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105d89:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d8c:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
80105d8f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d95:	8b 48 18             	mov    0x18(%eax),%ecx
80105d98:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d9b:	8b 40 18             	mov    0x18(%eax),%eax
80105d9e:	89 c2                	mov    %eax,%edx
80105da0:	89 cb                	mov    %ecx,%ebx
80105da2:	b8 13 00 00 00       	mov    $0x13,%eax
80105da7:	89 d7                	mov    %edx,%edi
80105da9:	89 de                	mov    %ebx,%esi
80105dab:	89 c1                	mov    %eax,%ecx
80105dad:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80105daf:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105db2:	8b 40 18             	mov    0x18(%eax),%eax
80105db5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
80105dbc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80105dc3:	eb 43                	jmp    80105e08 <fork+0x144>
    if(proc->ofile[i])
80105dc5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105dcb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105dce:	83 c2 08             	add    $0x8,%edx
80105dd1:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105dd5:	85 c0                	test   %eax,%eax
80105dd7:	74 2b                	je     80105e04 <fork+0x140>
      np->ofile[i] = filedup(proc->ofile[i]);
80105dd9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ddf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105de2:	83 c2 08             	add    $0x8,%edx
80105de5:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105de9:	83 ec 0c             	sub    $0xc,%esp
80105dec:	50                   	push   %eax
80105ded:	e8 81 bc ff ff       	call   80101a73 <filedup>
80105df2:	83 c4 10             	add    $0x10,%esp
80105df5:	89 c1                	mov    %eax,%ecx
80105df7:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105dfa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105dfd:	83 c2 08             	add    $0x8,%edx
80105e00:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  for(i = 0; i < NOFILE; i++)
80105e04:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80105e08:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80105e0c:	7e b7                	jle    80105dc5 <fork+0x101>
  np->cwd = idup(proc->cwd);
80105e0e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e14:	8b 40 68             	mov    0x68(%eax),%eax
80105e17:	83 ec 0c             	sub    $0xc,%esp
80105e1a:	50                   	push   %eax
80105e1b:	e8 c7 c6 ff ff       	call   801024e7 <idup>
80105e20:	83 c4 10             	add    $0x10,%esp
80105e23:	89 c2                	mov    %eax,%edx
80105e25:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e28:	89 50 68             	mov    %edx,0x68(%eax)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80105e2b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e31:	8d 50 6c             	lea    0x6c(%eax),%edx
80105e34:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e37:	83 c0 6c             	add    $0x6c,%eax
80105e3a:	83 ec 04             	sub    $0x4,%esp
80105e3d:	6a 10                	push   $0x10
80105e3f:	52                   	push   %edx
80105e40:	50                   	push   %eax
80105e41:	e8 20 0c 00 00       	call   80106a66 <safestrcpy>
80105e46:	83 c4 10             	add    $0x10,%esp

  pid = np->pid;
80105e49:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e4c:	8b 40 10             	mov    0x10(%eax),%eax
80105e4f:	89 45 dc             	mov    %eax,-0x24(%ebp)

  np->state = RUNNABLE;
80105e52:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e55:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
80105e5c:	83 ec 0c             	sub    $0xc,%esp
80105e5f:	68 e0 18 13 80       	push   $0x801318e0
80105e64:	e8 c0 07 00 00       	call   80106629 <release>
80105e69:	83 c4 10             	add    $0x10,%esp

  return pid;
80105e6c:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80105e6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e72:	5b                   	pop    %ebx
80105e73:	5e                   	pop    %esi
80105e74:	5f                   	pop    %edi
80105e75:	5d                   	pop    %ebp
80105e76:	c3                   	ret    

80105e77 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80105e77:	55                   	push   %ebp
80105e78:	89 e5                	mov    %esp,%ebp
80105e7a:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80105e7d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105e84:	a1 cc 96 12 80       	mov    0x801296cc,%eax
80105e89:	39 c2                	cmp    %eax,%edx
80105e8b:	75 0d                	jne    80105e9a <exit+0x23>
    panic("init exiting");
80105e8d:	83 ec 0c             	sub    $0xc,%esp
80105e90:	68 b2 b7 10 80       	push   $0x8010b7b2
80105e95:	e8 a4 af ff ff       	call   80100e3e <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80105e9a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80105ea1:	eb 48                	jmp    80105eeb <exit+0x74>
    if(proc->ofile[fd]){
80105ea3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ea9:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105eac:	83 c2 08             	add    $0x8,%edx
80105eaf:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105eb3:	85 c0                	test   %eax,%eax
80105eb5:	74 30                	je     80105ee7 <exit+0x70>
      fileclose(proc->ofile[fd]);
80105eb7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ebd:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105ec0:	83 c2 08             	add    $0x8,%edx
80105ec3:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105ec7:	83 ec 0c             	sub    $0xc,%esp
80105eca:	50                   	push   %eax
80105ecb:	e8 f4 bb ff ff       	call   80101ac4 <fileclose>
80105ed0:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
80105ed3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ed9:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105edc:	83 c2 08             	add    $0x8,%edx
80105edf:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105ee6:	00 
  for(fd = 0; fd < NOFILE; fd++){
80105ee7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80105eeb:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80105eef:	7e b2                	jle    80105ea3 <exit+0x2c>
    }
  }

  begin_op();
80105ef1:	e8 b6 e4 ff ff       	call   801043ac <begin_op>
  iput(proc->cwd);
80105ef6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105efc:	8b 40 68             	mov    0x68(%eax),%eax
80105eff:	83 ec 0c             	sub    $0xc,%esp
80105f02:	50                   	push   %eax
80105f03:	e8 e9 c7 ff ff       	call   801026f1 <iput>
80105f08:	83 c4 10             	add    $0x10,%esp
  end_op();
80105f0b:	e8 28 e5 ff ff       	call   80104438 <end_op>
  proc->cwd = 0;
80105f10:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f16:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80105f1d:	83 ec 0c             	sub    $0xc,%esp
80105f20:	68 e0 18 13 80       	push   $0x801318e0
80105f25:	e8 93 06 00 00       	call   801065bd <acquire>
80105f2a:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80105f2d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f33:	8b 40 14             	mov    0x14(%eax),%eax
80105f36:	83 ec 0c             	sub    $0xc,%esp
80105f39:	50                   	push   %eax
80105f3a:	e8 28 04 00 00       	call   80106367 <wakeup1>
80105f3f:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105f42:	c7 45 f4 14 19 13 80 	movl   $0x80131914,-0xc(%ebp)
80105f49:	eb 3f                	jmp    80105f8a <exit+0x113>
    if(p->parent == proc){
80105f4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f4e:	8b 50 14             	mov    0x14(%eax),%edx
80105f51:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f57:	39 c2                	cmp    %eax,%edx
80105f59:	75 28                	jne    80105f83 <exit+0x10c>
      p->parent = initproc;
80105f5b:	8b 15 cc 96 12 80    	mov    0x801296cc,%edx
80105f61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f64:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80105f67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f6a:	8b 40 0c             	mov    0xc(%eax),%eax
80105f6d:	83 f8 05             	cmp    $0x5,%eax
80105f70:	75 11                	jne    80105f83 <exit+0x10c>
        wakeup1(initproc);
80105f72:	a1 cc 96 12 80       	mov    0x801296cc,%eax
80105f77:	83 ec 0c             	sub    $0xc,%esp
80105f7a:	50                   	push   %eax
80105f7b:	e8 e7 03 00 00       	call   80106367 <wakeup1>
80105f80:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105f83:	81 45 f4 b4 00 00 00 	addl   $0xb4,-0xc(%ebp)
80105f8a:	81 7d f4 14 46 13 80 	cmpl   $0x80134614,-0xc(%ebp)
80105f91:	72 b8                	jb     80105f4b <exit+0xd4>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80105f93:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f99:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
80105fa0:	e8 d9 01 00 00       	call   8010617e <sched>
  panic("zombie exit");
80105fa5:	83 ec 0c             	sub    $0xc,%esp
80105fa8:	68 bf b7 10 80       	push   $0x8010b7bf
80105fad:	e8 8c ae ff ff       	call   80100e3e <panic>

80105fb2 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80105fb2:	55                   	push   %ebp
80105fb3:	89 e5                	mov    %esp,%ebp
80105fb5:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80105fb8:	83 ec 0c             	sub    $0xc,%esp
80105fbb:	68 e0 18 13 80       	push   $0x801318e0
80105fc0:	e8 f8 05 00 00       	call   801065bd <acquire>
80105fc5:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80105fc8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105fcf:	c7 45 f4 14 19 13 80 	movl   $0x80131914,-0xc(%ebp)
80105fd6:	e9 a9 00 00 00       	jmp    80106084 <wait+0xd2>
      if(p->parent != proc)
80105fdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fde:	8b 50 14             	mov    0x14(%eax),%edx
80105fe1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105fe7:	39 c2                	cmp    %eax,%edx
80105fe9:	0f 85 8d 00 00 00    	jne    8010607c <wait+0xca>
        continue;
      havekids = 1;
80105fef:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80105ff6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ff9:	8b 40 0c             	mov    0xc(%eax),%eax
80105ffc:	83 f8 05             	cmp    $0x5,%eax
80105fff:	75 7c                	jne    8010607d <wait+0xcb>
        // Found one.
        pid = p->pid;
80106001:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106004:	8b 40 10             	mov    0x10(%eax),%eax
80106007:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
8010600a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010600d:	8b 40 08             	mov    0x8(%eax),%eax
80106010:	83 ec 0c             	sub    $0xc,%esp
80106013:	50                   	push   %eax
80106014:	e8 e0 d9 ff ff       	call   801039f9 <kfree>
80106019:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
8010601c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010601f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80106026:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106029:	8b 40 04             	mov    0x4(%eax),%eax
8010602c:	83 ec 0c             	sub    $0xc,%esp
8010602f:	50                   	push   %eax
80106030:	e8 40 3b 00 00       	call   80109b75 <freevm>
80106035:	83 c4 10             	add    $0x10,%esp
        p->pid = 0;
80106038:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010603b:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80106042:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106045:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
8010604c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010604f:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80106053:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106056:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->state = UNUSED;
8010605d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106060:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        release(&ptable.lock);
80106067:	83 ec 0c             	sub    $0xc,%esp
8010606a:	68 e0 18 13 80       	push   $0x801318e0
8010606f:	e8 b5 05 00 00       	call   80106629 <release>
80106074:	83 c4 10             	add    $0x10,%esp
        return pid;
80106077:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010607a:	eb 5b                	jmp    801060d7 <wait+0x125>
        continue;
8010607c:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010607d:	81 45 f4 b4 00 00 00 	addl   $0xb4,-0xc(%ebp)
80106084:	81 7d f4 14 46 13 80 	cmpl   $0x80134614,-0xc(%ebp)
8010608b:	0f 82 4a ff ff ff    	jb     80105fdb <wait+0x29>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80106091:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106095:	74 0d                	je     801060a4 <wait+0xf2>
80106097:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010609d:	8b 40 24             	mov    0x24(%eax),%eax
801060a0:	85 c0                	test   %eax,%eax
801060a2:	74 17                	je     801060bb <wait+0x109>
      release(&ptable.lock);
801060a4:	83 ec 0c             	sub    $0xc,%esp
801060a7:	68 e0 18 13 80       	push   $0x801318e0
801060ac:	e8 78 05 00 00       	call   80106629 <release>
801060b1:	83 c4 10             	add    $0x10,%esp
      return -1;
801060b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060b9:	eb 1c                	jmp    801060d7 <wait+0x125>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
801060bb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801060c1:	83 ec 08             	sub    $0x8,%esp
801060c4:	68 e0 18 13 80       	push   $0x801318e0
801060c9:	50                   	push   %eax
801060ca:	e8 ec 01 00 00       	call   801062bb <sleep>
801060cf:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801060d2:	e9 f1 fe ff ff       	jmp    80105fc8 <wait+0x16>
  }
}
801060d7:	c9                   	leave  
801060d8:	c3                   	ret    

801060d9 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801060d9:	55                   	push   %ebp
801060da:	89 e5                	mov    %esp,%ebp
801060dc:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801060df:	e8 ed f8 ff ff       	call   801059d1 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801060e4:	83 ec 0c             	sub    $0xc,%esp
801060e7:	68 e0 18 13 80       	push   $0x801318e0
801060ec:	e8 cc 04 00 00       	call   801065bd <acquire>
801060f1:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801060f4:	c7 45 f4 14 19 13 80 	movl   $0x80131914,-0xc(%ebp)
801060fb:	eb 63                	jmp    80106160 <scheduler+0x87>
      if(p->state != RUNNABLE)
801060fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106100:	8b 40 0c             	mov    0xc(%eax),%eax
80106103:	83 f8 03             	cmp    $0x3,%eax
80106106:	75 50                	jne    80106158 <scheduler+0x7f>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80106108:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010610b:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80106111:	83 ec 0c             	sub    $0xc,%esp
80106114:	ff 75 f4             	pushl  -0xc(%ebp)
80106117:	e8 ea 35 00 00       	call   80109706 <switchuvm>
8010611c:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
8010611f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106122:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, p->context);
80106129:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010612c:	8b 40 1c             	mov    0x1c(%eax),%eax
8010612f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80106136:	83 c2 04             	add    $0x4,%edx
80106139:	83 ec 08             	sub    $0x8,%esp
8010613c:	50                   	push   %eax
8010613d:	52                   	push   %edx
8010613e:	e8 35 0a 00 00       	call   80106b78 <swtch>
80106143:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80106146:	e8 a2 35 00 00       	call   801096ed <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
8010614b:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106152:	00 00 00 00 
80106156:	eb 01                	jmp    80106159 <scheduler+0x80>
        continue;
80106158:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80106159:	81 45 f4 b4 00 00 00 	addl   $0xb4,-0xc(%ebp)
80106160:	81 7d f4 14 46 13 80 	cmpl   $0x80134614,-0xc(%ebp)
80106167:	72 94                	jb     801060fd <scheduler+0x24>
    }
    release(&ptable.lock);
80106169:	83 ec 0c             	sub    $0xc,%esp
8010616c:	68 e0 18 13 80       	push   $0x801318e0
80106171:	e8 b3 04 00 00       	call   80106629 <release>
80106176:	83 c4 10             	add    $0x10,%esp
    sti();
80106179:	e9 61 ff ff ff       	jmp    801060df <scheduler+0x6>

8010617e <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
8010617e:	55                   	push   %ebp
8010617f:	89 e5                	mov    %esp,%ebp
80106181:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80106184:	83 ec 0c             	sub    $0xc,%esp
80106187:	68 e0 18 13 80       	push   $0x801318e0
8010618c:	e8 61 05 00 00       	call   801066f2 <holding>
80106191:	83 c4 10             	add    $0x10,%esp
80106194:	85 c0                	test   %eax,%eax
80106196:	75 0d                	jne    801061a5 <sched+0x27>
    panic("sched ptable.lock");
80106198:	83 ec 0c             	sub    $0xc,%esp
8010619b:	68 cb b7 10 80       	push   $0x8010b7cb
801061a0:	e8 99 ac ff ff       	call   80100e3e <panic>
  if(cpu->ncli != 1)
801061a5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801061ab:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801061b1:	83 f8 01             	cmp    $0x1,%eax
801061b4:	74 0d                	je     801061c3 <sched+0x45>
    panic("sched locks");
801061b6:	83 ec 0c             	sub    $0xc,%esp
801061b9:	68 dd b7 10 80       	push   $0x8010b7dd
801061be:	e8 7b ac ff ff       	call   80100e3e <panic>
  if(proc->state == RUNNING)
801061c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061c9:	8b 40 0c             	mov    0xc(%eax),%eax
801061cc:	83 f8 04             	cmp    $0x4,%eax
801061cf:	75 0d                	jne    801061de <sched+0x60>
    panic("sched running");
801061d1:	83 ec 0c             	sub    $0xc,%esp
801061d4:	68 e9 b7 10 80       	push   $0x8010b7e9
801061d9:	e8 60 ac ff ff       	call   80100e3e <panic>
  if(readeflags()&FL_IF)
801061de:	e8 de f7 ff ff       	call   801059c1 <readeflags>
801061e3:	25 00 02 00 00       	and    $0x200,%eax
801061e8:	85 c0                	test   %eax,%eax
801061ea:	74 0d                	je     801061f9 <sched+0x7b>
    panic("sched interruptible");
801061ec:	83 ec 0c             	sub    $0xc,%esp
801061ef:	68 f7 b7 10 80       	push   $0x8010b7f7
801061f4:	e8 45 ac ff ff       	call   80100e3e <panic>
  intena = cpu->intena;
801061f9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801061ff:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80106205:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80106208:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010620e:	8b 40 04             	mov    0x4(%eax),%eax
80106211:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80106218:	83 c2 1c             	add    $0x1c,%edx
8010621b:	83 ec 08             	sub    $0x8,%esp
8010621e:	50                   	push   %eax
8010621f:	52                   	push   %edx
80106220:	e8 53 09 00 00       	call   80106b78 <swtch>
80106225:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80106228:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010622e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106231:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80106237:	90                   	nop
80106238:	c9                   	leave  
80106239:	c3                   	ret    

8010623a <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
8010623a:	55                   	push   %ebp
8010623b:	89 e5                	mov    %esp,%ebp
8010623d:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80106240:	83 ec 0c             	sub    $0xc,%esp
80106243:	68 e0 18 13 80       	push   $0x801318e0
80106248:	e8 70 03 00 00       	call   801065bd <acquire>
8010624d:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80106250:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106256:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
8010625d:	e8 1c ff ff ff       	call   8010617e <sched>
  release(&ptable.lock);
80106262:	83 ec 0c             	sub    $0xc,%esp
80106265:	68 e0 18 13 80       	push   $0x801318e0
8010626a:	e8 ba 03 00 00       	call   80106629 <release>
8010626f:	83 c4 10             	add    $0x10,%esp
}
80106272:	90                   	nop
80106273:	c9                   	leave  
80106274:	c3                   	ret    

80106275 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80106275:	55                   	push   %ebp
80106276:	89 e5                	mov    %esp,%ebp
80106278:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
8010627b:	83 ec 0c             	sub    $0xc,%esp
8010627e:	68 e0 18 13 80       	push   $0x801318e0
80106283:	e8 a1 03 00 00       	call   80106629 <release>
80106288:	83 c4 10             	add    $0x10,%esp

  if (first) {
8010628b:	a1 64 90 12 80       	mov    0x80129064,%eax
80106290:	85 c0                	test   %eax,%eax
80106292:	74 24                	je     801062b8 <forkret+0x43>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80106294:	c7 05 64 90 12 80 00 	movl   $0x0,0x80129064
8010629b:	00 00 00 
    iinit(ROOTDEV);
8010629e:	83 ec 0c             	sub    $0xc,%esp
801062a1:	6a 01                	push   $0x1
801062a3:	e8 4d bf ff ff       	call   801021f5 <iinit>
801062a8:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
801062ab:	83 ec 0c             	sub    $0xc,%esp
801062ae:	6a 01                	push   $0x1
801062b0:	e8 d9 de ff ff       	call   8010418e <initlog>
801062b5:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801062b8:	90                   	nop
801062b9:	c9                   	leave  
801062ba:	c3                   	ret    

801062bb <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
801062bb:	55                   	push   %ebp
801062bc:	89 e5                	mov    %esp,%ebp
801062be:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
801062c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062c7:	85 c0                	test   %eax,%eax
801062c9:	75 0d                	jne    801062d8 <sleep+0x1d>
    panic("sleep");
801062cb:	83 ec 0c             	sub    $0xc,%esp
801062ce:	68 0b b8 10 80       	push   $0x8010b80b
801062d3:	e8 66 ab ff ff       	call   80100e3e <panic>

  if(lk == 0)
801062d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801062dc:	75 0d                	jne    801062eb <sleep+0x30>
    panic("sleep without lk");
801062de:	83 ec 0c             	sub    $0xc,%esp
801062e1:	68 11 b8 10 80       	push   $0x8010b811
801062e6:	e8 53 ab ff ff       	call   80100e3e <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
801062eb:	81 7d 0c e0 18 13 80 	cmpl   $0x801318e0,0xc(%ebp)
801062f2:	74 1e                	je     80106312 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
801062f4:	83 ec 0c             	sub    $0xc,%esp
801062f7:	68 e0 18 13 80       	push   $0x801318e0
801062fc:	e8 bc 02 00 00       	call   801065bd <acquire>
80106301:	83 c4 10             	add    $0x10,%esp
    release(lk);
80106304:	83 ec 0c             	sub    $0xc,%esp
80106307:	ff 75 0c             	pushl  0xc(%ebp)
8010630a:	e8 1a 03 00 00       	call   80106629 <release>
8010630f:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80106312:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106318:	8b 55 08             	mov    0x8(%ebp),%edx
8010631b:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
8010631e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106324:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
8010632b:	e8 4e fe ff ff       	call   8010617e <sched>

  // Tidy up.
  proc->chan = 0;
80106330:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106336:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
8010633d:	81 7d 0c e0 18 13 80 	cmpl   $0x801318e0,0xc(%ebp)
80106344:	74 1e                	je     80106364 <sleep+0xa9>
    release(&ptable.lock);
80106346:	83 ec 0c             	sub    $0xc,%esp
80106349:	68 e0 18 13 80       	push   $0x801318e0
8010634e:	e8 d6 02 00 00       	call   80106629 <release>
80106353:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80106356:	83 ec 0c             	sub    $0xc,%esp
80106359:	ff 75 0c             	pushl  0xc(%ebp)
8010635c:	e8 5c 02 00 00       	call   801065bd <acquire>
80106361:	83 c4 10             	add    $0x10,%esp
  }
}
80106364:	90                   	nop
80106365:	c9                   	leave  
80106366:	c3                   	ret    

80106367 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80106367:	55                   	push   %ebp
80106368:	89 e5                	mov    %esp,%ebp
8010636a:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010636d:	c7 45 fc 14 19 13 80 	movl   $0x80131914,-0x4(%ebp)
80106374:	eb 27                	jmp    8010639d <wakeup1+0x36>
    if(p->state == SLEEPING && p->chan == chan)
80106376:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106379:	8b 40 0c             	mov    0xc(%eax),%eax
8010637c:	83 f8 02             	cmp    $0x2,%eax
8010637f:	75 15                	jne    80106396 <wakeup1+0x2f>
80106381:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106384:	8b 40 20             	mov    0x20(%eax),%eax
80106387:	39 45 08             	cmp    %eax,0x8(%ebp)
8010638a:	75 0a                	jne    80106396 <wakeup1+0x2f>
      p->state = RUNNABLE;
8010638c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010638f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80106396:	81 45 fc b4 00 00 00 	addl   $0xb4,-0x4(%ebp)
8010639d:	81 7d fc 14 46 13 80 	cmpl   $0x80134614,-0x4(%ebp)
801063a4:	72 d0                	jb     80106376 <wakeup1+0xf>
}
801063a6:	90                   	nop
801063a7:	c9                   	leave  
801063a8:	c3                   	ret    

801063a9 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801063a9:	55                   	push   %ebp
801063aa:	89 e5                	mov    %esp,%ebp
801063ac:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
801063af:	83 ec 0c             	sub    $0xc,%esp
801063b2:	68 e0 18 13 80       	push   $0x801318e0
801063b7:	e8 01 02 00 00       	call   801065bd <acquire>
801063bc:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
801063bf:	83 ec 0c             	sub    $0xc,%esp
801063c2:	ff 75 08             	pushl  0x8(%ebp)
801063c5:	e8 9d ff ff ff       	call   80106367 <wakeup1>
801063ca:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
801063cd:	83 ec 0c             	sub    $0xc,%esp
801063d0:	68 e0 18 13 80       	push   $0x801318e0
801063d5:	e8 4f 02 00 00       	call   80106629 <release>
801063da:	83 c4 10             	add    $0x10,%esp
}
801063dd:	90                   	nop
801063de:	c9                   	leave  
801063df:	c3                   	ret    

801063e0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
801063e6:	83 ec 0c             	sub    $0xc,%esp
801063e9:	68 e0 18 13 80       	push   $0x801318e0
801063ee:	e8 ca 01 00 00       	call   801065bd <acquire>
801063f3:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801063f6:	c7 45 f4 14 19 13 80 	movl   $0x80131914,-0xc(%ebp)
801063fd:	eb 48                	jmp    80106447 <kill+0x67>
    if(p->pid == pid){
801063ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106402:	8b 40 10             	mov    0x10(%eax),%eax
80106405:	39 45 08             	cmp    %eax,0x8(%ebp)
80106408:	75 36                	jne    80106440 <kill+0x60>
      p->killed = 1;
8010640a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010640d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80106414:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106417:	8b 40 0c             	mov    0xc(%eax),%eax
8010641a:	83 f8 02             	cmp    $0x2,%eax
8010641d:	75 0a                	jne    80106429 <kill+0x49>
        p->state = RUNNABLE;
8010641f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106422:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80106429:	83 ec 0c             	sub    $0xc,%esp
8010642c:	68 e0 18 13 80       	push   $0x801318e0
80106431:	e8 f3 01 00 00       	call   80106629 <release>
80106436:	83 c4 10             	add    $0x10,%esp
      return 0;
80106439:	b8 00 00 00 00       	mov    $0x0,%eax
8010643e:	eb 25                	jmp    80106465 <kill+0x85>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80106440:	81 45 f4 b4 00 00 00 	addl   $0xb4,-0xc(%ebp)
80106447:	81 7d f4 14 46 13 80 	cmpl   $0x80134614,-0xc(%ebp)
8010644e:	72 af                	jb     801063ff <kill+0x1f>
    }
  }
  release(&ptable.lock);
80106450:	83 ec 0c             	sub    $0xc,%esp
80106453:	68 e0 18 13 80       	push   $0x801318e0
80106458:	e8 cc 01 00 00       	call   80106629 <release>
8010645d:	83 c4 10             	add    $0x10,%esp
  return -1;
80106460:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106465:	c9                   	leave  
80106466:	c3                   	ret    

80106467 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80106467:	55                   	push   %ebp
80106468:	89 e5                	mov    %esp,%ebp
8010646a:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010646d:	c7 45 f0 14 19 13 80 	movl   $0x80131914,-0x10(%ebp)
80106474:	e9 da 00 00 00       	jmp    80106553 <procdump+0xec>
    if(p->state == UNUSED)
80106479:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010647c:	8b 40 0c             	mov    0xc(%eax),%eax
8010647f:	85 c0                	test   %eax,%eax
80106481:	0f 84 c4 00 00 00    	je     8010654b <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80106487:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010648a:	8b 40 0c             	mov    0xc(%eax),%eax
8010648d:	83 f8 05             	cmp    $0x5,%eax
80106490:	77 23                	ja     801064b5 <procdump+0x4e>
80106492:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106495:	8b 40 0c             	mov    0xc(%eax),%eax
80106498:	8b 04 85 68 90 12 80 	mov    -0x7fed6f98(,%eax,4),%eax
8010649f:	85 c0                	test   %eax,%eax
801064a1:	74 12                	je     801064b5 <procdump+0x4e>
      state = states[p->state];
801064a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064a6:	8b 40 0c             	mov    0xc(%eax),%eax
801064a9:	8b 04 85 68 90 12 80 	mov    -0x7fed6f98(,%eax,4),%eax
801064b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
801064b3:	eb 07                	jmp    801064bc <procdump+0x55>
    else
      state = "???";
801064b5:	c7 45 ec 22 b8 10 80 	movl   $0x8010b822,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
801064bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064bf:	8d 50 6c             	lea    0x6c(%eax),%edx
801064c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064c5:	8b 40 10             	mov    0x10(%eax),%eax
801064c8:	52                   	push   %edx
801064c9:	ff 75 ec             	pushl  -0x14(%ebp)
801064cc:	50                   	push   %eax
801064cd:	68 26 b8 10 80       	push   $0x8010b826
801064d2:	e8 41 a9 ff ff       	call   80100e18 <cprintf>
801064d7:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
801064da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064dd:	8b 40 0c             	mov    0xc(%eax),%eax
801064e0:	83 f8 02             	cmp    $0x2,%eax
801064e3:	75 54                	jne    80106539 <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801064e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064e8:	8b 40 1c             	mov    0x1c(%eax),%eax
801064eb:	8b 40 0c             	mov    0xc(%eax),%eax
801064ee:	83 c0 08             	add    $0x8,%eax
801064f1:	89 c2                	mov    %eax,%edx
801064f3:	83 ec 08             	sub    $0x8,%esp
801064f6:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801064f9:	50                   	push   %eax
801064fa:	52                   	push   %edx
801064fb:	e8 78 01 00 00       	call   80106678 <getcallerpcs>
80106500:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80106503:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010650a:	eb 1c                	jmp    80106528 <procdump+0xc1>
        cprintf(" %p", pc[i]);
8010650c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010650f:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80106513:	83 ec 08             	sub    $0x8,%esp
80106516:	50                   	push   %eax
80106517:	68 2f b8 10 80       	push   $0x8010b82f
8010651c:	e8 f7 a8 ff ff       	call   80100e18 <cprintf>
80106521:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80106524:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106528:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010652c:	7f 0b                	jg     80106539 <procdump+0xd2>
8010652e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106531:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80106535:	85 c0                	test   %eax,%eax
80106537:	75 d3                	jne    8010650c <procdump+0xa5>
    }
    cprintf("\n");
80106539:	83 ec 0c             	sub    $0xc,%esp
8010653c:	68 33 b8 10 80       	push   $0x8010b833
80106541:	e8 d2 a8 ff ff       	call   80100e18 <cprintf>
80106546:	83 c4 10             	add    $0x10,%esp
80106549:	eb 01                	jmp    8010654c <procdump+0xe5>
      continue;
8010654b:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010654c:	81 45 f0 b4 00 00 00 	addl   $0xb4,-0x10(%ebp)
80106553:	81 7d f0 14 46 13 80 	cmpl   $0x80134614,-0x10(%ebp)
8010655a:	0f 82 19 ff ff ff    	jb     80106479 <procdump+0x12>
  }
}
80106560:	90                   	nop
80106561:	c9                   	leave  
80106562:	c3                   	ret    

80106563 <readeflags>:
{
80106563:	55                   	push   %ebp
80106564:	89 e5                	mov    %esp,%ebp
80106566:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80106569:	9c                   	pushf  
8010656a:	58                   	pop    %eax
8010656b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010656e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106571:	c9                   	leave  
80106572:	c3                   	ret    

80106573 <cli>:
{
80106573:	55                   	push   %ebp
80106574:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80106576:	fa                   	cli    
}
80106577:	90                   	nop
80106578:	5d                   	pop    %ebp
80106579:	c3                   	ret    

8010657a <sti>:
{
8010657a:	55                   	push   %ebp
8010657b:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
8010657d:	fb                   	sti    
}
8010657e:	90                   	nop
8010657f:	5d                   	pop    %ebp
80106580:	c3                   	ret    

80106581 <xchg>:
{
80106581:	55                   	push   %ebp
80106582:	89 e5                	mov    %esp,%ebp
80106584:	83 ec 10             	sub    $0x10,%esp
  asm volatile("lock; xchgl %0, %1" :
80106587:	8b 55 08             	mov    0x8(%ebp),%edx
8010658a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010658d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106590:	f0 87 02             	lock xchg %eax,(%edx)
80106593:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return result;
80106596:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106599:	c9                   	leave  
8010659a:	c3                   	ret    

8010659b <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
8010659b:	55                   	push   %ebp
8010659c:	89 e5                	mov    %esp,%ebp
  lk->name = name;
8010659e:	8b 45 08             	mov    0x8(%ebp),%eax
801065a1:	8b 55 0c             	mov    0xc(%ebp),%edx
801065a4:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
801065a7:	8b 45 08             	mov    0x8(%ebp),%eax
801065aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
801065b0:	8b 45 08             	mov    0x8(%ebp),%eax
801065b3:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801065ba:	90                   	nop
801065bb:	5d                   	pop    %ebp
801065bc:	c3                   	ret    

801065bd <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801065bd:	55                   	push   %ebp
801065be:	89 e5                	mov    %esp,%ebp
801065c0:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801065c3:	e8 54 01 00 00       	call   8010671c <pushcli>
  if(holding(lk))
801065c8:	8b 45 08             	mov    0x8(%ebp),%eax
801065cb:	83 ec 0c             	sub    $0xc,%esp
801065ce:	50                   	push   %eax
801065cf:	e8 1e 01 00 00       	call   801066f2 <holding>
801065d4:	83 c4 10             	add    $0x10,%esp
801065d7:	85 c0                	test   %eax,%eax
801065d9:	74 0d                	je     801065e8 <acquire+0x2b>
    panic("acquire");
801065db:	83 ec 0c             	sub    $0xc,%esp
801065de:	68 5f b8 10 80       	push   $0x8010b85f
801065e3:	e8 56 a8 ff ff       	call   80100e3e <panic>

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801065e8:	90                   	nop
801065e9:	8b 45 08             	mov    0x8(%ebp),%eax
801065ec:	83 ec 08             	sub    $0x8,%esp
801065ef:	6a 01                	push   $0x1
801065f1:	50                   	push   %eax
801065f2:	e8 8a ff ff ff       	call   80106581 <xchg>
801065f7:	83 c4 10             	add    $0x10,%esp
801065fa:	85 c0                	test   %eax,%eax
801065fc:	75 eb                	jne    801065e9 <acquire+0x2c>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801065fe:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80106603:	8b 45 08             	mov    0x8(%ebp),%eax
80106606:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010660d:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80106610:	8b 45 08             	mov    0x8(%ebp),%eax
80106613:	83 c0 0c             	add    $0xc,%eax
80106616:	83 ec 08             	sub    $0x8,%esp
80106619:	50                   	push   %eax
8010661a:	8d 45 08             	lea    0x8(%ebp),%eax
8010661d:	50                   	push   %eax
8010661e:	e8 55 00 00 00       	call   80106678 <getcallerpcs>
80106623:	83 c4 10             	add    $0x10,%esp
}
80106626:	90                   	nop
80106627:	c9                   	leave  
80106628:	c3                   	ret    

80106629 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80106629:	55                   	push   %ebp
8010662a:	89 e5                	mov    %esp,%ebp
8010662c:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
8010662f:	83 ec 0c             	sub    $0xc,%esp
80106632:	ff 75 08             	pushl  0x8(%ebp)
80106635:	e8 b8 00 00 00       	call   801066f2 <holding>
8010663a:	83 c4 10             	add    $0x10,%esp
8010663d:	85 c0                	test   %eax,%eax
8010663f:	75 0d                	jne    8010664e <release+0x25>
    panic("release");
80106641:	83 ec 0c             	sub    $0xc,%esp
80106644:	68 67 b8 10 80       	push   $0x8010b867
80106649:	e8 f0 a7 ff ff       	call   80100e3e <panic>

  lk->pcs[0] = 0;
8010664e:	8b 45 08             	mov    0x8(%ebp),%eax
80106651:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80106658:	8b 45 08             	mov    0x8(%ebp),%eax
8010665b:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both to not re-order.
  __sync_synchronize();
80106662:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock.
  lk->locked = 0;
80106667:	8b 45 08             	mov    0x8(%ebp),%eax
8010666a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
80106670:	e8 fd 00 00 00       	call   80106772 <popcli>
}
80106675:	90                   	nop
80106676:	c9                   	leave  
80106677:	c3                   	ret    

80106678 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80106678:	55                   	push   %ebp
80106679:	89 e5                	mov    %esp,%ebp
8010667b:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010667e:	8b 45 08             	mov    0x8(%ebp),%eax
80106681:	83 e8 08             	sub    $0x8,%eax
80106684:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80106687:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
8010668e:	eb 38                	jmp    801066c8 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80106690:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80106694:	74 53                	je     801066e9 <getcallerpcs+0x71>
80106696:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
8010669d:	76 4a                	jbe    801066e9 <getcallerpcs+0x71>
8010669f:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
801066a3:	74 44                	je     801066e9 <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
801066a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
801066a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801066af:	8b 45 0c             	mov    0xc(%ebp),%eax
801066b2:	01 c2                	add    %eax,%edx
801066b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801066b7:	8b 40 04             	mov    0x4(%eax),%eax
801066ba:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
801066bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
801066bf:	8b 00                	mov    (%eax),%eax
801066c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801066c4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801066c8:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801066cc:	7e c2                	jle    80106690 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
801066ce:	eb 19                	jmp    801066e9 <getcallerpcs+0x71>
    pcs[i] = 0;
801066d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
801066d3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801066da:	8b 45 0c             	mov    0xc(%ebp),%eax
801066dd:	01 d0                	add    %edx,%eax
801066df:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801066e5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801066e9:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801066ed:	7e e1                	jle    801066d0 <getcallerpcs+0x58>
}
801066ef:	90                   	nop
801066f0:	c9                   	leave  
801066f1:	c3                   	ret    

801066f2 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801066f2:	55                   	push   %ebp
801066f3:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
801066f5:	8b 45 08             	mov    0x8(%ebp),%eax
801066f8:	8b 00                	mov    (%eax),%eax
801066fa:	85 c0                	test   %eax,%eax
801066fc:	74 17                	je     80106715 <holding+0x23>
801066fe:	8b 45 08             	mov    0x8(%ebp),%eax
80106701:	8b 50 08             	mov    0x8(%eax),%edx
80106704:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010670a:	39 c2                	cmp    %eax,%edx
8010670c:	75 07                	jne    80106715 <holding+0x23>
8010670e:	b8 01 00 00 00       	mov    $0x1,%eax
80106713:	eb 05                	jmp    8010671a <holding+0x28>
80106715:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010671a:	5d                   	pop    %ebp
8010671b:	c3                   	ret    

8010671c <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
8010671c:	55                   	push   %ebp
8010671d:	89 e5                	mov    %esp,%ebp
8010671f:	83 ec 10             	sub    $0x10,%esp
  int eflags;

  eflags = readeflags();
80106722:	e8 3c fe ff ff       	call   80106563 <readeflags>
80106727:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
8010672a:	e8 44 fe ff ff       	call   80106573 <cli>
  if(cpu->ncli == 0)
8010672f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106735:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010673b:	85 c0                	test   %eax,%eax
8010673d:	75 15                	jne    80106754 <pushcli+0x38>
    cpu->intena = eflags & FL_IF;
8010673f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106745:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106748:	81 e2 00 02 00 00    	and    $0x200,%edx
8010674e:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  cpu->ncli += 1;
80106754:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010675a:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80106760:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106766:	83 c2 01             	add    $0x1,%edx
80106769:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
}
8010676f:	90                   	nop
80106770:	c9                   	leave  
80106771:	c3                   	ret    

80106772 <popcli>:

void
popcli(void)
{
80106772:	55                   	push   %ebp
80106773:	89 e5                	mov    %esp,%ebp
80106775:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80106778:	e8 e6 fd ff ff       	call   80106563 <readeflags>
8010677d:	25 00 02 00 00       	and    $0x200,%eax
80106782:	85 c0                	test   %eax,%eax
80106784:	74 0d                	je     80106793 <popcli+0x21>
    panic("popcli - interruptible");
80106786:	83 ec 0c             	sub    $0xc,%esp
80106789:	68 6f b8 10 80       	push   $0x8010b86f
8010678e:	e8 ab a6 ff ff       	call   80100e3e <panic>
  if(--cpu->ncli < 0)
80106793:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106799:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010679f:	83 ea 01             	sub    $0x1,%edx
801067a2:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801067a8:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801067ae:	85 c0                	test   %eax,%eax
801067b0:	79 0d                	jns    801067bf <popcli+0x4d>
    panic("popcli");
801067b2:	83 ec 0c             	sub    $0xc,%esp
801067b5:	68 86 b8 10 80       	push   $0x8010b886
801067ba:	e8 7f a6 ff ff       	call   80100e3e <panic>
  if(cpu->ncli == 0 && cpu->intena)
801067bf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067c5:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801067cb:	85 c0                	test   %eax,%eax
801067cd:	75 15                	jne    801067e4 <popcli+0x72>
801067cf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067d5:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801067db:	85 c0                	test   %eax,%eax
801067dd:	74 05                	je     801067e4 <popcli+0x72>
    sti();
801067df:	e8 96 fd ff ff       	call   8010657a <sti>
}
801067e4:	90                   	nop
801067e5:	c9                   	leave  
801067e6:	c3                   	ret    

801067e7 <stosb>:
{
801067e7:	55                   	push   %ebp
801067e8:	89 e5                	mov    %esp,%ebp
801067ea:	57                   	push   %edi
801067eb:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
801067ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
801067ef:	8b 55 10             	mov    0x10(%ebp),%edx
801067f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801067f5:	89 cb                	mov    %ecx,%ebx
801067f7:	89 df                	mov    %ebx,%edi
801067f9:	89 d1                	mov    %edx,%ecx
801067fb:	fc                   	cld    
801067fc:	f3 aa                	rep stos %al,%es:(%edi)
801067fe:	89 ca                	mov    %ecx,%edx
80106800:	89 fb                	mov    %edi,%ebx
80106802:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106805:	89 55 10             	mov    %edx,0x10(%ebp)
}
80106808:	90                   	nop
80106809:	5b                   	pop    %ebx
8010680a:	5f                   	pop    %edi
8010680b:	5d                   	pop    %ebp
8010680c:	c3                   	ret    

8010680d <stosl>:
{
8010680d:	55                   	push   %ebp
8010680e:	89 e5                	mov    %esp,%ebp
80106810:	57                   	push   %edi
80106811:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80106812:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106815:	8b 55 10             	mov    0x10(%ebp),%edx
80106818:	8b 45 0c             	mov    0xc(%ebp),%eax
8010681b:	89 cb                	mov    %ecx,%ebx
8010681d:	89 df                	mov    %ebx,%edi
8010681f:	89 d1                	mov    %edx,%ecx
80106821:	fc                   	cld    
80106822:	f3 ab                	rep stos %eax,%es:(%edi)
80106824:	89 ca                	mov    %ecx,%edx
80106826:	89 fb                	mov    %edi,%ebx
80106828:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010682b:	89 55 10             	mov    %edx,0x10(%ebp)
}
8010682e:	90                   	nop
8010682f:	5b                   	pop    %ebx
80106830:	5f                   	pop    %edi
80106831:	5d                   	pop    %ebp
80106832:	c3                   	ret    

80106833 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80106833:	55                   	push   %ebp
80106834:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
80106836:	8b 45 08             	mov    0x8(%ebp),%eax
80106839:	83 e0 03             	and    $0x3,%eax
8010683c:	85 c0                	test   %eax,%eax
8010683e:	75 43                	jne    80106883 <memset+0x50>
80106840:	8b 45 10             	mov    0x10(%ebp),%eax
80106843:	83 e0 03             	and    $0x3,%eax
80106846:	85 c0                	test   %eax,%eax
80106848:	75 39                	jne    80106883 <memset+0x50>
    c &= 0xFF;
8010684a:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80106851:	8b 45 10             	mov    0x10(%ebp),%eax
80106854:	c1 e8 02             	shr    $0x2,%eax
80106857:	89 c1                	mov    %eax,%ecx
80106859:	8b 45 0c             	mov    0xc(%ebp),%eax
8010685c:	c1 e0 18             	shl    $0x18,%eax
8010685f:	89 c2                	mov    %eax,%edx
80106861:	8b 45 0c             	mov    0xc(%ebp),%eax
80106864:	c1 e0 10             	shl    $0x10,%eax
80106867:	09 c2                	or     %eax,%edx
80106869:	8b 45 0c             	mov    0xc(%ebp),%eax
8010686c:	c1 e0 08             	shl    $0x8,%eax
8010686f:	09 d0                	or     %edx,%eax
80106871:	0b 45 0c             	or     0xc(%ebp),%eax
80106874:	51                   	push   %ecx
80106875:	50                   	push   %eax
80106876:	ff 75 08             	pushl  0x8(%ebp)
80106879:	e8 8f ff ff ff       	call   8010680d <stosl>
8010687e:	83 c4 0c             	add    $0xc,%esp
80106881:	eb 12                	jmp    80106895 <memset+0x62>
  } else
    stosb(dst, c, n);
80106883:	8b 45 10             	mov    0x10(%ebp),%eax
80106886:	50                   	push   %eax
80106887:	ff 75 0c             	pushl  0xc(%ebp)
8010688a:	ff 75 08             	pushl  0x8(%ebp)
8010688d:	e8 55 ff ff ff       	call   801067e7 <stosb>
80106892:	83 c4 0c             	add    $0xc,%esp
  return dst;
80106895:	8b 45 08             	mov    0x8(%ebp),%eax
}
80106898:	c9                   	leave  
80106899:	c3                   	ret    

8010689a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010689a:	55                   	push   %ebp
8010689b:	89 e5                	mov    %esp,%ebp
8010689d:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;

  s1 = v1;
801068a0:	8b 45 08             	mov    0x8(%ebp),%eax
801068a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801068a6:	8b 45 0c             	mov    0xc(%ebp),%eax
801068a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801068ac:	eb 30                	jmp    801068de <memcmp+0x44>
    if(*s1 != *s2)
801068ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
801068b1:	0f b6 10             	movzbl (%eax),%edx
801068b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
801068b7:	0f b6 00             	movzbl (%eax),%eax
801068ba:	38 c2                	cmp    %al,%dl
801068bc:	74 18                	je     801068d6 <memcmp+0x3c>
      return *s1 - *s2;
801068be:	8b 45 fc             	mov    -0x4(%ebp),%eax
801068c1:	0f b6 00             	movzbl (%eax),%eax
801068c4:	0f b6 d0             	movzbl %al,%edx
801068c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
801068ca:	0f b6 00             	movzbl (%eax),%eax
801068cd:	0f b6 c0             	movzbl %al,%eax
801068d0:	29 c2                	sub    %eax,%edx
801068d2:	89 d0                	mov    %edx,%eax
801068d4:	eb 1a                	jmp    801068f0 <memcmp+0x56>
    s1++, s2++;
801068d6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801068da:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
801068de:	8b 45 10             	mov    0x10(%ebp),%eax
801068e1:	8d 50 ff             	lea    -0x1(%eax),%edx
801068e4:	89 55 10             	mov    %edx,0x10(%ebp)
801068e7:	85 c0                	test   %eax,%eax
801068e9:	75 c3                	jne    801068ae <memcmp+0x14>
  }

  return 0;
801068eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
801068f0:	c9                   	leave  
801068f1:	c3                   	ret    

801068f2 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801068f2:	55                   	push   %ebp
801068f3:	89 e5                	mov    %esp,%ebp
801068f5:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
801068f8:	8b 45 0c             	mov    0xc(%ebp),%eax
801068fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
801068fe:	8b 45 08             	mov    0x8(%ebp),%eax
80106901:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80106904:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106907:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010690a:	73 54                	jae    80106960 <memmove+0x6e>
8010690c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010690f:	8b 45 10             	mov    0x10(%ebp),%eax
80106912:	01 d0                	add    %edx,%eax
80106914:	39 45 f8             	cmp    %eax,-0x8(%ebp)
80106917:	73 47                	jae    80106960 <memmove+0x6e>
    s += n;
80106919:	8b 45 10             	mov    0x10(%ebp),%eax
8010691c:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
8010691f:	8b 45 10             	mov    0x10(%ebp),%eax
80106922:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80106925:	eb 13                	jmp    8010693a <memmove+0x48>
      *--d = *--s;
80106927:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
8010692b:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
8010692f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106932:	0f b6 10             	movzbl (%eax),%edx
80106935:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106938:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
8010693a:	8b 45 10             	mov    0x10(%ebp),%eax
8010693d:	8d 50 ff             	lea    -0x1(%eax),%edx
80106940:	89 55 10             	mov    %edx,0x10(%ebp)
80106943:	85 c0                	test   %eax,%eax
80106945:	75 e0                	jne    80106927 <memmove+0x35>
  if(s < d && s + n > d){
80106947:	eb 24                	jmp    8010696d <memmove+0x7b>
  } else
    while(n-- > 0)
      *d++ = *s++;
80106949:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010694c:	8d 42 01             	lea    0x1(%edx),%eax
8010694f:	89 45 fc             	mov    %eax,-0x4(%ebp)
80106952:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106955:	8d 48 01             	lea    0x1(%eax),%ecx
80106958:	89 4d f8             	mov    %ecx,-0x8(%ebp)
8010695b:	0f b6 12             	movzbl (%edx),%edx
8010695e:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80106960:	8b 45 10             	mov    0x10(%ebp),%eax
80106963:	8d 50 ff             	lea    -0x1(%eax),%edx
80106966:	89 55 10             	mov    %edx,0x10(%ebp)
80106969:	85 c0                	test   %eax,%eax
8010696b:	75 dc                	jne    80106949 <memmove+0x57>

  return dst;
8010696d:	8b 45 08             	mov    0x8(%ebp),%eax
}
80106970:	c9                   	leave  
80106971:	c3                   	ret    

80106972 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80106972:	55                   	push   %ebp
80106973:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80106975:	ff 75 10             	pushl  0x10(%ebp)
80106978:	ff 75 0c             	pushl  0xc(%ebp)
8010697b:	ff 75 08             	pushl  0x8(%ebp)
8010697e:	e8 6f ff ff ff       	call   801068f2 <memmove>
80106983:	83 c4 0c             	add    $0xc,%esp
}
80106986:	c9                   	leave  
80106987:	c3                   	ret    

80106988 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80106988:	55                   	push   %ebp
80106989:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010698b:	eb 0c                	jmp    80106999 <strncmp+0x11>
    n--, p++, q++;
8010698d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80106991:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80106995:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
80106999:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010699d:	74 1a                	je     801069b9 <strncmp+0x31>
8010699f:	8b 45 08             	mov    0x8(%ebp),%eax
801069a2:	0f b6 00             	movzbl (%eax),%eax
801069a5:	84 c0                	test   %al,%al
801069a7:	74 10                	je     801069b9 <strncmp+0x31>
801069a9:	8b 45 08             	mov    0x8(%ebp),%eax
801069ac:	0f b6 10             	movzbl (%eax),%edx
801069af:	8b 45 0c             	mov    0xc(%ebp),%eax
801069b2:	0f b6 00             	movzbl (%eax),%eax
801069b5:	38 c2                	cmp    %al,%dl
801069b7:	74 d4                	je     8010698d <strncmp+0x5>
  if(n == 0)
801069b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801069bd:	75 07                	jne    801069c6 <strncmp+0x3e>
    return 0;
801069bf:	b8 00 00 00 00       	mov    $0x0,%eax
801069c4:	eb 16                	jmp    801069dc <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
801069c6:	8b 45 08             	mov    0x8(%ebp),%eax
801069c9:	0f b6 00             	movzbl (%eax),%eax
801069cc:	0f b6 d0             	movzbl %al,%edx
801069cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801069d2:	0f b6 00             	movzbl (%eax),%eax
801069d5:	0f b6 c0             	movzbl %al,%eax
801069d8:	29 c2                	sub    %eax,%edx
801069da:	89 d0                	mov    %edx,%eax
}
801069dc:	5d                   	pop    %ebp
801069dd:	c3                   	ret    

801069de <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801069de:	55                   	push   %ebp
801069df:	89 e5                	mov    %esp,%ebp
801069e1:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
801069e4:	8b 45 08             	mov    0x8(%ebp),%eax
801069e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
801069ea:	90                   	nop
801069eb:	8b 45 10             	mov    0x10(%ebp),%eax
801069ee:	8d 50 ff             	lea    -0x1(%eax),%edx
801069f1:	89 55 10             	mov    %edx,0x10(%ebp)
801069f4:	85 c0                	test   %eax,%eax
801069f6:	7e 2c                	jle    80106a24 <strncpy+0x46>
801069f8:	8b 55 0c             	mov    0xc(%ebp),%edx
801069fb:	8d 42 01             	lea    0x1(%edx),%eax
801069fe:	89 45 0c             	mov    %eax,0xc(%ebp)
80106a01:	8b 45 08             	mov    0x8(%ebp),%eax
80106a04:	8d 48 01             	lea    0x1(%eax),%ecx
80106a07:	89 4d 08             	mov    %ecx,0x8(%ebp)
80106a0a:	0f b6 12             	movzbl (%edx),%edx
80106a0d:	88 10                	mov    %dl,(%eax)
80106a0f:	0f b6 00             	movzbl (%eax),%eax
80106a12:	84 c0                	test   %al,%al
80106a14:	75 d5                	jne    801069eb <strncpy+0xd>
    ;
  while(n-- > 0)
80106a16:	eb 0c                	jmp    80106a24 <strncpy+0x46>
    *s++ = 0;
80106a18:	8b 45 08             	mov    0x8(%ebp),%eax
80106a1b:	8d 50 01             	lea    0x1(%eax),%edx
80106a1e:	89 55 08             	mov    %edx,0x8(%ebp)
80106a21:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
80106a24:	8b 45 10             	mov    0x10(%ebp),%eax
80106a27:	8d 50 ff             	lea    -0x1(%eax),%edx
80106a2a:	89 55 10             	mov    %edx,0x10(%ebp)
80106a2d:	85 c0                	test   %eax,%eax
80106a2f:	7f e7                	jg     80106a18 <strncpy+0x3a>
  return os;
80106a31:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106a34:	c9                   	leave  
80106a35:	c3                   	ret    

80106a36 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
80106a36:	55                   	push   %ebp
80106a37:	89 e5                	mov    %esp,%ebp
80106a39:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
80106a3c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80106a43:	eb 0c                	jmp    80106a51 <strnlen+0x1b>
     n++; 
80106a45:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
80106a49:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80106a4d:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
80106a51:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80106a55:	74 0a                	je     80106a61 <strnlen+0x2b>
80106a57:	8b 45 08             	mov    0x8(%ebp),%eax
80106a5a:	0f b6 00             	movzbl (%eax),%eax
80106a5d:	84 c0                	test   %al,%al
80106a5f:	75 e4                	jne    80106a45 <strnlen+0xf>
   return n; 
80106a61:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
80106a64:	c9                   	leave  
80106a65:	c3                   	ret    

80106a66 <safestrcpy>:


// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80106a66:	55                   	push   %ebp
80106a67:	89 e5                	mov    %esp,%ebp
80106a69:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80106a6c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a6f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80106a72:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80106a76:	7f 05                	jg     80106a7d <safestrcpy+0x17>
    return os;
80106a78:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106a7b:	eb 31                	jmp    80106aae <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
80106a7d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80106a81:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80106a85:	7e 1e                	jle    80106aa5 <safestrcpy+0x3f>
80106a87:	8b 55 0c             	mov    0xc(%ebp),%edx
80106a8a:	8d 42 01             	lea    0x1(%edx),%eax
80106a8d:	89 45 0c             	mov    %eax,0xc(%ebp)
80106a90:	8b 45 08             	mov    0x8(%ebp),%eax
80106a93:	8d 48 01             	lea    0x1(%eax),%ecx
80106a96:	89 4d 08             	mov    %ecx,0x8(%ebp)
80106a99:	0f b6 12             	movzbl (%edx),%edx
80106a9c:	88 10                	mov    %dl,(%eax)
80106a9e:	0f b6 00             	movzbl (%eax),%eax
80106aa1:	84 c0                	test   %al,%al
80106aa3:	75 d8                	jne    80106a7d <safestrcpy+0x17>
    ;
  *s = 0;
80106aa5:	8b 45 08             	mov    0x8(%ebp),%eax
80106aa8:	c6 00 00             	movb   $0x0,(%eax)
  return os;
80106aab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106aae:	c9                   	leave  
80106aaf:	c3                   	ret    

80106ab0 <strlen>:

int
strlen(const char *s)
{
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80106ab6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80106abd:	eb 04                	jmp    80106ac3 <strlen+0x13>
80106abf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80106ac3:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106ac6:	8b 45 08             	mov    0x8(%ebp),%eax
80106ac9:	01 d0                	add    %edx,%eax
80106acb:	0f b6 00             	movzbl (%eax),%eax
80106ace:	84 c0                	test   %al,%al
80106ad0:	75 ed                	jne    80106abf <strlen+0xf>
    ;
  return n;
80106ad2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106ad5:	c9                   	leave  
80106ad6:	c3                   	ret    

80106ad7 <strcmp>:


int
strcmp(const char *p, const char *q)
{
80106ad7:	55                   	push   %ebp
80106ad8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
80106ada:	eb 08                	jmp    80106ae4 <strcmp+0xd>
    p++, q++;
80106adc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80106ae0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
80106ae4:	8b 45 08             	mov    0x8(%ebp),%eax
80106ae7:	0f b6 00             	movzbl (%eax),%eax
80106aea:	84 c0                	test   %al,%al
80106aec:	74 10                	je     80106afe <strcmp+0x27>
80106aee:	8b 45 08             	mov    0x8(%ebp),%eax
80106af1:	0f b6 10             	movzbl (%eax),%edx
80106af4:	8b 45 0c             	mov    0xc(%ebp),%eax
80106af7:	0f b6 00             	movzbl (%eax),%eax
80106afa:	38 c2                	cmp    %al,%dl
80106afc:	74 de                	je     80106adc <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
80106afe:	8b 45 08             	mov    0x8(%ebp),%eax
80106b01:	0f b6 00             	movzbl (%eax),%eax
80106b04:	0f b6 d0             	movzbl %al,%edx
80106b07:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b0a:	0f b6 00             	movzbl (%eax),%eax
80106b0d:	0f b6 c0             	movzbl %al,%eax
80106b10:	29 c2                	sub    %eax,%edx
80106b12:	89 d0                	mov    %edx,%eax
}
80106b14:	5d                   	pop    %ebp
80106b15:	c3                   	ret    

80106b16 <strchr>:

char*
strchr(const char *s, char c)
{
80106b16:	55                   	push   %ebp
80106b17:	89 e5                	mov    %esp,%ebp
80106b19:	83 ec 04             	sub    $0x4,%esp
80106b1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b1f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
80106b22:	eb 14                	jmp    80106b38 <strchr+0x22>
    if(*s == c)
80106b24:	8b 45 08             	mov    0x8(%ebp),%eax
80106b27:	0f b6 00             	movzbl (%eax),%eax
80106b2a:	38 45 fc             	cmp    %al,-0x4(%ebp)
80106b2d:	75 05                	jne    80106b34 <strchr+0x1e>
      return (char*)s;
80106b2f:	8b 45 08             	mov    0x8(%ebp),%eax
80106b32:	eb 13                	jmp    80106b47 <strchr+0x31>
  for(; *s; s++)
80106b34:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80106b38:	8b 45 08             	mov    0x8(%ebp),%eax
80106b3b:	0f b6 00             	movzbl (%eax),%eax
80106b3e:	84 c0                	test   %al,%al
80106b40:	75 e2                	jne    80106b24 <strchr+0xe>
  return 0;
80106b42:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106b47:	c9                   	leave  
80106b48:	c3                   	ret    

80106b49 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
 // or a pointer to the string-ending null character if the string has no 'c'.
 char *
 strfind(const char *s, char c)
 {
80106b49:	55                   	push   %ebp
80106b4a:	89 e5                	mov    %esp,%ebp
80106b4c:	83 ec 04             	sub    $0x4,%esp
80106b4f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b52:	88 45 fc             	mov    %al,-0x4(%ebp)
   for (; *s; s++)
80106b55:	eb 0f                	jmp    80106b66 <strfind+0x1d>
     if (*s == c)
80106b57:	8b 45 08             	mov    0x8(%ebp),%eax
80106b5a:	0f b6 00             	movzbl (%eax),%eax
80106b5d:	38 45 fc             	cmp    %al,-0x4(%ebp)
80106b60:	74 10                	je     80106b72 <strfind+0x29>
   for (; *s; s++)
80106b62:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80106b66:	8b 45 08             	mov    0x8(%ebp),%eax
80106b69:	0f b6 00             	movzbl (%eax),%eax
80106b6c:	84 c0                	test   %al,%al
80106b6e:	75 e7                	jne    80106b57 <strfind+0xe>
80106b70:	eb 01                	jmp    80106b73 <strfind+0x2a>
       break;
80106b72:	90                   	nop
   return (char*)s;
80106b73:	8b 45 08             	mov    0x8(%ebp),%eax
 }
80106b76:	c9                   	leave  
80106b77:	c3                   	ret    

80106b78 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80106b78:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80106b7c:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80106b80:	55                   	push   %ebp
  pushl %ebx
80106b81:	53                   	push   %ebx
  pushl %esi
80106b82:	56                   	push   %esi
  pushl %edi
80106b83:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80106b84:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80106b86:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80106b88:	5f                   	pop    %edi
  popl %esi
80106b89:	5e                   	pop    %esi
  popl %ebx
80106b8a:	5b                   	pop    %ebx
  popl %ebp
80106b8b:	5d                   	pop    %ebp
  ret
80106b8c:	c3                   	ret    

80106b8d <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80106b8d:	55                   	push   %ebp
80106b8e:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80106b90:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b96:	8b 00                	mov    (%eax),%eax
80106b98:	39 45 08             	cmp    %eax,0x8(%ebp)
80106b9b:	73 12                	jae    80106baf <fetchint+0x22>
80106b9d:	8b 45 08             	mov    0x8(%ebp),%eax
80106ba0:	8d 50 04             	lea    0x4(%eax),%edx
80106ba3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ba9:	8b 00                	mov    (%eax),%eax
80106bab:	39 c2                	cmp    %eax,%edx
80106bad:	76 07                	jbe    80106bb6 <fetchint+0x29>
    return -1;
80106baf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106bb4:	eb 0f                	jmp    80106bc5 <fetchint+0x38>
  *ip = *(int*)(addr);
80106bb6:	8b 45 08             	mov    0x8(%ebp),%eax
80106bb9:	8b 10                	mov    (%eax),%edx
80106bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bbe:	89 10                	mov    %edx,(%eax)
  return 0;
80106bc0:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106bc5:	5d                   	pop    %ebp
80106bc6:	c3                   	ret    

80106bc7 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80106bc7:	55                   	push   %ebp
80106bc8:	89 e5                	mov    %esp,%ebp
80106bca:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80106bcd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bd3:	8b 00                	mov    (%eax),%eax
80106bd5:	39 45 08             	cmp    %eax,0x8(%ebp)
80106bd8:	72 07                	jb     80106be1 <fetchstr+0x1a>
    return -1;
80106bda:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106bdf:	eb 46                	jmp    80106c27 <fetchstr+0x60>
  *pp = (char*)addr;
80106be1:	8b 55 08             	mov    0x8(%ebp),%edx
80106be4:	8b 45 0c             	mov    0xc(%ebp),%eax
80106be7:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80106be9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106bef:	8b 00                	mov    (%eax),%eax
80106bf1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80106bf4:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bf7:	8b 00                	mov    (%eax),%eax
80106bf9:	89 45 fc             	mov    %eax,-0x4(%ebp)
80106bfc:	eb 1c                	jmp    80106c1a <fetchstr+0x53>
    if(*s == 0)
80106bfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106c01:	0f b6 00             	movzbl (%eax),%eax
80106c04:	84 c0                	test   %al,%al
80106c06:	75 0e                	jne    80106c16 <fetchstr+0x4f>
      return s - *pp;
80106c08:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c0e:	8b 00                	mov    (%eax),%eax
80106c10:	29 c2                	sub    %eax,%edx
80106c12:	89 d0                	mov    %edx,%eax
80106c14:	eb 11                	jmp    80106c27 <fetchstr+0x60>
  for(s = *pp; s < ep; s++)
80106c16:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80106c1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106c1d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80106c20:	72 dc                	jb     80106bfe <fetchstr+0x37>
  return -1;
80106c22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c27:	c9                   	leave  
80106c28:	c3                   	ret    

80106c29 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80106c29:	55                   	push   %ebp
80106c2a:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80106c2c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c32:	8b 40 18             	mov    0x18(%eax),%eax
80106c35:	8b 40 44             	mov    0x44(%eax),%eax
80106c38:	8b 55 08             	mov    0x8(%ebp),%edx
80106c3b:	c1 e2 02             	shl    $0x2,%edx
80106c3e:	01 d0                	add    %edx,%eax
80106c40:	83 c0 04             	add    $0x4,%eax
80106c43:	ff 75 0c             	pushl  0xc(%ebp)
80106c46:	50                   	push   %eax
80106c47:	e8 41 ff ff ff       	call   80106b8d <fetchint>
80106c4c:	83 c4 08             	add    $0x8,%esp
}
80106c4f:	c9                   	leave  
80106c50:	c3                   	ret    

80106c51 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80106c51:	55                   	push   %ebp
80106c52:	89 e5                	mov    %esp,%ebp
80106c54:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(argint(n, &i) < 0)
80106c57:	8d 45 fc             	lea    -0x4(%ebp),%eax
80106c5a:	50                   	push   %eax
80106c5b:	ff 75 08             	pushl  0x8(%ebp)
80106c5e:	e8 c6 ff ff ff       	call   80106c29 <argint>
80106c63:	83 c4 08             	add    $0x8,%esp
80106c66:	85 c0                	test   %eax,%eax
80106c68:	79 07                	jns    80106c71 <argptr+0x20>
    return -1;
80106c6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c6f:	eb 3b                	jmp    80106cac <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80106c71:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c77:	8b 00                	mov    (%eax),%eax
80106c79:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106c7c:	39 d0                	cmp    %edx,%eax
80106c7e:	76 16                	jbe    80106c96 <argptr+0x45>
80106c80:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106c83:	89 c2                	mov    %eax,%edx
80106c85:	8b 45 10             	mov    0x10(%ebp),%eax
80106c88:	01 c2                	add    %eax,%edx
80106c8a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c90:	8b 00                	mov    (%eax),%eax
80106c92:	39 c2                	cmp    %eax,%edx
80106c94:	76 07                	jbe    80106c9d <argptr+0x4c>
    return -1;
80106c96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c9b:	eb 0f                	jmp    80106cac <argptr+0x5b>
  *pp = (char*)i;
80106c9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106ca0:	89 c2                	mov    %eax,%edx
80106ca2:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ca5:	89 10                	mov    %edx,(%eax)
  return 0;
80106ca7:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106cac:	c9                   	leave  
80106cad:	c3                   	ret    

80106cae <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80106cae:	55                   	push   %ebp
80106caf:	89 e5                	mov    %esp,%ebp
80106cb1:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80106cb4:	8d 45 fc             	lea    -0x4(%ebp),%eax
80106cb7:	50                   	push   %eax
80106cb8:	ff 75 08             	pushl  0x8(%ebp)
80106cbb:	e8 69 ff ff ff       	call   80106c29 <argint>
80106cc0:	83 c4 08             	add    $0x8,%esp
80106cc3:	85 c0                	test   %eax,%eax
80106cc5:	79 07                	jns    80106cce <argstr+0x20>
    return -1;
80106cc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ccc:	eb 0f                	jmp    80106cdd <argstr+0x2f>
  return fetchstr(addr, pp);
80106cce:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106cd1:	ff 75 0c             	pushl  0xc(%ebp)
80106cd4:	50                   	push   %eax
80106cd5:	e8 ed fe ff ff       	call   80106bc7 <fetchstr>
80106cda:	83 c4 08             	add    $0x8,%esp
}
80106cdd:	c9                   	leave  
80106cde:	c3                   	ret    

80106cdf <syscall>:
[SYS_arp_receive] sys_arp_receive
};

void
syscall(void)
{
80106cdf:	55                   	push   %ebp
80106ce0:	89 e5                	mov    %esp,%ebp
80106ce2:	83 ec 18             	sub    $0x18,%esp
  int num;

  num = proc->tf->eax;
80106ce5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ceb:	8b 40 18             	mov    0x18(%eax),%eax
80106cee:	8b 40 1c             	mov    0x1c(%eax),%eax
80106cf1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80106cf4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106cf8:	7e 32                	jle    80106d2c <syscall+0x4d>
80106cfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cfd:	83 f8 19             	cmp    $0x19,%eax
80106d00:	77 2a                	ja     80106d2c <syscall+0x4d>
80106d02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d05:	8b 04 85 80 90 12 80 	mov    -0x7fed6f80(,%eax,4),%eax
80106d0c:	85 c0                	test   %eax,%eax
80106d0e:	74 1c                	je     80106d2c <syscall+0x4d>
    proc->tf->eax = syscalls[num]();
80106d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d13:	8b 04 85 80 90 12 80 	mov    -0x7fed6f80(,%eax,4),%eax
80106d1a:	ff d0                	call   *%eax
80106d1c:	89 c2                	mov    %eax,%edx
80106d1e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d24:	8b 40 18             	mov    0x18(%eax),%eax
80106d27:	89 50 1c             	mov    %edx,0x1c(%eax)
80106d2a:	eb 34                	jmp    80106d60 <syscall+0x81>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80106d2c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d32:	8d 50 6c             	lea    0x6c(%eax),%edx
80106d35:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("%d %s: unknown sys call %d\n",
80106d3b:	8b 40 10             	mov    0x10(%eax),%eax
80106d3e:	ff 75 f4             	pushl  -0xc(%ebp)
80106d41:	52                   	push   %edx
80106d42:	50                   	push   %eax
80106d43:	68 8d b8 10 80       	push   $0x8010b88d
80106d48:	e8 cb a0 ff ff       	call   80100e18 <cprintf>
80106d4d:	83 c4 10             	add    $0x10,%esp
    proc->tf->eax = -1;
80106d50:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d56:	8b 40 18             	mov    0x18(%eax),%eax
80106d59:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80106d60:	90                   	nop
80106d61:	c9                   	leave  
80106d62:	c3                   	ret    

80106d63 <sys_arp>:

#include "types.h"
#include "defs.h"
#include "e1000.h"

int sys_arp(void) {
80106d63:	55                   	push   %ebp
80106d64:	89 e5                	mov    %esp,%ebp
80106d66:	83 ec 18             	sub    $0x18,%esp
  char *ipAddr, *interface, *arpResp;
  int size;

  if(argstr(0, &interface) < 0 || argstr(1, &ipAddr) < 0 || argint(3, &size) < 0 || argptr(2, &arpResp, size) < 0) {
80106d69:	83 ec 08             	sub    $0x8,%esp
80106d6c:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106d6f:	50                   	push   %eax
80106d70:	6a 00                	push   $0x0
80106d72:	e8 37 ff ff ff       	call   80106cae <argstr>
80106d77:	83 c4 10             	add    $0x10,%esp
80106d7a:	85 c0                	test   %eax,%eax
80106d7c:	78 43                	js     80106dc1 <sys_arp+0x5e>
80106d7e:	83 ec 08             	sub    $0x8,%esp
80106d81:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d84:	50                   	push   %eax
80106d85:	6a 01                	push   $0x1
80106d87:	e8 22 ff ff ff       	call   80106cae <argstr>
80106d8c:	83 c4 10             	add    $0x10,%esp
80106d8f:	85 c0                	test   %eax,%eax
80106d91:	78 2e                	js     80106dc1 <sys_arp+0x5e>
80106d93:	83 ec 08             	sub    $0x8,%esp
80106d96:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106d99:	50                   	push   %eax
80106d9a:	6a 03                	push   $0x3
80106d9c:	e8 88 fe ff ff       	call   80106c29 <argint>
80106da1:	83 c4 10             	add    $0x10,%esp
80106da4:	85 c0                	test   %eax,%eax
80106da6:	78 19                	js     80106dc1 <sys_arp+0x5e>
80106da8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106dab:	83 ec 04             	sub    $0x4,%esp
80106dae:	50                   	push   %eax
80106daf:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106db2:	50                   	push   %eax
80106db3:	6a 02                	push   $0x2
80106db5:	e8 97 fe ff ff       	call   80106c51 <argptr>
80106dba:	83 c4 10             	add    $0x10,%esp
80106dbd:	85 c0                	test   %eax,%eax
80106dbf:	79 17                	jns    80106dd8 <sys_arp+0x75>
    cprintf("ERROR:sys_createARP:Failed to fetch arguments");
80106dc1:	83 ec 0c             	sub    $0xc,%esp
80106dc4:	68 ac b8 10 80       	push   $0x8010b8ac
80106dc9:	e8 4a a0 ff ff       	call   80100e18 <cprintf>
80106dce:	83 c4 10             	add    $0x10,%esp
    return -1;
80106dd1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106dd6:	eb 3b                	jmp    80106e13 <sys_arp+0xb0>
  }

  if(send_arpRequest(interface, ipAddr, arpResp) < 0) {
80106dd8:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80106ddb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106dde:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106de1:	83 ec 04             	sub    $0x4,%esp
80106de4:	51                   	push   %ecx
80106de5:	52                   	push   %edx
80106de6:	50                   	push   %eax
80106de7:	e8 ed 9a ff ff       	call   801008d9 <send_arpRequest>
80106dec:	83 c4 10             	add    $0x10,%esp
80106def:	85 c0                	test   %eax,%eax
80106df1:	79 1b                	jns    80106e0e <sys_arp+0xab>
    cprintf("ERROR:sys_createARP:Failed to send ARP Request for IP:%s", ipAddr);
80106df3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106df6:	83 ec 08             	sub    $0x8,%esp
80106df9:	50                   	push   %eax
80106dfa:	68 dc b8 10 80       	push   $0x8010b8dc
80106dff:	e8 14 a0 ff ff       	call   80100e18 <cprintf>
80106e04:	83 c4 10             	add    $0x10,%esp
    return -1;
80106e07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e0c:	eb 05                	jmp    80106e13 <sys_arp+0xb0>
  }

  return 0;
80106e0e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106e13:	c9                   	leave  
80106e14:	c3                   	ret    

80106e15 <sys_arpserv>:

int sys_arpserv(void) {
80106e15:	55                   	push   %ebp
80106e16:	89 e5                	mov    %esp,%ebp
80106e18:	83 ec 18             	sub    $0x18,%esp
  char *interface;

  if(argstr(0, &interface) < 0) {
80106e1b:	83 ec 08             	sub    $0x8,%esp
80106e1e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106e21:	50                   	push   %eax
80106e22:	6a 00                	push   $0x0
80106e24:	e8 85 fe ff ff       	call   80106cae <argstr>
80106e29:	83 c4 10             	add    $0x10,%esp
80106e2c:	85 c0                	test   %eax,%eax
80106e2e:	79 17                	jns    80106e47 <sys_arpserv+0x32>
    cprintf("ERROR:sys_arpserv:Failed to fetch arguments");
80106e30:	83 ec 0c             	sub    $0xc,%esp
80106e33:	68 18 b9 10 80       	push   $0x8010b918
80106e38:	e8 db 9f ff ff       	call   80100e18 <cprintf>
80106e3d:	83 c4 10             	add    $0x10,%esp
    return -1;
80106e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106e45:	eb 0f                	jmp    80106e56 <sys_arpserv+0x41>
  }

  return recv_arpRequest(interface);
80106e47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e4a:	83 ec 0c             	sub    $0xc,%esp
80106e4d:	50                   	push   %eax
80106e4e:	e8 08 9b ff ff       	call   8010095b <recv_arpRequest>
80106e53:	83 c4 10             	add    $0x10,%esp
}
80106e56:	c9                   	leave  
80106e57:	c3                   	ret    

80106e58 <sys_arp_receive>:

int sys_arp_receive(void) {
80106e58:	55                   	push   %ebp
80106e59:	89 e5                	mov    %esp,%ebp
80106e5b:	83 ec 18             	sub    $0x18,%esp
  char *buff;
  int size;

  if(argint(1, &size) < 0 || argptr(0, &buff, size) < 0) {
80106e5e:	83 ec 08             	sub    $0x8,%esp
80106e61:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106e64:	50                   	push   %eax
80106e65:	6a 01                	push   $0x1
80106e67:	e8 bd fd ff ff       	call   80106c29 <argint>
80106e6c:	83 c4 10             	add    $0x10,%esp
80106e6f:	85 c0                	test   %eax,%eax
80106e71:	78 19                	js     80106e8c <sys_arp_receive+0x34>
80106e73:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106e76:	83 ec 04             	sub    $0x4,%esp
80106e79:	50                   	push   %eax
80106e7a:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106e7d:	50                   	push   %eax
80106e7e:	6a 00                	push   $0x0
80106e80:	e8 cc fd ff ff       	call   80106c51 <argptr>
80106e85:	83 c4 10             	add    $0x10,%esp
80106e88:	85 c0                	test   %eax,%eax
80106e8a:	79 17                	jns    80106ea3 <sys_arp_receive+0x4b>
    cprintf("ERROR: Failed to fetch arguments from arp_receive\n");
80106e8c:	83 ec 0c             	sub    $0xc,%esp
80106e8f:	68 44 b9 10 80       	push   $0x8010b944
80106e94:	e8 7f 9f ff ff       	call   80100e18 <cprintf>
80106e99:	83 c4 10             	add    $0x10,%esp
    return -1;
80106e9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ea1:	eb 38                	jmp    80106edb <sys_arp_receive+0x83>
  }

  int return_size = e1000_receive(buff, size);
80106ea3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106ea6:	89 c2                	mov    %eax,%edx
80106ea8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106eab:	83 ec 08             	sub    $0x8,%esp
80106eae:	52                   	push   %edx
80106eaf:	50                   	push   %eax
80106eb0:	e8 ec a6 ff ff       	call   801015a1 <e1000_receive>
80106eb5:	83 c4 10             	add    $0x10,%esp
80106eb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(return_size == 0) {
80106ebb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106ebf:	75 17                	jne    80106ed8 <sys_arp_receive+0x80>
    cprintf("Error: e1000 receive failed\n");
80106ec1:	83 ec 0c             	sub    $0xc,%esp
80106ec4:	68 77 b9 10 80       	push   $0x8010b977
80106ec9:	e8 4a 9f ff ff       	call   80100e18 <cprintf>
80106ece:	83 c4 10             	add    $0x10,%esp
    return -1;
80106ed1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ed6:	eb 03                	jmp    80106edb <sys_arp_receive+0x83>
  }

  return return_size;
80106ed8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106edb:	c9                   	leave  
80106edc:	c3                   	ret    

80106edd <_fd_zero>:
{
    *set &= ~(1 << fd);
}

static inline void _fd_zero(fd_set* set)
{
80106edd:	55                   	push   %ebp
80106ede:	89 e5                	mov    %esp,%ebp
    *set = 0;
80106ee0:	8b 45 08             	mov    0x8(%ebp),%eax
80106ee3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
80106ee9:	90                   	nop
80106eea:	5d                   	pop    %ebp
80106eeb:	c3                   	ret    

80106eec <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80106eec:	55                   	push   %ebp
80106eed:	89 e5                	mov    %esp,%ebp
80106eef:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80106ef2:	83 ec 08             	sub    $0x8,%esp
80106ef5:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106ef8:	50                   	push   %eax
80106ef9:	ff 75 08             	pushl  0x8(%ebp)
80106efc:	e8 28 fd ff ff       	call   80106c29 <argint>
80106f01:	83 c4 10             	add    $0x10,%esp
80106f04:	85 c0                	test   %eax,%eax
80106f06:	79 07                	jns    80106f0f <argfd+0x23>
    return -1;
80106f08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f0d:	eb 50                	jmp    80106f5f <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80106f0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106f12:	85 c0                	test   %eax,%eax
80106f14:	78 21                	js     80106f37 <argfd+0x4b>
80106f16:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106f19:	83 f8 0f             	cmp    $0xf,%eax
80106f1c:	7f 19                	jg     80106f37 <argfd+0x4b>
80106f1e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106f24:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106f27:	83 c2 08             	add    $0x8,%edx
80106f2a:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80106f2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106f31:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106f35:	75 07                	jne    80106f3e <argfd+0x52>
    return -1;
80106f37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f3c:	eb 21                	jmp    80106f5f <argfd+0x73>
  if(pfd)
80106f3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80106f42:	74 08                	je     80106f4c <argfd+0x60>
    *pfd = fd;
80106f44:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106f47:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f4a:	89 10                	mov    %edx,(%eax)
  if(pf)
80106f4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80106f50:	74 08                	je     80106f5a <argfd+0x6e>
    *pf = f;
80106f52:	8b 45 10             	mov    0x10(%ebp),%eax
80106f55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106f58:	89 10                	mov    %edx,(%eax)
  return 0;
80106f5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106f5f:	c9                   	leave  
80106f60:	c3                   	ret    

80106f61 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80106f61:	55                   	push   %ebp
80106f62:	89 e5                	mov    %esp,%ebp
80106f64:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80106f67:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80106f6e:	eb 30                	jmp    80106fa0 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80106f70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106f76:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106f79:	83 c2 08             	add    $0x8,%edx
80106f7c:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80106f80:	85 c0                	test   %eax,%eax
80106f82:	75 18                	jne    80106f9c <fdalloc+0x3b>
      proc->ofile[fd] = f;
80106f84:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106f8a:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106f8d:	8d 4a 08             	lea    0x8(%edx),%ecx
80106f90:	8b 55 08             	mov    0x8(%ebp),%edx
80106f93:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80106f97:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106f9a:	eb 0f                	jmp    80106fab <fdalloc+0x4a>
  for(fd = 0; fd < NOFILE; fd++){
80106f9c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80106fa0:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80106fa4:	7e ca                	jle    80106f70 <fdalloc+0xf>
    }
  }
  return -1;
80106fa6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fab:	c9                   	leave  
80106fac:	c3                   	ret    

80106fad <sys_dup>:

int
sys_dup(void)
{
80106fad:	55                   	push   %ebp
80106fae:	89 e5                	mov    %esp,%ebp
80106fb0:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80106fb3:	83 ec 04             	sub    $0x4,%esp
80106fb6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106fb9:	50                   	push   %eax
80106fba:	6a 00                	push   $0x0
80106fbc:	6a 00                	push   $0x0
80106fbe:	e8 29 ff ff ff       	call   80106eec <argfd>
80106fc3:	83 c4 10             	add    $0x10,%esp
80106fc6:	85 c0                	test   %eax,%eax
80106fc8:	79 07                	jns    80106fd1 <sys_dup+0x24>
    return -1;
80106fca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fcf:	eb 31                	jmp    80107002 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80106fd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106fd4:	83 ec 0c             	sub    $0xc,%esp
80106fd7:	50                   	push   %eax
80106fd8:	e8 84 ff ff ff       	call   80106f61 <fdalloc>
80106fdd:	83 c4 10             	add    $0x10,%esp
80106fe0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106fe3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106fe7:	79 07                	jns    80106ff0 <sys_dup+0x43>
    return -1;
80106fe9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fee:	eb 12                	jmp    80107002 <sys_dup+0x55>
  filedup(f);
80106ff0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ff3:	83 ec 0c             	sub    $0xc,%esp
80106ff6:	50                   	push   %eax
80106ff7:	e8 77 aa ff ff       	call   80101a73 <filedup>
80106ffc:	83 c4 10             	add    $0x10,%esp
  return fd;
80106fff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80107002:	c9                   	leave  
80107003:	c3                   	ret    

80107004 <sys_read>:

int
sys_read(void)
{
80107004:	55                   	push   %ebp
80107005:	89 e5                	mov    %esp,%ebp
80107007:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010700a:	83 ec 04             	sub    $0x4,%esp
8010700d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107010:	50                   	push   %eax
80107011:	6a 00                	push   $0x0
80107013:	6a 00                	push   $0x0
80107015:	e8 d2 fe ff ff       	call   80106eec <argfd>
8010701a:	83 c4 10             	add    $0x10,%esp
8010701d:	85 c0                	test   %eax,%eax
8010701f:	78 2e                	js     8010704f <sys_read+0x4b>
80107021:	83 ec 08             	sub    $0x8,%esp
80107024:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107027:	50                   	push   %eax
80107028:	6a 02                	push   $0x2
8010702a:	e8 fa fb ff ff       	call   80106c29 <argint>
8010702f:	83 c4 10             	add    $0x10,%esp
80107032:	85 c0                	test   %eax,%eax
80107034:	78 19                	js     8010704f <sys_read+0x4b>
80107036:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107039:	83 ec 04             	sub    $0x4,%esp
8010703c:	50                   	push   %eax
8010703d:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107040:	50                   	push   %eax
80107041:	6a 01                	push   $0x1
80107043:	e8 09 fc ff ff       	call   80106c51 <argptr>
80107048:	83 c4 10             	add    $0x10,%esp
8010704b:	85 c0                	test   %eax,%eax
8010704d:	79 07                	jns    80107056 <sys_read+0x52>
    return -1;
8010704f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107054:	eb 17                	jmp    8010706d <sys_read+0x69>
  return fileread(f, p, n);
80107056:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80107059:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010705c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010705f:	83 ec 04             	sub    $0x4,%esp
80107062:	51                   	push   %ecx
80107063:	52                   	push   %edx
80107064:	50                   	push   %eax
80107065:	e8 99 ab ff ff       	call   80101c03 <fileread>
8010706a:	83 c4 10             	add    $0x10,%esp
}
8010706d:	c9                   	leave  
8010706e:	c3                   	ret    

8010706f <sys_write>:

int
sys_write(void)
{
8010706f:	55                   	push   %ebp
80107070:	89 e5                	mov    %esp,%ebp
80107072:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80107075:	83 ec 04             	sub    $0x4,%esp
80107078:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010707b:	50                   	push   %eax
8010707c:	6a 00                	push   $0x0
8010707e:	6a 00                	push   $0x0
80107080:	e8 67 fe ff ff       	call   80106eec <argfd>
80107085:	83 c4 10             	add    $0x10,%esp
80107088:	85 c0                	test   %eax,%eax
8010708a:	78 2e                	js     801070ba <sys_write+0x4b>
8010708c:	83 ec 08             	sub    $0x8,%esp
8010708f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107092:	50                   	push   %eax
80107093:	6a 02                	push   $0x2
80107095:	e8 8f fb ff ff       	call   80106c29 <argint>
8010709a:	83 c4 10             	add    $0x10,%esp
8010709d:	85 c0                	test   %eax,%eax
8010709f:	78 19                	js     801070ba <sys_write+0x4b>
801070a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801070a4:	83 ec 04             	sub    $0x4,%esp
801070a7:	50                   	push   %eax
801070a8:	8d 45 ec             	lea    -0x14(%ebp),%eax
801070ab:	50                   	push   %eax
801070ac:	6a 01                	push   $0x1
801070ae:	e8 9e fb ff ff       	call   80106c51 <argptr>
801070b3:	83 c4 10             	add    $0x10,%esp
801070b6:	85 c0                	test   %eax,%eax
801070b8:	79 07                	jns    801070c1 <sys_write+0x52>
    return -1;
801070ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070bf:	eb 17                	jmp    801070d8 <sys_write+0x69>
  return filewrite(f, p, n);
801070c1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801070c4:	8b 55 ec             	mov    -0x14(%ebp),%edx
801070c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801070ca:	83 ec 04             	sub    $0x4,%esp
801070cd:	51                   	push   %ecx
801070ce:	52                   	push   %edx
801070cf:	50                   	push   %eax
801070d0:	e8 e6 ab ff ff       	call   80101cbb <filewrite>
801070d5:	83 c4 10             	add    $0x10,%esp
}
801070d8:	c9                   	leave  
801070d9:	c3                   	ret    

801070da <sys_close>:

int
sys_close(void)
{
801070da:	55                   	push   %ebp
801070db:	89 e5                	mov    %esp,%ebp
801070dd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
801070e0:	83 ec 04             	sub    $0x4,%esp
801070e3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801070e6:	50                   	push   %eax
801070e7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801070ea:	50                   	push   %eax
801070eb:	6a 00                	push   $0x0
801070ed:	e8 fa fd ff ff       	call   80106eec <argfd>
801070f2:	83 c4 10             	add    $0x10,%esp
801070f5:	85 c0                	test   %eax,%eax
801070f7:	79 07                	jns    80107100 <sys_close+0x26>
    return -1;
801070f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070fe:	eb 28                	jmp    80107128 <sys_close+0x4e>
  proc->ofile[fd] = 0;
80107100:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107106:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107109:	83 c2 08             	add    $0x8,%edx
8010710c:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80107113:	00 
  fileclose(f);
80107114:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107117:	83 ec 0c             	sub    $0xc,%esp
8010711a:	50                   	push   %eax
8010711b:	e8 a4 a9 ff ff       	call   80101ac4 <fileclose>
80107120:	83 c4 10             	add    $0x10,%esp
  return 0;
80107123:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107128:	c9                   	leave  
80107129:	c3                   	ret    

8010712a <sys_fstat>:

int
sys_fstat(void)
{
8010712a:	55                   	push   %ebp
8010712b:	89 e5                	mov    %esp,%ebp
8010712d:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80107130:	83 ec 04             	sub    $0x4,%esp
80107133:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107136:	50                   	push   %eax
80107137:	6a 00                	push   $0x0
80107139:	6a 00                	push   $0x0
8010713b:	e8 ac fd ff ff       	call   80106eec <argfd>
80107140:	83 c4 10             	add    $0x10,%esp
80107143:	85 c0                	test   %eax,%eax
80107145:	78 17                	js     8010715e <sys_fstat+0x34>
80107147:	83 ec 04             	sub    $0x4,%esp
8010714a:	6a 14                	push   $0x14
8010714c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010714f:	50                   	push   %eax
80107150:	6a 01                	push   $0x1
80107152:	e8 fa fa ff ff       	call   80106c51 <argptr>
80107157:	83 c4 10             	add    $0x10,%esp
8010715a:	85 c0                	test   %eax,%eax
8010715c:	79 07                	jns    80107165 <sys_fstat+0x3b>
    return -1;
8010715e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107163:	eb 13                	jmp    80107178 <sys_fstat+0x4e>
  return filestat(f, st);
80107165:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107168:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010716b:	83 ec 08             	sub    $0x8,%esp
8010716e:	52                   	push   %edx
8010716f:	50                   	push   %eax
80107170:	e8 37 aa ff ff       	call   80101bac <filestat>
80107175:	83 c4 10             	add    $0x10,%esp
}
80107178:	c9                   	leave  
80107179:	c3                   	ret    

8010717a <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
8010717a:	55                   	push   %ebp
8010717b:	89 e5                	mov    %esp,%ebp
8010717d:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80107180:	83 ec 08             	sub    $0x8,%esp
80107183:	8d 45 d8             	lea    -0x28(%ebp),%eax
80107186:	50                   	push   %eax
80107187:	6a 00                	push   $0x0
80107189:	e8 20 fb ff ff       	call   80106cae <argstr>
8010718e:	83 c4 10             	add    $0x10,%esp
80107191:	85 c0                	test   %eax,%eax
80107193:	78 15                	js     801071aa <sys_link+0x30>
80107195:	83 ec 08             	sub    $0x8,%esp
80107198:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010719b:	50                   	push   %eax
8010719c:	6a 01                	push   $0x1
8010719e:	e8 0b fb ff ff       	call   80106cae <argstr>
801071a3:	83 c4 10             	add    $0x10,%esp
801071a6:	85 c0                	test   %eax,%eax
801071a8:	79 0a                	jns    801071b4 <sys_link+0x3a>
    return -1;
801071aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801071af:	e9 68 01 00 00       	jmp    8010731c <sys_link+0x1a2>

  begin_op();
801071b4:	e8 f3 d1 ff ff       	call   801043ac <begin_op>
  if((ip = namei(old)) == 0){
801071b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801071bc:	83 ec 0c             	sub    $0xc,%esp
801071bf:	50                   	push   %eax
801071c0:	e8 45 bf ff ff       	call   8010310a <namei>
801071c5:	83 c4 10             	add    $0x10,%esp
801071c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801071cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801071cf:	75 0f                	jne    801071e0 <sys_link+0x66>
    end_op();
801071d1:	e8 62 d2 ff ff       	call   80104438 <end_op>
    return -1;
801071d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801071db:	e9 3c 01 00 00       	jmp    8010731c <sys_link+0x1a2>
  }

  ilock(ip);
801071e0:	83 ec 0c             	sub    $0xc,%esp
801071e3:	ff 75 f4             	pushl  -0xc(%ebp)
801071e6:	e8 36 b3 ff ff       	call   80102521 <ilock>
801071eb:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
801071ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801071f1:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801071f5:	66 83 f8 01          	cmp    $0x1,%ax
801071f9:	75 1d                	jne    80107218 <sys_link+0x9e>
    iunlockput(ip);
801071fb:	83 ec 0c             	sub    $0xc,%esp
801071fe:	ff 75 f4             	pushl  -0xc(%ebp)
80107201:	e8 db b5 ff ff       	call   801027e1 <iunlockput>
80107206:	83 c4 10             	add    $0x10,%esp
    end_op();
80107209:	e8 2a d2 ff ff       	call   80104438 <end_op>
    return -1;
8010720e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107213:	e9 04 01 00 00       	jmp    8010731c <sys_link+0x1a2>
  }

  ip->nlink++;
80107218:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010721b:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010721f:	83 c0 01             	add    $0x1,%eax
80107222:	89 c2                	mov    %eax,%edx
80107224:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107227:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
8010722b:	83 ec 0c             	sub    $0xc,%esp
8010722e:	ff 75 f4             	pushl  -0xc(%ebp)
80107231:	e8 11 b1 ff ff       	call   80102347 <iupdate>
80107236:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80107239:	83 ec 0c             	sub    $0xc,%esp
8010723c:	ff 75 f4             	pushl  -0xc(%ebp)
8010723f:	e8 3b b4 ff ff       	call   8010267f <iunlock>
80107244:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80107247:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010724a:	83 ec 08             	sub    $0x8,%esp
8010724d:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80107250:	52                   	push   %edx
80107251:	50                   	push   %eax
80107252:	e8 cf be ff ff       	call   80103126 <nameiparent>
80107257:	83 c4 10             	add    $0x10,%esp
8010725a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010725d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107261:	74 71                	je     801072d4 <sys_link+0x15a>
    goto bad;
  ilock(dp);
80107263:	83 ec 0c             	sub    $0xc,%esp
80107266:	ff 75 f0             	pushl  -0x10(%ebp)
80107269:	e8 b3 b2 ff ff       	call   80102521 <ilock>
8010726e:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80107271:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107274:	8b 10                	mov    (%eax),%edx
80107276:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107279:	8b 00                	mov    (%eax),%eax
8010727b:	39 c2                	cmp    %eax,%edx
8010727d:	75 1d                	jne    8010729c <sys_link+0x122>
8010727f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107282:	8b 40 04             	mov    0x4(%eax),%eax
80107285:	83 ec 04             	sub    $0x4,%esp
80107288:	50                   	push   %eax
80107289:	8d 45 e2             	lea    -0x1e(%ebp),%eax
8010728c:	50                   	push   %eax
8010728d:	ff 75 f0             	pushl  -0x10(%ebp)
80107290:	e8 d9 bb ff ff       	call   80102e6e <dirlink>
80107295:	83 c4 10             	add    $0x10,%esp
80107298:	85 c0                	test   %eax,%eax
8010729a:	79 10                	jns    801072ac <sys_link+0x132>
    iunlockput(dp);
8010729c:	83 ec 0c             	sub    $0xc,%esp
8010729f:	ff 75 f0             	pushl  -0x10(%ebp)
801072a2:	e8 3a b5 ff ff       	call   801027e1 <iunlockput>
801072a7:	83 c4 10             	add    $0x10,%esp
    goto bad;
801072aa:	eb 29                	jmp    801072d5 <sys_link+0x15b>
  }
  iunlockput(dp);
801072ac:	83 ec 0c             	sub    $0xc,%esp
801072af:	ff 75 f0             	pushl  -0x10(%ebp)
801072b2:	e8 2a b5 ff ff       	call   801027e1 <iunlockput>
801072b7:	83 c4 10             	add    $0x10,%esp
  iput(ip);
801072ba:	83 ec 0c             	sub    $0xc,%esp
801072bd:	ff 75 f4             	pushl  -0xc(%ebp)
801072c0:	e8 2c b4 ff ff       	call   801026f1 <iput>
801072c5:	83 c4 10             	add    $0x10,%esp

  end_op();
801072c8:	e8 6b d1 ff ff       	call   80104438 <end_op>

  return 0;
801072cd:	b8 00 00 00 00       	mov    $0x0,%eax
801072d2:	eb 48                	jmp    8010731c <sys_link+0x1a2>
    goto bad;
801072d4:	90                   	nop

bad:
  ilock(ip);
801072d5:	83 ec 0c             	sub    $0xc,%esp
801072d8:	ff 75 f4             	pushl  -0xc(%ebp)
801072db:	e8 41 b2 ff ff       	call   80102521 <ilock>
801072e0:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
801072e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801072e6:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801072ea:	83 e8 01             	sub    $0x1,%eax
801072ed:	89 c2                	mov    %eax,%edx
801072ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801072f2:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801072f6:	83 ec 0c             	sub    $0xc,%esp
801072f9:	ff 75 f4             	pushl  -0xc(%ebp)
801072fc:	e8 46 b0 ff ff       	call   80102347 <iupdate>
80107301:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80107304:	83 ec 0c             	sub    $0xc,%esp
80107307:	ff 75 f4             	pushl  -0xc(%ebp)
8010730a:	e8 d2 b4 ff ff       	call   801027e1 <iunlockput>
8010730f:	83 c4 10             	add    $0x10,%esp
  end_op();
80107312:	e8 21 d1 ff ff       	call   80104438 <end_op>
  return -1;
80107317:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010731c:	c9                   	leave  
8010731d:	c3                   	ret    

8010731e <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
8010731e:	55                   	push   %ebp
8010731f:	89 e5                	mov    %esp,%ebp
80107321:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80107324:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
8010732b:	eb 40                	jmp    8010736d <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010732d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107330:	6a 10                	push   $0x10
80107332:	50                   	push   %eax
80107333:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107336:	50                   	push   %eax
80107337:	ff 75 08             	pushl  0x8(%ebp)
8010733a:	e8 4b b7 ff ff       	call   80102a8a <readi>
8010733f:	83 c4 10             	add    $0x10,%esp
80107342:	83 f8 10             	cmp    $0x10,%eax
80107345:	74 0d                	je     80107354 <isdirempty+0x36>
      panic("isdirempty: readi");
80107347:	83 ec 0c             	sub    $0xc,%esp
8010734a:	68 94 b9 10 80       	push   $0x8010b994
8010734f:	e8 ea 9a ff ff       	call   80100e3e <panic>
    if(de.inum != 0)
80107354:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80107358:	66 85 c0             	test   %ax,%ax
8010735b:	74 07                	je     80107364 <isdirempty+0x46>
      return 0;
8010735d:	b8 00 00 00 00       	mov    $0x0,%eax
80107362:	eb 1b                	jmp    8010737f <isdirempty+0x61>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80107364:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107367:	83 c0 10             	add    $0x10,%eax
8010736a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010736d:	8b 45 08             	mov    0x8(%ebp),%eax
80107370:	8b 50 18             	mov    0x18(%eax),%edx
80107373:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107376:	39 c2                	cmp    %eax,%edx
80107378:	77 b3                	ja     8010732d <isdirempty+0xf>
  }
  return 1;
8010737a:	b8 01 00 00 00       	mov    $0x1,%eax
}
8010737f:	c9                   	leave  
80107380:	c3                   	ret    

80107381 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80107381:	55                   	push   %ebp
80107382:	89 e5                	mov    %esp,%ebp
80107384:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80107387:	83 ec 08             	sub    $0x8,%esp
8010738a:	8d 45 cc             	lea    -0x34(%ebp),%eax
8010738d:	50                   	push   %eax
8010738e:	6a 00                	push   $0x0
80107390:	e8 19 f9 ff ff       	call   80106cae <argstr>
80107395:	83 c4 10             	add    $0x10,%esp
80107398:	85 c0                	test   %eax,%eax
8010739a:	79 0a                	jns    801073a6 <sys_unlink+0x25>
    return -1;
8010739c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801073a1:	e9 bf 01 00 00       	jmp    80107565 <sys_unlink+0x1e4>

  begin_op();
801073a6:	e8 01 d0 ff ff       	call   801043ac <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801073ab:	8b 45 cc             	mov    -0x34(%ebp),%eax
801073ae:	83 ec 08             	sub    $0x8,%esp
801073b1:	8d 55 d2             	lea    -0x2e(%ebp),%edx
801073b4:	52                   	push   %edx
801073b5:	50                   	push   %eax
801073b6:	e8 6b bd ff ff       	call   80103126 <nameiparent>
801073bb:	83 c4 10             	add    $0x10,%esp
801073be:	89 45 f4             	mov    %eax,-0xc(%ebp)
801073c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801073c5:	75 0f                	jne    801073d6 <sys_unlink+0x55>
    end_op();
801073c7:	e8 6c d0 ff ff       	call   80104438 <end_op>
    return -1;
801073cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801073d1:	e9 8f 01 00 00       	jmp    80107565 <sys_unlink+0x1e4>
  }

  ilock(dp);
801073d6:	83 ec 0c             	sub    $0xc,%esp
801073d9:	ff 75 f4             	pushl  -0xc(%ebp)
801073dc:	e8 40 b1 ff ff       	call   80102521 <ilock>
801073e1:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801073e4:	83 ec 08             	sub    $0x8,%esp
801073e7:	68 a6 b9 10 80       	push   $0x8010b9a6
801073ec:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801073ef:	50                   	push   %eax
801073f0:	e8 a4 b9 ff ff       	call   80102d99 <namecmp>
801073f5:	83 c4 10             	add    $0x10,%esp
801073f8:	85 c0                	test   %eax,%eax
801073fa:	0f 84 49 01 00 00    	je     80107549 <sys_unlink+0x1c8>
80107400:	83 ec 08             	sub    $0x8,%esp
80107403:	68 a8 b9 10 80       	push   $0x8010b9a8
80107408:	8d 45 d2             	lea    -0x2e(%ebp),%eax
8010740b:	50                   	push   %eax
8010740c:	e8 88 b9 ff ff       	call   80102d99 <namecmp>
80107411:	83 c4 10             	add    $0x10,%esp
80107414:	85 c0                	test   %eax,%eax
80107416:	0f 84 2d 01 00 00    	je     80107549 <sys_unlink+0x1c8>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010741c:	83 ec 04             	sub    $0x4,%esp
8010741f:	8d 45 c8             	lea    -0x38(%ebp),%eax
80107422:	50                   	push   %eax
80107423:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80107426:	50                   	push   %eax
80107427:	ff 75 f4             	pushl  -0xc(%ebp)
8010742a:	e8 85 b9 ff ff       	call   80102db4 <dirlookup>
8010742f:	83 c4 10             	add    $0x10,%esp
80107432:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107435:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107439:	0f 84 0d 01 00 00    	je     8010754c <sys_unlink+0x1cb>
    goto bad;
  ilock(ip);
8010743f:	83 ec 0c             	sub    $0xc,%esp
80107442:	ff 75 f0             	pushl  -0x10(%ebp)
80107445:	e8 d7 b0 ff ff       	call   80102521 <ilock>
8010744a:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
8010744d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107450:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80107454:	66 85 c0             	test   %ax,%ax
80107457:	7f 0d                	jg     80107466 <sys_unlink+0xe5>
    panic("unlink: nlink < 1");
80107459:	83 ec 0c             	sub    $0xc,%esp
8010745c:	68 ab b9 10 80       	push   $0x8010b9ab
80107461:	e8 d8 99 ff ff       	call   80100e3e <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80107466:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107469:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010746d:	66 83 f8 01          	cmp    $0x1,%ax
80107471:	75 25                	jne    80107498 <sys_unlink+0x117>
80107473:	83 ec 0c             	sub    $0xc,%esp
80107476:	ff 75 f0             	pushl  -0x10(%ebp)
80107479:	e8 a0 fe ff ff       	call   8010731e <isdirempty>
8010747e:	83 c4 10             	add    $0x10,%esp
80107481:	85 c0                	test   %eax,%eax
80107483:	75 13                	jne    80107498 <sys_unlink+0x117>
    iunlockput(ip);
80107485:	83 ec 0c             	sub    $0xc,%esp
80107488:	ff 75 f0             	pushl  -0x10(%ebp)
8010748b:	e8 51 b3 ff ff       	call   801027e1 <iunlockput>
80107490:	83 c4 10             	add    $0x10,%esp
    goto bad;
80107493:	e9 b5 00 00 00       	jmp    8010754d <sys_unlink+0x1cc>
  }

  memset(&de, 0, sizeof(de));
80107498:	83 ec 04             	sub    $0x4,%esp
8010749b:	6a 10                	push   $0x10
8010749d:	6a 00                	push   $0x0
8010749f:	8d 45 e0             	lea    -0x20(%ebp),%eax
801074a2:	50                   	push   %eax
801074a3:	e8 8b f3 ff ff       	call   80106833 <memset>
801074a8:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801074ab:	8b 45 c8             	mov    -0x38(%ebp),%eax
801074ae:	6a 10                	push   $0x10
801074b0:	50                   	push   %eax
801074b1:	8d 45 e0             	lea    -0x20(%ebp),%eax
801074b4:	50                   	push   %eax
801074b5:	ff 75 f4             	pushl  -0xc(%ebp)
801074b8:	e8 3c b7 ff ff       	call   80102bf9 <writei>
801074bd:	83 c4 10             	add    $0x10,%esp
801074c0:	83 f8 10             	cmp    $0x10,%eax
801074c3:	74 0d                	je     801074d2 <sys_unlink+0x151>
    panic("unlink: writei");
801074c5:	83 ec 0c             	sub    $0xc,%esp
801074c8:	68 bd b9 10 80       	push   $0x8010b9bd
801074cd:	e8 6c 99 ff ff       	call   80100e3e <panic>
  if(ip->type == T_DIR){
801074d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801074d5:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801074d9:	66 83 f8 01          	cmp    $0x1,%ax
801074dd:	75 21                	jne    80107500 <sys_unlink+0x17f>
    dp->nlink--;
801074df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074e2:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801074e6:	83 e8 01             	sub    $0x1,%eax
801074e9:	89 c2                	mov    %eax,%edx
801074eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074ee:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
801074f2:	83 ec 0c             	sub    $0xc,%esp
801074f5:	ff 75 f4             	pushl  -0xc(%ebp)
801074f8:	e8 4a ae ff ff       	call   80102347 <iupdate>
801074fd:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80107500:	83 ec 0c             	sub    $0xc,%esp
80107503:	ff 75 f4             	pushl  -0xc(%ebp)
80107506:	e8 d6 b2 ff ff       	call   801027e1 <iunlockput>
8010750b:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
8010750e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107511:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80107515:	83 e8 01             	sub    $0x1,%eax
80107518:	89 c2                	mov    %eax,%edx
8010751a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010751d:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80107521:	83 ec 0c             	sub    $0xc,%esp
80107524:	ff 75 f0             	pushl  -0x10(%ebp)
80107527:	e8 1b ae ff ff       	call   80102347 <iupdate>
8010752c:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
8010752f:	83 ec 0c             	sub    $0xc,%esp
80107532:	ff 75 f0             	pushl  -0x10(%ebp)
80107535:	e8 a7 b2 ff ff       	call   801027e1 <iunlockput>
8010753a:	83 c4 10             	add    $0x10,%esp

  end_op();
8010753d:	e8 f6 ce ff ff       	call   80104438 <end_op>

  return 0;
80107542:	b8 00 00 00 00       	mov    $0x0,%eax
80107547:	eb 1c                	jmp    80107565 <sys_unlink+0x1e4>

bad:
80107549:	90                   	nop
8010754a:	eb 01                	jmp    8010754d <sys_unlink+0x1cc>
    goto bad;
8010754c:	90                   	nop
  iunlockput(dp);
8010754d:	83 ec 0c             	sub    $0xc,%esp
80107550:	ff 75 f4             	pushl  -0xc(%ebp)
80107553:	e8 89 b2 ff ff       	call   801027e1 <iunlockput>
80107558:	83 c4 10             	add    $0x10,%esp
  end_op();
8010755b:	e8 d8 ce ff ff       	call   80104438 <end_op>
  return -1;
80107560:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107565:	c9                   	leave  
80107566:	c3                   	ret    

80107567 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80107567:	55                   	push   %ebp
80107568:	89 e5                	mov    %esp,%ebp
8010756a:	83 ec 38             	sub    $0x38,%esp
8010756d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107570:	8b 55 10             	mov    0x10(%ebp),%edx
80107573:	8b 45 14             	mov    0x14(%ebp),%eax
80107576:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
8010757a:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
8010757e:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80107582:	83 ec 08             	sub    $0x8,%esp
80107585:	8d 45 de             	lea    -0x22(%ebp),%eax
80107588:	50                   	push   %eax
80107589:	ff 75 08             	pushl  0x8(%ebp)
8010758c:	e8 95 bb ff ff       	call   80103126 <nameiparent>
80107591:	83 c4 10             	add    $0x10,%esp
80107594:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107597:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010759b:	75 0a                	jne    801075a7 <create+0x40>
    return 0;
8010759d:	b8 00 00 00 00       	mov    $0x0,%eax
801075a2:	e9 90 01 00 00       	jmp    80107737 <create+0x1d0>
  ilock(dp);
801075a7:	83 ec 0c             	sub    $0xc,%esp
801075aa:	ff 75 f4             	pushl  -0xc(%ebp)
801075ad:	e8 6f af ff ff       	call   80102521 <ilock>
801075b2:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
801075b5:	83 ec 04             	sub    $0x4,%esp
801075b8:	8d 45 ec             	lea    -0x14(%ebp),%eax
801075bb:	50                   	push   %eax
801075bc:	8d 45 de             	lea    -0x22(%ebp),%eax
801075bf:	50                   	push   %eax
801075c0:	ff 75 f4             	pushl  -0xc(%ebp)
801075c3:	e8 ec b7 ff ff       	call   80102db4 <dirlookup>
801075c8:	83 c4 10             	add    $0x10,%esp
801075cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
801075ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801075d2:	74 50                	je     80107624 <create+0xbd>
    iunlockput(dp);
801075d4:	83 ec 0c             	sub    $0xc,%esp
801075d7:	ff 75 f4             	pushl  -0xc(%ebp)
801075da:	e8 02 b2 ff ff       	call   801027e1 <iunlockput>
801075df:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
801075e2:	83 ec 0c             	sub    $0xc,%esp
801075e5:	ff 75 f0             	pushl  -0x10(%ebp)
801075e8:	e8 34 af ff ff       	call   80102521 <ilock>
801075ed:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
801075f0:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801075f5:	75 15                	jne    8010760c <create+0xa5>
801075f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801075fa:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801075fe:	66 83 f8 02          	cmp    $0x2,%ax
80107602:	75 08                	jne    8010760c <create+0xa5>
      return ip;
80107604:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107607:	e9 2b 01 00 00       	jmp    80107737 <create+0x1d0>
    iunlockput(ip);
8010760c:	83 ec 0c             	sub    $0xc,%esp
8010760f:	ff 75 f0             	pushl  -0x10(%ebp)
80107612:	e8 ca b1 ff ff       	call   801027e1 <iunlockput>
80107617:	83 c4 10             	add    $0x10,%esp
    return 0;
8010761a:	b8 00 00 00 00       	mov    $0x0,%eax
8010761f:	e9 13 01 00 00       	jmp    80107737 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80107624:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80107628:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010762b:	8b 00                	mov    (%eax),%eax
8010762d:	83 ec 08             	sub    $0x8,%esp
80107630:	52                   	push   %edx
80107631:	50                   	push   %eax
80107632:	e8 39 ac ff ff       	call   80102270 <ialloc>
80107637:	83 c4 10             	add    $0x10,%esp
8010763a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010763d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107641:	75 0d                	jne    80107650 <create+0xe9>
    panic("create: ialloc");
80107643:	83 ec 0c             	sub    $0xc,%esp
80107646:	68 cc b9 10 80       	push   $0x8010b9cc
8010764b:	e8 ee 97 ff ff       	call   80100e3e <panic>

  ilock(ip);
80107650:	83 ec 0c             	sub    $0xc,%esp
80107653:	ff 75 f0             	pushl  -0x10(%ebp)
80107656:	e8 c6 ae ff ff       	call   80102521 <ilock>
8010765b:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
8010765e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107661:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80107665:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80107669:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010766c:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80107670:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80107674:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107677:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
8010767d:	83 ec 0c             	sub    $0xc,%esp
80107680:	ff 75 f0             	pushl  -0x10(%ebp)
80107683:	e8 bf ac ff ff       	call   80102347 <iupdate>
80107688:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
8010768b:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80107690:	75 6a                	jne    801076fc <create+0x195>
    dp->nlink++;  // for ".."
80107692:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107695:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80107699:	83 c0 01             	add    $0x1,%eax
8010769c:	89 c2                	mov    %eax,%edx
8010769e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a1:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
801076a5:	83 ec 0c             	sub    $0xc,%esp
801076a8:	ff 75 f4             	pushl  -0xc(%ebp)
801076ab:	e8 97 ac ff ff       	call   80102347 <iupdate>
801076b0:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801076b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801076b6:	8b 40 04             	mov    0x4(%eax),%eax
801076b9:	83 ec 04             	sub    $0x4,%esp
801076bc:	50                   	push   %eax
801076bd:	68 a6 b9 10 80       	push   $0x8010b9a6
801076c2:	ff 75 f0             	pushl  -0x10(%ebp)
801076c5:	e8 a4 b7 ff ff       	call   80102e6e <dirlink>
801076ca:	83 c4 10             	add    $0x10,%esp
801076cd:	85 c0                	test   %eax,%eax
801076cf:	78 1e                	js     801076ef <create+0x188>
801076d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076d4:	8b 40 04             	mov    0x4(%eax),%eax
801076d7:	83 ec 04             	sub    $0x4,%esp
801076da:	50                   	push   %eax
801076db:	68 a8 b9 10 80       	push   $0x8010b9a8
801076e0:	ff 75 f0             	pushl  -0x10(%ebp)
801076e3:	e8 86 b7 ff ff       	call   80102e6e <dirlink>
801076e8:	83 c4 10             	add    $0x10,%esp
801076eb:	85 c0                	test   %eax,%eax
801076ed:	79 0d                	jns    801076fc <create+0x195>
      panic("create dots");
801076ef:	83 ec 0c             	sub    $0xc,%esp
801076f2:	68 db b9 10 80       	push   $0x8010b9db
801076f7:	e8 42 97 ff ff       	call   80100e3e <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
801076fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801076ff:	8b 40 04             	mov    0x4(%eax),%eax
80107702:	83 ec 04             	sub    $0x4,%esp
80107705:	50                   	push   %eax
80107706:	8d 45 de             	lea    -0x22(%ebp),%eax
80107709:	50                   	push   %eax
8010770a:	ff 75 f4             	pushl  -0xc(%ebp)
8010770d:	e8 5c b7 ff ff       	call   80102e6e <dirlink>
80107712:	83 c4 10             	add    $0x10,%esp
80107715:	85 c0                	test   %eax,%eax
80107717:	79 0d                	jns    80107726 <create+0x1bf>
    panic("create: dirlink");
80107719:	83 ec 0c             	sub    $0xc,%esp
8010771c:	68 e7 b9 10 80       	push   $0x8010b9e7
80107721:	e8 18 97 ff ff       	call   80100e3e <panic>

  iunlockput(dp);
80107726:	83 ec 0c             	sub    $0xc,%esp
80107729:	ff 75 f4             	pushl  -0xc(%ebp)
8010772c:	e8 b0 b0 ff ff       	call   801027e1 <iunlockput>
80107731:	83 c4 10             	add    $0x10,%esp

  return ip;
80107734:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107737:	c9                   	leave  
80107738:	c3                   	ret    

80107739 <sys_open>:

int
sys_open(void)
{
80107739:	55                   	push   %ebp
8010773a:	89 e5                	mov    %esp,%ebp
8010773c:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010773f:	83 ec 08             	sub    $0x8,%esp
80107742:	8d 45 e8             	lea    -0x18(%ebp),%eax
80107745:	50                   	push   %eax
80107746:	6a 00                	push   $0x0
80107748:	e8 61 f5 ff ff       	call   80106cae <argstr>
8010774d:	83 c4 10             	add    $0x10,%esp
80107750:	85 c0                	test   %eax,%eax
80107752:	78 15                	js     80107769 <sys_open+0x30>
80107754:	83 ec 08             	sub    $0x8,%esp
80107757:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010775a:	50                   	push   %eax
8010775b:	6a 01                	push   $0x1
8010775d:	e8 c7 f4 ff ff       	call   80106c29 <argint>
80107762:	83 c4 10             	add    $0x10,%esp
80107765:	85 c0                	test   %eax,%eax
80107767:	79 0a                	jns    80107773 <sys_open+0x3a>
    return -1;
80107769:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010776e:	e9 61 01 00 00       	jmp    801078d4 <sys_open+0x19b>

  begin_op();
80107773:	e8 34 cc ff ff       	call   801043ac <begin_op>

  if(omode & O_CREATE){
80107778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010777b:	25 00 02 00 00       	and    $0x200,%eax
80107780:	85 c0                	test   %eax,%eax
80107782:	74 2a                	je     801077ae <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
80107784:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107787:	6a 00                	push   $0x0
80107789:	6a 00                	push   $0x0
8010778b:	6a 02                	push   $0x2
8010778d:	50                   	push   %eax
8010778e:	e8 d4 fd ff ff       	call   80107567 <create>
80107793:	83 c4 10             	add    $0x10,%esp
80107796:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
80107799:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010779d:	75 75                	jne    80107814 <sys_open+0xdb>
      end_op();
8010779f:	e8 94 cc ff ff       	call   80104438 <end_op>
      return -1;
801077a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801077a9:	e9 26 01 00 00       	jmp    801078d4 <sys_open+0x19b>
    }
  } else {
    if((ip = namei(path)) == 0){
801077ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
801077b1:	83 ec 0c             	sub    $0xc,%esp
801077b4:	50                   	push   %eax
801077b5:	e8 50 b9 ff ff       	call   8010310a <namei>
801077ba:	83 c4 10             	add    $0x10,%esp
801077bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801077c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801077c4:	75 0f                	jne    801077d5 <sys_open+0x9c>
      end_op();
801077c6:	e8 6d cc ff ff       	call   80104438 <end_op>
      return -1;
801077cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801077d0:	e9 ff 00 00 00       	jmp    801078d4 <sys_open+0x19b>
    }
    ilock(ip);
801077d5:	83 ec 0c             	sub    $0xc,%esp
801077d8:	ff 75 f4             	pushl  -0xc(%ebp)
801077db:	e8 41 ad ff ff       	call   80102521 <ilock>
801077e0:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
801077e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077e6:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801077ea:	66 83 f8 01          	cmp    $0x1,%ax
801077ee:	75 24                	jne    80107814 <sys_open+0xdb>
801077f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801077f3:	85 c0                	test   %eax,%eax
801077f5:	74 1d                	je     80107814 <sys_open+0xdb>
      iunlockput(ip);
801077f7:	83 ec 0c             	sub    $0xc,%esp
801077fa:	ff 75 f4             	pushl  -0xc(%ebp)
801077fd:	e8 df af ff ff       	call   801027e1 <iunlockput>
80107802:	83 c4 10             	add    $0x10,%esp
      end_op();
80107805:	e8 2e cc ff ff       	call   80104438 <end_op>
      return -1;
8010780a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010780f:	e9 c0 00 00 00       	jmp    801078d4 <sys_open+0x19b>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80107814:	e8 ed a1 ff ff       	call   80101a06 <filealloc>
80107819:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010781c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107820:	74 17                	je     80107839 <sys_open+0x100>
80107822:	83 ec 0c             	sub    $0xc,%esp
80107825:	ff 75 f0             	pushl  -0x10(%ebp)
80107828:	e8 34 f7 ff ff       	call   80106f61 <fdalloc>
8010782d:	83 c4 10             	add    $0x10,%esp
80107830:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107833:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107837:	79 2e                	jns    80107867 <sys_open+0x12e>
    if(f)
80107839:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010783d:	74 0e                	je     8010784d <sys_open+0x114>
      fileclose(f);
8010783f:	83 ec 0c             	sub    $0xc,%esp
80107842:	ff 75 f0             	pushl  -0x10(%ebp)
80107845:	e8 7a a2 ff ff       	call   80101ac4 <fileclose>
8010784a:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010784d:	83 ec 0c             	sub    $0xc,%esp
80107850:	ff 75 f4             	pushl  -0xc(%ebp)
80107853:	e8 89 af ff ff       	call   801027e1 <iunlockput>
80107858:	83 c4 10             	add    $0x10,%esp
    end_op();
8010785b:	e8 d8 cb ff ff       	call   80104438 <end_op>
    return -1;
80107860:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107865:	eb 6d                	jmp    801078d4 <sys_open+0x19b>
  }
  iunlock(ip);
80107867:	83 ec 0c             	sub    $0xc,%esp
8010786a:	ff 75 f4             	pushl  -0xc(%ebp)
8010786d:	e8 0d ae ff ff       	call   8010267f <iunlock>
80107872:	83 c4 10             	add    $0x10,%esp
  end_op();
80107875:	e8 be cb ff ff       	call   80104438 <end_op>

  f->type = FD_INODE;
8010787a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010787d:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80107883:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107886:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107889:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
8010788c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010788f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80107896:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107899:	83 e0 01             	and    $0x1,%eax
8010789c:	85 c0                	test   %eax,%eax
8010789e:	0f 94 c0             	sete   %al
801078a1:	89 c2                	mov    %eax,%edx
801078a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801078a6:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801078a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078ac:	83 e0 01             	and    $0x1,%eax
801078af:	85 c0                	test   %eax,%eax
801078b1:	75 0a                	jne    801078bd <sys_open+0x184>
801078b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078b6:	83 e0 02             	and    $0x2,%eax
801078b9:	85 c0                	test   %eax,%eax
801078bb:	74 07                	je     801078c4 <sys_open+0x18b>
801078bd:	b8 01 00 00 00       	mov    $0x1,%eax
801078c2:	eb 05                	jmp    801078c9 <sys_open+0x190>
801078c4:	b8 00 00 00 00       	mov    $0x0,%eax
801078c9:	89 c2                	mov    %eax,%edx
801078cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801078ce:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
801078d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
801078d4:	c9                   	leave  
801078d5:	c3                   	ret    

801078d6 <sys_mkdir>:

int
sys_mkdir(void)
{
801078d6:	55                   	push   %ebp
801078d7:	89 e5                	mov    %esp,%ebp
801078d9:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801078dc:	e8 cb ca ff ff       	call   801043ac <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801078e1:	83 ec 08             	sub    $0x8,%esp
801078e4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801078e7:	50                   	push   %eax
801078e8:	6a 00                	push   $0x0
801078ea:	e8 bf f3 ff ff       	call   80106cae <argstr>
801078ef:	83 c4 10             	add    $0x10,%esp
801078f2:	85 c0                	test   %eax,%eax
801078f4:	78 1b                	js     80107911 <sys_mkdir+0x3b>
801078f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801078f9:	6a 00                	push   $0x0
801078fb:	6a 00                	push   $0x0
801078fd:	6a 01                	push   $0x1
801078ff:	50                   	push   %eax
80107900:	e8 62 fc ff ff       	call   80107567 <create>
80107905:	83 c4 10             	add    $0x10,%esp
80107908:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010790b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010790f:	75 0c                	jne    8010791d <sys_mkdir+0x47>
    end_op();
80107911:	e8 22 cb ff ff       	call   80104438 <end_op>
    return -1;
80107916:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010791b:	eb 18                	jmp    80107935 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
8010791d:	83 ec 0c             	sub    $0xc,%esp
80107920:	ff 75 f4             	pushl  -0xc(%ebp)
80107923:	e8 b9 ae ff ff       	call   801027e1 <iunlockput>
80107928:	83 c4 10             	add    $0x10,%esp
  end_op();
8010792b:	e8 08 cb ff ff       	call   80104438 <end_op>
  return 0;
80107930:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107935:	c9                   	leave  
80107936:	c3                   	ret    

80107937 <sys_mknod>:

int
sys_mknod(void)
{
80107937:	55                   	push   %ebp
80107938:	89 e5                	mov    %esp,%ebp
8010793a:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
8010793d:	e8 6a ca ff ff       	call   801043ac <begin_op>
  if((argstr(0, &path)) < 0 ||
80107942:	83 ec 08             	sub    $0x8,%esp
80107945:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107948:	50                   	push   %eax
80107949:	6a 00                	push   $0x0
8010794b:	e8 5e f3 ff ff       	call   80106cae <argstr>
80107950:	83 c4 10             	add    $0x10,%esp
80107953:	85 c0                	test   %eax,%eax
80107955:	78 4f                	js     801079a6 <sys_mknod+0x6f>
     argint(1, &major) < 0 ||
80107957:	83 ec 08             	sub    $0x8,%esp
8010795a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010795d:	50                   	push   %eax
8010795e:	6a 01                	push   $0x1
80107960:	e8 c4 f2 ff ff       	call   80106c29 <argint>
80107965:	83 c4 10             	add    $0x10,%esp
  if((argstr(0, &path)) < 0 ||
80107968:	85 c0                	test   %eax,%eax
8010796a:	78 3a                	js     801079a6 <sys_mknod+0x6f>
     argint(2, &minor) < 0 ||
8010796c:	83 ec 08             	sub    $0x8,%esp
8010796f:	8d 45 e8             	lea    -0x18(%ebp),%eax
80107972:	50                   	push   %eax
80107973:	6a 02                	push   $0x2
80107975:	e8 af f2 ff ff       	call   80106c29 <argint>
8010797a:	83 c4 10             	add    $0x10,%esp
     argint(1, &major) < 0 ||
8010797d:	85 c0                	test   %eax,%eax
8010797f:	78 25                	js     801079a6 <sys_mknod+0x6f>
     (ip = create(path, T_DEV, major, minor)) == 0){
80107981:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107984:	0f bf c8             	movswl %ax,%ecx
80107987:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010798a:	0f bf d0             	movswl %ax,%edx
8010798d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
80107990:	51                   	push   %ecx
80107991:	52                   	push   %edx
80107992:	6a 03                	push   $0x3
80107994:	50                   	push   %eax
80107995:	e8 cd fb ff ff       	call   80107567 <create>
8010799a:	83 c4 10             	add    $0x10,%esp
8010799d:	89 45 f4             	mov    %eax,-0xc(%ebp)
801079a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801079a4:	75 0c                	jne    801079b2 <sys_mknod+0x7b>
    end_op();
801079a6:	e8 8d ca ff ff       	call   80104438 <end_op>
    return -1;
801079ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801079b0:	eb 18                	jmp    801079ca <sys_mknod+0x93>
  }
  iunlockput(ip);
801079b2:	83 ec 0c             	sub    $0xc,%esp
801079b5:	ff 75 f4             	pushl  -0xc(%ebp)
801079b8:	e8 24 ae ff ff       	call   801027e1 <iunlockput>
801079bd:	83 c4 10             	add    $0x10,%esp
  end_op();
801079c0:	e8 73 ca ff ff       	call   80104438 <end_op>
  return 0;
801079c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
801079ca:	c9                   	leave  
801079cb:	c3                   	ret    

801079cc <sys_chdir>:

int
sys_chdir(void)
{
801079cc:	55                   	push   %ebp
801079cd:	89 e5                	mov    %esp,%ebp
801079cf:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801079d2:	e8 d5 c9 ff ff       	call   801043ac <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801079d7:	83 ec 08             	sub    $0x8,%esp
801079da:	8d 45 f0             	lea    -0x10(%ebp),%eax
801079dd:	50                   	push   %eax
801079de:	6a 00                	push   $0x0
801079e0:	e8 c9 f2 ff ff       	call   80106cae <argstr>
801079e5:	83 c4 10             	add    $0x10,%esp
801079e8:	85 c0                	test   %eax,%eax
801079ea:	78 18                	js     80107a04 <sys_chdir+0x38>
801079ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801079ef:	83 ec 0c             	sub    $0xc,%esp
801079f2:	50                   	push   %eax
801079f3:	e8 12 b7 ff ff       	call   8010310a <namei>
801079f8:	83 c4 10             	add    $0x10,%esp
801079fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801079fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107a02:	75 0c                	jne    80107a10 <sys_chdir+0x44>
    end_op();
80107a04:	e8 2f ca ff ff       	call   80104438 <end_op>
    return -1;
80107a09:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107a0e:	eb 6e                	jmp    80107a7e <sys_chdir+0xb2>
  }
  ilock(ip);
80107a10:	83 ec 0c             	sub    $0xc,%esp
80107a13:	ff 75 f4             	pushl  -0xc(%ebp)
80107a16:	e8 06 ab ff ff       	call   80102521 <ilock>
80107a1b:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80107a1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a21:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80107a25:	66 83 f8 01          	cmp    $0x1,%ax
80107a29:	74 1a                	je     80107a45 <sys_chdir+0x79>
    iunlockput(ip);
80107a2b:	83 ec 0c             	sub    $0xc,%esp
80107a2e:	ff 75 f4             	pushl  -0xc(%ebp)
80107a31:	e8 ab ad ff ff       	call   801027e1 <iunlockput>
80107a36:	83 c4 10             	add    $0x10,%esp
    end_op();
80107a39:	e8 fa c9 ff ff       	call   80104438 <end_op>
    return -1;
80107a3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107a43:	eb 39                	jmp    80107a7e <sys_chdir+0xb2>
  }
  iunlock(ip);
80107a45:	83 ec 0c             	sub    $0xc,%esp
80107a48:	ff 75 f4             	pushl  -0xc(%ebp)
80107a4b:	e8 2f ac ff ff       	call   8010267f <iunlock>
80107a50:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80107a53:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107a59:	8b 40 68             	mov    0x68(%eax),%eax
80107a5c:	83 ec 0c             	sub    $0xc,%esp
80107a5f:	50                   	push   %eax
80107a60:	e8 8c ac ff ff       	call   801026f1 <iput>
80107a65:	83 c4 10             	add    $0x10,%esp
  end_op();
80107a68:	e8 cb c9 ff ff       	call   80104438 <end_op>
  proc->cwd = ip;
80107a6d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107a73:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107a76:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80107a79:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107a7e:	c9                   	leave  
80107a7f:	c3                   	ret    

80107a80 <sys_exec>:

int
sys_exec(void)
{
80107a80:	55                   	push   %ebp
80107a81:	89 e5                	mov    %esp,%ebp
80107a83:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80107a89:	83 ec 08             	sub    $0x8,%esp
80107a8c:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107a8f:	50                   	push   %eax
80107a90:	6a 00                	push   $0x0
80107a92:	e8 17 f2 ff ff       	call   80106cae <argstr>
80107a97:	83 c4 10             	add    $0x10,%esp
80107a9a:	85 c0                	test   %eax,%eax
80107a9c:	78 18                	js     80107ab6 <sys_exec+0x36>
80107a9e:	83 ec 08             	sub    $0x8,%esp
80107aa1:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80107aa7:	50                   	push   %eax
80107aa8:	6a 01                	push   $0x1
80107aaa:	e8 7a f1 ff ff       	call   80106c29 <argint>
80107aaf:	83 c4 10             	add    $0x10,%esp
80107ab2:	85 c0                	test   %eax,%eax
80107ab4:	79 0a                	jns    80107ac0 <sys_exec+0x40>
    return -1;
80107ab6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107abb:	e9 c6 00 00 00       	jmp    80107b86 <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
80107ac0:	83 ec 04             	sub    $0x4,%esp
80107ac3:	68 80 00 00 00       	push   $0x80
80107ac8:	6a 00                	push   $0x0
80107aca:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80107ad0:	50                   	push   %eax
80107ad1:	e8 5d ed ff ff       	call   80106833 <memset>
80107ad6:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80107ad9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80107ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ae3:	83 f8 1f             	cmp    $0x1f,%eax
80107ae6:	76 0a                	jbe    80107af2 <sys_exec+0x72>
      return -1;
80107ae8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107aed:	e9 94 00 00 00       	jmp    80107b86 <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80107af2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af5:	c1 e0 02             	shl    $0x2,%eax
80107af8:	89 c2                	mov    %eax,%edx
80107afa:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80107b00:	01 c2                	add    %eax,%edx
80107b02:	83 ec 08             	sub    $0x8,%esp
80107b05:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80107b0b:	50                   	push   %eax
80107b0c:	52                   	push   %edx
80107b0d:	e8 7b f0 ff ff       	call   80106b8d <fetchint>
80107b12:	83 c4 10             	add    $0x10,%esp
80107b15:	85 c0                	test   %eax,%eax
80107b17:	79 07                	jns    80107b20 <sys_exec+0xa0>
      return -1;
80107b19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107b1e:	eb 66                	jmp    80107b86 <sys_exec+0x106>
    if(uarg == 0){
80107b20:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80107b26:	85 c0                	test   %eax,%eax
80107b28:	75 27                	jne    80107b51 <sys_exec+0xd1>
      argv[i] = 0;
80107b2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b2d:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80107b34:	00 00 00 00 
      break;
80107b38:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80107b39:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107b3c:	83 ec 08             	sub    $0x8,%esp
80107b3f:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80107b45:	52                   	push   %edx
80107b46:	50                   	push   %eax
80107b47:	e8 5f 9a ff ff       	call   801015ab <exec>
80107b4c:	83 c4 10             	add    $0x10,%esp
80107b4f:	eb 35                	jmp    80107b86 <sys_exec+0x106>
    if(fetchstr(uarg, &argv[i]) < 0)
80107b51:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80107b57:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107b5a:	c1 e2 02             	shl    $0x2,%edx
80107b5d:	01 c2                	add    %eax,%edx
80107b5f:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80107b65:	83 ec 08             	sub    $0x8,%esp
80107b68:	52                   	push   %edx
80107b69:	50                   	push   %eax
80107b6a:	e8 58 f0 ff ff       	call   80106bc7 <fetchstr>
80107b6f:	83 c4 10             	add    $0x10,%esp
80107b72:	85 c0                	test   %eax,%eax
80107b74:	79 07                	jns    80107b7d <sys_exec+0xfd>
      return -1;
80107b76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107b7b:	eb 09                	jmp    80107b86 <sys_exec+0x106>
  for(i=0;; i++){
80107b7d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(i >= NELEM(argv))
80107b81:	e9 5a ff ff ff       	jmp    80107ae0 <sys_exec+0x60>
}
80107b86:	c9                   	leave  
80107b87:	c3                   	ret    

80107b88 <sys_pipe>:

int
sys_pipe(void)
{
80107b88:	55                   	push   %ebp
80107b89:	89 e5                	mov    %esp,%ebp
80107b8b:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80107b8e:	83 ec 04             	sub    $0x4,%esp
80107b91:	6a 08                	push   $0x8
80107b93:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107b96:	50                   	push   %eax
80107b97:	6a 00                	push   $0x0
80107b99:	e8 b3 f0 ff ff       	call   80106c51 <argptr>
80107b9e:	83 c4 10             	add    $0x10,%esp
80107ba1:	85 c0                	test   %eax,%eax
80107ba3:	79 0a                	jns    80107baf <sys_pipe+0x27>
    return -1;
80107ba5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107baa:	e9 af 00 00 00       	jmp    80107c5e <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
80107baf:	83 ec 08             	sub    $0x8,%esp
80107bb2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107bb5:	50                   	push   %eax
80107bb6:	8d 45 e8             	lea    -0x18(%ebp),%eax
80107bb9:	50                   	push   %eax
80107bba:	e8 9a d9 ff ff       	call   80105559 <pipealloc>
80107bbf:	83 c4 10             	add    $0x10,%esp
80107bc2:	85 c0                	test   %eax,%eax
80107bc4:	79 0a                	jns    80107bd0 <sys_pipe+0x48>
    return -1;
80107bc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107bcb:	e9 8e 00 00 00       	jmp    80107c5e <sys_pipe+0xd6>
  fd0 = -1;
80107bd0:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80107bd7:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107bda:	83 ec 0c             	sub    $0xc,%esp
80107bdd:	50                   	push   %eax
80107bde:	e8 7e f3 ff ff       	call   80106f61 <fdalloc>
80107be3:	83 c4 10             	add    $0x10,%esp
80107be6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107be9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107bed:	78 18                	js     80107c07 <sys_pipe+0x7f>
80107bef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107bf2:	83 ec 0c             	sub    $0xc,%esp
80107bf5:	50                   	push   %eax
80107bf6:	e8 66 f3 ff ff       	call   80106f61 <fdalloc>
80107bfb:	83 c4 10             	add    $0x10,%esp
80107bfe:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107c01:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107c05:	79 3f                	jns    80107c46 <sys_pipe+0xbe>
    if(fd0 >= 0)
80107c07:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107c0b:	78 14                	js     80107c21 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80107c0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107c13:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107c16:	83 c2 08             	add    $0x8,%edx
80107c19:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80107c20:	00 
    fileclose(rf);
80107c21:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107c24:	83 ec 0c             	sub    $0xc,%esp
80107c27:	50                   	push   %eax
80107c28:	e8 97 9e ff ff       	call   80101ac4 <fileclose>
80107c2d:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80107c30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c33:	83 ec 0c             	sub    $0xc,%esp
80107c36:	50                   	push   %eax
80107c37:	e8 88 9e ff ff       	call   80101ac4 <fileclose>
80107c3c:	83 c4 10             	add    $0x10,%esp
    return -1;
80107c3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107c44:	eb 18                	jmp    80107c5e <sys_pipe+0xd6>
  }
  fd[0] = fd0;
80107c46:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107c49:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107c4c:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80107c4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107c51:	8d 50 04             	lea    0x4(%eax),%edx
80107c54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107c57:	89 02                	mov    %eax,(%edx)
  return 0;
80107c59:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107c5e:	c9                   	leave  
80107c5f:	c3                   	ret    

80107c60 <sys_select>:
 * 6. Make sure to call fileclrsel to clear any remaining wakeup calls before you return.
 * 7. Be sure you have turned off any bits in the sets that are not readable/writeable before returning.
 */
int
sys_select(void)
{
80107c60:	55                   	push   %ebp
80107c61:	89 e5                	mov    %esp,%ebp
80107c63:	83 ec 28             	sub    $0x28,%esp
    int nfds;
    fd_set *readfds, *writefds, retreadfds, retwritefds;
    FD_ZERO(&retreadfds);
80107c66:	8d 45 e8             	lea    -0x18(%ebp),%eax
80107c69:	50                   	push   %eax
80107c6a:	e8 6e f2 ff ff       	call   80106edd <_fd_zero>
80107c6f:	83 c4 04             	add    $0x4,%esp
    FD_ZERO(&retwritefds);
80107c72:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107c75:	50                   	push   %eax
80107c76:	e8 62 f2 ff ff       	call   80106edd <_fd_zero>
80107c7b:	83 c4 04             	add    $0x4,%esp

    if (argint(0, (void*)&nfds) < 0)
80107c7e:	83 ec 08             	sub    $0x8,%esp
80107c81:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107c84:	50                   	push   %eax
80107c85:	6a 00                	push   $0x0
80107c87:	e8 9d ef ff ff       	call   80106c29 <argint>
80107c8c:	83 c4 10             	add    $0x10,%esp
80107c8f:	85 c0                	test   %eax,%eax
80107c91:	79 07                	jns    80107c9a <sys_select+0x3a>
        return -1;
80107c93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107c98:	eb 7b                	jmp    80107d15 <sys_select+0xb5>
    if (argptr(1, (void*)&readfds, sizeof(readfds)) < 0)
80107c9a:	83 ec 04             	sub    $0x4,%esp
80107c9d:	6a 04                	push   $0x4
80107c9f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107ca2:	50                   	push   %eax
80107ca3:	6a 01                	push   $0x1
80107ca5:	e8 a7 ef ff ff       	call   80106c51 <argptr>
80107caa:	83 c4 10             	add    $0x10,%esp
80107cad:	85 c0                	test   %eax,%eax
80107caf:	79 07                	jns    80107cb8 <sys_select+0x58>
        return -1;
80107cb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107cb6:	eb 5d                	jmp    80107d15 <sys_select+0xb5>
    if (argptr(2, (void*)&writefds, sizeof(writefds)) < 0)
80107cb8:	83 ec 04             	sub    $0x4,%esp
80107cbb:	6a 04                	push   $0x4
80107cbd:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107cc0:	50                   	push   %eax
80107cc1:	6a 02                	push   $0x2
80107cc3:	e8 89 ef ff ff       	call   80106c51 <argptr>
80107cc8:	83 c4 10             	add    $0x10,%esp
80107ccb:	85 c0                	test   %eax,%eax
80107ccd:	79 07                	jns    80107cd6 <sys_select+0x76>
        return -1;
80107ccf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107cd4:	eb 3f                	jmp    80107d15 <sys_select+0xb5>
    acquire(&proc->selectlock);
80107cd6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107cdc:	83 e8 80             	sub    $0xffffff80,%eax
80107cdf:	83 ec 0c             	sub    $0xc,%esp
80107ce2:	50                   	push   %eax
80107ce3:	e8 d5 e8 ff ff       	call   801065bd <acquire>
80107ce8:	83 c4 10             	add    $0x10,%esp

    // LAB4: Your Code Here

    *readfds = retreadfds;
80107ceb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107cee:	8b 55 e8             	mov    -0x18(%ebp),%edx
80107cf1:	89 10                	mov    %edx,(%eax)
    *writefds = retwritefds;
80107cf3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107cf6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107cf9:	89 10                	mov    %edx,(%eax)

    release(&proc->selectlock);
80107cfb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107d01:	83 e8 80             	sub    $0xffffff80,%eax
80107d04:	83 ec 0c             	sub    $0xc,%esp
80107d07:	50                   	push   %eax
80107d08:	e8 1c e9 ff ff       	call   80106629 <release>
80107d0d:	83 c4 10             	add    $0x10,%esp
    return 0;
80107d10:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107d15:	c9                   	leave  
80107d16:	c3                   	ret    

80107d17 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80107d17:	55                   	push   %ebp
80107d18:	89 e5                	mov    %esp,%ebp
80107d1a:	83 ec 08             	sub    $0x8,%esp
  return fork();
80107d1d:	e8 a2 df ff ff       	call   80105cc4 <fork>
}
80107d22:	c9                   	leave  
80107d23:	c3                   	ret    

80107d24 <sys_exit>:

int
sys_exit(void)
{
80107d24:	55                   	push   %ebp
80107d25:	89 e5                	mov    %esp,%ebp
80107d27:	83 ec 08             	sub    $0x8,%esp
  exit();
80107d2a:	e8 48 e1 ff ff       	call   80105e77 <exit>
  return 0;  // not reached
80107d2f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107d34:	c9                   	leave  
80107d35:	c3                   	ret    

80107d36 <sys_wait>:

int
sys_wait(void)
{
80107d36:	55                   	push   %ebp
80107d37:	89 e5                	mov    %esp,%ebp
80107d39:	83 ec 08             	sub    $0x8,%esp
  return wait();
80107d3c:	e8 71 e2 ff ff       	call   80105fb2 <wait>
}
80107d41:	c9                   	leave  
80107d42:	c3                   	ret    

80107d43 <sys_kill>:

int
sys_kill(void)
{
80107d43:	55                   	push   %ebp
80107d44:	89 e5                	mov    %esp,%ebp
80107d46:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
80107d49:	83 ec 08             	sub    $0x8,%esp
80107d4c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107d4f:	50                   	push   %eax
80107d50:	6a 00                	push   $0x0
80107d52:	e8 d2 ee ff ff       	call   80106c29 <argint>
80107d57:	83 c4 10             	add    $0x10,%esp
80107d5a:	85 c0                	test   %eax,%eax
80107d5c:	79 07                	jns    80107d65 <sys_kill+0x22>
    return -1;
80107d5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107d63:	eb 0f                	jmp    80107d74 <sys_kill+0x31>
  return kill(pid);
80107d65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d68:	83 ec 0c             	sub    $0xc,%esp
80107d6b:	50                   	push   %eax
80107d6c:	e8 6f e6 ff ff       	call   801063e0 <kill>
80107d71:	83 c4 10             	add    $0x10,%esp
}
80107d74:	c9                   	leave  
80107d75:	c3                   	ret    

80107d76 <sys_getpid>:

int
sys_getpid(void)
{
80107d76:	55                   	push   %ebp
80107d77:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80107d79:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107d7f:	8b 40 10             	mov    0x10(%eax),%eax
}
80107d82:	5d                   	pop    %ebp
80107d83:	c3                   	ret    

80107d84 <sys_sbrk>:

int
sys_sbrk(void)
{
80107d84:	55                   	push   %ebp
80107d85:	89 e5                	mov    %esp,%ebp
80107d87:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80107d8a:	83 ec 08             	sub    $0x8,%esp
80107d8d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107d90:	50                   	push   %eax
80107d91:	6a 00                	push   $0x0
80107d93:	e8 91 ee ff ff       	call   80106c29 <argint>
80107d98:	83 c4 10             	add    $0x10,%esp
80107d9b:	85 c0                	test   %eax,%eax
80107d9d:	79 07                	jns    80107da6 <sys_sbrk+0x22>
    return -1;
80107d9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107da4:	eb 28                	jmp    80107dce <sys_sbrk+0x4a>
  addr = proc->sz;
80107da6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107dac:	8b 00                	mov    (%eax),%eax
80107dae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80107db1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107db4:	83 ec 0c             	sub    $0xc,%esp
80107db7:	50                   	push   %eax
80107db8:	e8 64 de ff ff       	call   80105c21 <growproc>
80107dbd:	83 c4 10             	add    $0x10,%esp
80107dc0:	85 c0                	test   %eax,%eax
80107dc2:	79 07                	jns    80107dcb <sys_sbrk+0x47>
    return -1;
80107dc4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107dc9:	eb 03                	jmp    80107dce <sys_sbrk+0x4a>
  return addr;
80107dcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80107dce:	c9                   	leave  
80107dcf:	c3                   	ret    

80107dd0 <timed_sleep>:

int
timed_sleep(int n)
{
80107dd0:	55                   	push   %ebp
80107dd1:	89 e5                	mov    %esp,%ebp
80107dd3:	83 ec 18             	sub    $0x18,%esp
  uint ticks0;

  acquire(&tickslock);
80107dd6:	83 ec 0c             	sub    $0xc,%esp
80107dd9:	68 20 46 13 80       	push   $0x80134620
80107dde:	e8 da e7 ff ff       	call   801065bd <acquire>
80107de3:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80107de6:	a1 60 4e 13 80       	mov    0x80134e60,%eax
80107deb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80107dee:	eb 39                	jmp    80107e29 <timed_sleep+0x59>
    if(proc->killed){
80107df0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107df6:	8b 40 24             	mov    0x24(%eax),%eax
80107df9:	85 c0                	test   %eax,%eax
80107dfb:	74 17                	je     80107e14 <timed_sleep+0x44>
      release(&tickslock);
80107dfd:	83 ec 0c             	sub    $0xc,%esp
80107e00:	68 20 46 13 80       	push   $0x80134620
80107e05:	e8 1f e8 ff ff       	call   80106629 <release>
80107e0a:	83 c4 10             	add    $0x10,%esp
      return -1;
80107e0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e12:	eb 3b                	jmp    80107e4f <timed_sleep+0x7f>
    }
    sleep(&ticks, &tickslock);
80107e14:	83 ec 08             	sub    $0x8,%esp
80107e17:	68 20 46 13 80       	push   $0x80134620
80107e1c:	68 60 4e 13 80       	push   $0x80134e60
80107e21:	e8 95 e4 ff ff       	call   801062bb <sleep>
80107e26:	83 c4 10             	add    $0x10,%esp
  while(ticks - ticks0 < n){
80107e29:	a1 60 4e 13 80       	mov    0x80134e60,%eax
80107e2e:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107e31:	89 c2                	mov    %eax,%edx
80107e33:	8b 45 08             	mov    0x8(%ebp),%eax
80107e36:	39 c2                	cmp    %eax,%edx
80107e38:	72 b6                	jb     80107df0 <timed_sleep+0x20>
  }
  release(&tickslock);
80107e3a:	83 ec 0c             	sub    $0xc,%esp
80107e3d:	68 20 46 13 80       	push   $0x80134620
80107e42:	e8 e2 e7 ff ff       	call   80106629 <release>
80107e47:	83 c4 10             	add    $0x10,%esp
  return 0;
80107e4a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107e4f:	c9                   	leave  
80107e50:	c3                   	ret    

80107e51 <sys_sleep>:

int
sys_sleep(void)
{
80107e51:	55                   	push   %ebp
80107e52:	89 e5                	mov    %esp,%ebp
80107e54:	83 ec 18             	sub    $0x18,%esp
  int n;

  if(argint(0, &n) < 0)
80107e57:	83 ec 08             	sub    $0x8,%esp
80107e5a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107e5d:	50                   	push   %eax
80107e5e:	6a 00                	push   $0x0
80107e60:	e8 c4 ed ff ff       	call   80106c29 <argint>
80107e65:	83 c4 10             	add    $0x10,%esp
80107e68:	85 c0                	test   %eax,%eax
80107e6a:	79 07                	jns    80107e73 <sys_sleep+0x22>
    return -1;
80107e6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e71:	eb 0f                	jmp    80107e82 <sys_sleep+0x31>
  
  return timed_sleep(n);
80107e73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e76:	83 ec 0c             	sub    $0xc,%esp
80107e79:	50                   	push   %eax
80107e7a:	e8 51 ff ff ff       	call   80107dd0 <timed_sleep>
80107e7f:	83 c4 10             	add    $0x10,%esp
}
80107e82:	c9                   	leave  
80107e83:	c3                   	ret    

80107e84 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80107e84:	55                   	push   %ebp
80107e85:	89 e5                	mov    %esp,%ebp
80107e87:	83 ec 18             	sub    $0x18,%esp
  uint xticks;

  acquire(&tickslock);
80107e8a:	83 ec 0c             	sub    $0xc,%esp
80107e8d:	68 20 46 13 80       	push   $0x80134620
80107e92:	e8 26 e7 ff ff       	call   801065bd <acquire>
80107e97:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
80107e9a:	a1 60 4e 13 80       	mov    0x80134e60,%eax
80107e9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80107ea2:	83 ec 0c             	sub    $0xc,%esp
80107ea5:	68 20 46 13 80       	push   $0x80134620
80107eaa:	e8 7a e7 ff ff       	call   80106629 <release>
80107eaf:	83 c4 10             	add    $0x10,%esp
  return xticks;
80107eb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80107eb5:	c9                   	leave  
80107eb6:	c3                   	ret    

80107eb7 <outb>:
{
80107eb7:	55                   	push   %ebp
80107eb8:	89 e5                	mov    %esp,%ebp
80107eba:	83 ec 08             	sub    $0x8,%esp
80107ebd:	8b 55 08             	mov    0x8(%ebp),%edx
80107ec0:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ec3:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80107ec7:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107eca:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80107ece:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80107ed2:	ee                   	out    %al,(%dx)
}
80107ed3:	90                   	nop
80107ed4:	c9                   	leave  
80107ed5:	c3                   	ret    

80107ed6 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80107ed6:	55                   	push   %ebp
80107ed7:	89 e5                	mov    %esp,%ebp
80107ed9:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80107edc:	6a 34                	push   $0x34
80107ede:	6a 43                	push   $0x43
80107ee0:	e8 d2 ff ff ff       	call   80107eb7 <outb>
80107ee5:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80107ee8:	68 9c 00 00 00       	push   $0x9c
80107eed:	6a 40                	push   $0x40
80107eef:	e8 c3 ff ff ff       	call   80107eb7 <outb>
80107ef4:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80107ef7:	6a 2e                	push   $0x2e
80107ef9:	6a 40                	push   $0x40
80107efb:	e8 b7 ff ff ff       	call   80107eb7 <outb>
80107f00:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80107f03:	83 ec 0c             	sub    $0xc,%esp
80107f06:	6a 00                	push   $0x0
80107f08:	e8 36 d5 ff ff       	call   80105443 <picenable>
80107f0d:	83 c4 10             	add    $0x10,%esp
}
80107f10:	90                   	nop
80107f11:	c9                   	leave  
80107f12:	c3                   	ret    

80107f13 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80107f13:	1e                   	push   %ds
  pushl %es
80107f14:	06                   	push   %es
  pushl %fs
80107f15:	0f a0                	push   %fs
  pushl %gs
80107f17:	0f a8                	push   %gs
  pushal
80107f19:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80107f1a:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80107f1e:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80107f20:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80107f22:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80107f26:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80107f28:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80107f2a:	54                   	push   %esp
  call trap
80107f2b:	e8 d7 01 00 00       	call   80108107 <trap>
  addl $4, %esp
80107f30:	83 c4 04             	add    $0x4,%esp

80107f33 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80107f33:	61                   	popa   
  popl %gs
80107f34:	0f a9                	pop    %gs
  popl %fs
80107f36:	0f a1                	pop    %fs
  popl %es
80107f38:	07                   	pop    %es
  popl %ds
80107f39:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80107f3a:	83 c4 08             	add    $0x8,%esp
  iret
80107f3d:	cf                   	iret   

80107f3e <lidt>:
{
80107f3e:	55                   	push   %ebp
80107f3f:	89 e5                	mov    %esp,%ebp
80107f41:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80107f44:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f47:	83 e8 01             	sub    $0x1,%eax
80107f4a:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107f4e:	8b 45 08             	mov    0x8(%ebp),%eax
80107f51:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107f55:	8b 45 08             	mov    0x8(%ebp),%eax
80107f58:	c1 e8 10             	shr    $0x10,%eax
80107f5b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80107f5f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107f62:	0f 01 18             	lidtl  (%eax)
}
80107f65:	90                   	nop
80107f66:	c9                   	leave  
80107f67:	c3                   	ret    

80107f68 <rcr2>:

static inline uint
rcr2(void)
{
80107f68:	55                   	push   %ebp
80107f69:	89 e5                	mov    %esp,%ebp
80107f6b:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107f6e:	0f 20 d0             	mov    %cr2,%eax
80107f71:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80107f74:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80107f77:	c9                   	leave  
80107f78:	c3                   	ret    

80107f79 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80107f79:	55                   	push   %ebp
80107f7a:	89 e5                	mov    %esp,%ebp
80107f7c:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80107f7f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107f86:	e9 c3 00 00 00       	jmp    8010804e <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80107f8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f8e:	8b 04 85 e8 90 12 80 	mov    -0x7fed6f18(,%eax,4),%eax
80107f95:	89 c2                	mov    %eax,%edx
80107f97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f9a:	66 89 14 c5 60 46 13 	mov    %dx,-0x7fecb9a0(,%eax,8)
80107fa1:	80 
80107fa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fa5:	66 c7 04 c5 62 46 13 	movw   $0x8,-0x7fecb99e(,%eax,8)
80107fac:	80 08 00 
80107faf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fb2:	0f b6 14 c5 64 46 13 	movzbl -0x7fecb99c(,%eax,8),%edx
80107fb9:	80 
80107fba:	83 e2 e0             	and    $0xffffffe0,%edx
80107fbd:	88 14 c5 64 46 13 80 	mov    %dl,-0x7fecb99c(,%eax,8)
80107fc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fc7:	0f b6 14 c5 64 46 13 	movzbl -0x7fecb99c(,%eax,8),%edx
80107fce:	80 
80107fcf:	83 e2 1f             	and    $0x1f,%edx
80107fd2:	88 14 c5 64 46 13 80 	mov    %dl,-0x7fecb99c(,%eax,8)
80107fd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fdc:	0f b6 14 c5 65 46 13 	movzbl -0x7fecb99b(,%eax,8),%edx
80107fe3:	80 
80107fe4:	83 e2 f0             	and    $0xfffffff0,%edx
80107fe7:	83 ca 0e             	or     $0xe,%edx
80107fea:	88 14 c5 65 46 13 80 	mov    %dl,-0x7fecb99b(,%eax,8)
80107ff1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ff4:	0f b6 14 c5 65 46 13 	movzbl -0x7fecb99b(,%eax,8),%edx
80107ffb:	80 
80107ffc:	83 e2 ef             	and    $0xffffffef,%edx
80107fff:	88 14 c5 65 46 13 80 	mov    %dl,-0x7fecb99b(,%eax,8)
80108006:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108009:	0f b6 14 c5 65 46 13 	movzbl -0x7fecb99b(,%eax,8),%edx
80108010:	80 
80108011:	83 e2 9f             	and    $0xffffff9f,%edx
80108014:	88 14 c5 65 46 13 80 	mov    %dl,-0x7fecb99b(,%eax,8)
8010801b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010801e:	0f b6 14 c5 65 46 13 	movzbl -0x7fecb99b(,%eax,8),%edx
80108025:	80 
80108026:	83 ca 80             	or     $0xffffff80,%edx
80108029:	88 14 c5 65 46 13 80 	mov    %dl,-0x7fecb99b(,%eax,8)
80108030:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108033:	8b 04 85 e8 90 12 80 	mov    -0x7fed6f18(,%eax,4),%eax
8010803a:	c1 e8 10             	shr    $0x10,%eax
8010803d:	89 c2                	mov    %eax,%edx
8010803f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108042:	66 89 14 c5 66 46 13 	mov    %dx,-0x7fecb99a(,%eax,8)
80108049:	80 
  for(i = 0; i < 256; i++)
8010804a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010804e:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80108055:	0f 8e 30 ff ff ff    	jle    80107f8b <tvinit+0x12>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010805b:	a1 e8 91 12 80       	mov    0x801291e8,%eax
80108060:	66 a3 60 48 13 80    	mov    %ax,0x80134860
80108066:	66 c7 05 62 48 13 80 	movw   $0x8,0x80134862
8010806d:	08 00 
8010806f:	0f b6 05 64 48 13 80 	movzbl 0x80134864,%eax
80108076:	83 e0 e0             	and    $0xffffffe0,%eax
80108079:	a2 64 48 13 80       	mov    %al,0x80134864
8010807e:	0f b6 05 64 48 13 80 	movzbl 0x80134864,%eax
80108085:	83 e0 1f             	and    $0x1f,%eax
80108088:	a2 64 48 13 80       	mov    %al,0x80134864
8010808d:	0f b6 05 65 48 13 80 	movzbl 0x80134865,%eax
80108094:	83 c8 0f             	or     $0xf,%eax
80108097:	a2 65 48 13 80       	mov    %al,0x80134865
8010809c:	0f b6 05 65 48 13 80 	movzbl 0x80134865,%eax
801080a3:	83 e0 ef             	and    $0xffffffef,%eax
801080a6:	a2 65 48 13 80       	mov    %al,0x80134865
801080ab:	0f b6 05 65 48 13 80 	movzbl 0x80134865,%eax
801080b2:	83 c8 60             	or     $0x60,%eax
801080b5:	a2 65 48 13 80       	mov    %al,0x80134865
801080ba:	0f b6 05 65 48 13 80 	movzbl 0x80134865,%eax
801080c1:	83 c8 80             	or     $0xffffff80,%eax
801080c4:	a2 65 48 13 80       	mov    %al,0x80134865
801080c9:	a1 e8 91 12 80       	mov    0x801291e8,%eax
801080ce:	c1 e8 10             	shr    $0x10,%eax
801080d1:	66 a3 66 48 13 80    	mov    %ax,0x80134866

  initlock(&tickslock, "time");
801080d7:	83 ec 08             	sub    $0x8,%esp
801080da:	68 f8 b9 10 80       	push   $0x8010b9f8
801080df:	68 20 46 13 80       	push   $0x80134620
801080e4:	e8 b2 e4 ff ff       	call   8010659b <initlock>
801080e9:	83 c4 10             	add    $0x10,%esp
}
801080ec:	90                   	nop
801080ed:	c9                   	leave  
801080ee:	c3                   	ret    

801080ef <idtinit>:

void
idtinit(void)
{
801080ef:	55                   	push   %ebp
801080f0:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
801080f2:	68 00 08 00 00       	push   $0x800
801080f7:	68 60 46 13 80       	push   $0x80134660
801080fc:	e8 3d fe ff ff       	call   80107f3e <lidt>
80108101:	83 c4 08             	add    $0x8,%esp
}
80108104:	90                   	nop
80108105:	c9                   	leave  
80108106:	c3                   	ret    

80108107 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80108107:	55                   	push   %ebp
80108108:	89 e5                	mov    %esp,%ebp
8010810a:	57                   	push   %edi
8010810b:	56                   	push   %esi
8010810c:	53                   	push   %ebx
8010810d:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80108110:	8b 45 08             	mov    0x8(%ebp),%eax
80108113:	8b 40 30             	mov    0x30(%eax),%eax
80108116:	83 f8 40             	cmp    $0x40,%eax
80108119:	75 3e                	jne    80108159 <trap+0x52>
    if(proc->killed)
8010811b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108121:	8b 40 24             	mov    0x24(%eax),%eax
80108124:	85 c0                	test   %eax,%eax
80108126:	74 05                	je     8010812d <trap+0x26>
      exit();
80108128:	e8 4a dd ff ff       	call   80105e77 <exit>
    proc->tf = tf;
8010812d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108133:	8b 55 08             	mov    0x8(%ebp),%edx
80108136:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
80108139:	e8 a1 eb ff ff       	call   80106cdf <syscall>
    if(proc->killed)
8010813e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108144:	8b 40 24             	mov    0x24(%eax),%eax
80108147:	85 c0                	test   %eax,%eax
80108149:	0f 84 06 02 00 00    	je     80108355 <trap+0x24e>
      exit();
8010814f:	e8 23 dd ff ff       	call   80105e77 <exit>
    return;
80108154:	e9 fc 01 00 00       	jmp    80108355 <trap+0x24e>
  }

  switch(tf->trapno){
80108159:	8b 45 08             	mov    0x8(%ebp),%eax
8010815c:	8b 40 30             	mov    0x30(%eax),%eax
8010815f:	83 e8 20             	sub    $0x20,%eax
80108162:	83 f8 1f             	cmp    $0x1f,%eax
80108165:	0f 87 b5 00 00 00    	ja     80108220 <trap+0x119>
8010816b:	8b 04 85 a0 ba 10 80 	mov    -0x7fef4560(,%eax,4),%eax
80108172:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80108174:	e8 6b bc ff ff       	call   80103de4 <cpunum>
80108179:	85 c0                	test   %eax,%eax
8010817b:	75 3d                	jne    801081ba <trap+0xb3>
      acquire(&tickslock);
8010817d:	83 ec 0c             	sub    $0xc,%esp
80108180:	68 20 46 13 80       	push   $0x80134620
80108185:	e8 33 e4 ff ff       	call   801065bd <acquire>
8010818a:	83 c4 10             	add    $0x10,%esp
      ticks++;
8010818d:	a1 60 4e 13 80       	mov    0x80134e60,%eax
80108192:	83 c0 01             	add    $0x1,%eax
80108195:	a3 60 4e 13 80       	mov    %eax,0x80134e60
      wakeup(&ticks);
8010819a:	83 ec 0c             	sub    $0xc,%esp
8010819d:	68 60 4e 13 80       	push   $0x80134e60
801081a2:	e8 02 e2 ff ff       	call   801063a9 <wakeup>
801081a7:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
801081aa:	83 ec 0c             	sub    $0xc,%esp
801081ad:	68 20 46 13 80       	push   $0x80134620
801081b2:	e8 72 e4 ff ff       	call   80106629 <release>
801081b7:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
801081ba:	e8 c3 bc ff ff       	call   80103e82 <lapiceoi>
    break;
801081bf:	e9 0b 01 00 00       	jmp    801082cf <trap+0x1c8>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801081c4:	e8 92 b4 ff ff       	call   8010365b <ideintr>
    lapiceoi();
801081c9:	e8 b4 bc ff ff       	call   80103e82 <lapiceoi>
    break;
801081ce:	e9 fc 00 00 00       	jmp    801082cf <trap+0x1c8>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801081d3:	e8 67 ba ff ff       	call   80103c3f <kbdintr>
    lapiceoi();
801081d8:	e8 a5 bc ff ff       	call   80103e82 <lapiceoi>
    break;
801081dd:	e9 ed 00 00 00       	jmp    801082cf <trap+0x1c8>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801081e2:	e8 7d 03 00 00       	call   80108564 <uartintr>
    lapiceoi();
801081e7:	e8 96 bc ff ff       	call   80103e82 <lapiceoi>
    break;
801081ec:	e9 de 00 00 00       	jmp    801082cf <trap+0x1c8>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801081f1:	8b 45 08             	mov    0x8(%ebp),%eax
801081f4:	8b 70 38             	mov    0x38(%eax),%esi
            cpunum(), tf->cs, tf->eip);
801081f7:	8b 45 08             	mov    0x8(%ebp),%eax
801081fa:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801081fe:	0f b7 d8             	movzwl %ax,%ebx
80108201:	e8 de bb ff ff       	call   80103de4 <cpunum>
80108206:	56                   	push   %esi
80108207:	53                   	push   %ebx
80108208:	50                   	push   %eax
80108209:	68 00 ba 10 80       	push   $0x8010ba00
8010820e:	e8 05 8c ff ff       	call   80100e18 <cprintf>
80108213:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80108216:	e8 67 bc ff ff       	call   80103e82 <lapiceoi>
    break;
8010821b:	e9 af 00 00 00       	jmp    801082cf <trap+0x1c8>

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80108220:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108226:	85 c0                	test   %eax,%eax
80108228:	74 11                	je     8010823b <trap+0x134>
8010822a:	8b 45 08             	mov    0x8(%ebp),%eax
8010822d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80108231:	0f b7 c0             	movzwl %ax,%eax
80108234:	83 e0 03             	and    $0x3,%eax
80108237:	85 c0                	test   %eax,%eax
80108239:	75 3b                	jne    80108276 <trap+0x16f>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010823b:	e8 28 fd ff ff       	call   80107f68 <rcr2>
80108240:	89 c6                	mov    %eax,%esi
80108242:	8b 45 08             	mov    0x8(%ebp),%eax
80108245:	8b 58 38             	mov    0x38(%eax),%ebx
80108248:	e8 97 bb ff ff       	call   80103de4 <cpunum>
8010824d:	89 c2                	mov    %eax,%edx
8010824f:	8b 45 08             	mov    0x8(%ebp),%eax
80108252:	8b 40 30             	mov    0x30(%eax),%eax
80108255:	83 ec 0c             	sub    $0xc,%esp
80108258:	56                   	push   %esi
80108259:	53                   	push   %ebx
8010825a:	52                   	push   %edx
8010825b:	50                   	push   %eax
8010825c:	68 24 ba 10 80       	push   $0x8010ba24
80108261:	e8 b2 8b ff ff       	call   80100e18 <cprintf>
80108266:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80108269:	83 ec 0c             	sub    $0xc,%esp
8010826c:	68 56 ba 10 80       	push   $0x8010ba56
80108271:	e8 c8 8b ff ff       	call   80100e3e <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80108276:	e8 ed fc ff ff       	call   80107f68 <rcr2>
8010827b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010827e:	8b 45 08             	mov    0x8(%ebp),%eax
80108281:	8b 58 38             	mov    0x38(%eax),%ebx
80108284:	e8 5b bb ff ff       	call   80103de4 <cpunum>
80108289:	89 c7                	mov    %eax,%edi
8010828b:	8b 45 08             	mov    0x8(%ebp),%eax
8010828e:	8b 48 34             	mov    0x34(%eax),%ecx
80108291:	8b 45 08             	mov    0x8(%ebp),%eax
80108294:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80108297:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010829d:	8d 70 6c             	lea    0x6c(%eax),%esi
801082a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801082a6:	8b 40 10             	mov    0x10(%eax),%eax
801082a9:	ff 75 e4             	pushl  -0x1c(%ebp)
801082ac:	53                   	push   %ebx
801082ad:	57                   	push   %edi
801082ae:	51                   	push   %ecx
801082af:	52                   	push   %edx
801082b0:	56                   	push   %esi
801082b1:	50                   	push   %eax
801082b2:	68 5c ba 10 80       	push   $0x8010ba5c
801082b7:	e8 5c 8b ff ff       	call   80100e18 <cprintf>
801082bc:	83 c4 20             	add    $0x20,%esp
            rcr2());
    proc->killed = 1;
801082bf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801082c5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801082cc:	eb 01                	jmp    801082cf <trap+0x1c8>
    break;
801082ce:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801082cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801082d5:	85 c0                	test   %eax,%eax
801082d7:	74 24                	je     801082fd <trap+0x1f6>
801082d9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801082df:	8b 40 24             	mov    0x24(%eax),%eax
801082e2:	85 c0                	test   %eax,%eax
801082e4:	74 17                	je     801082fd <trap+0x1f6>
801082e6:	8b 45 08             	mov    0x8(%ebp),%eax
801082e9:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801082ed:	0f b7 c0             	movzwl %ax,%eax
801082f0:	83 e0 03             	and    $0x3,%eax
801082f3:	83 f8 03             	cmp    $0x3,%eax
801082f6:	75 05                	jne    801082fd <trap+0x1f6>
    exit();
801082f8:	e8 7a db ff ff       	call   80105e77 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
801082fd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108303:	85 c0                	test   %eax,%eax
80108305:	74 1e                	je     80108325 <trap+0x21e>
80108307:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010830d:	8b 40 0c             	mov    0xc(%eax),%eax
80108310:	83 f8 04             	cmp    $0x4,%eax
80108313:	75 10                	jne    80108325 <trap+0x21e>
80108315:	8b 45 08             	mov    0x8(%ebp),%eax
80108318:	8b 40 30             	mov    0x30(%eax),%eax
8010831b:	83 f8 20             	cmp    $0x20,%eax
8010831e:	75 05                	jne    80108325 <trap+0x21e>
    yield();
80108320:	e8 15 df ff ff       	call   8010623a <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80108325:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010832b:	85 c0                	test   %eax,%eax
8010832d:	74 27                	je     80108356 <trap+0x24f>
8010832f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108335:	8b 40 24             	mov    0x24(%eax),%eax
80108338:	85 c0                	test   %eax,%eax
8010833a:	74 1a                	je     80108356 <trap+0x24f>
8010833c:	8b 45 08             	mov    0x8(%ebp),%eax
8010833f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80108343:	0f b7 c0             	movzwl %ax,%eax
80108346:	83 e0 03             	and    $0x3,%eax
80108349:	83 f8 03             	cmp    $0x3,%eax
8010834c:	75 08                	jne    80108356 <trap+0x24f>
    exit();
8010834e:	e8 24 db ff ff       	call   80105e77 <exit>
80108353:	eb 01                	jmp    80108356 <trap+0x24f>
    return;
80108355:	90                   	nop
}
80108356:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108359:	5b                   	pop    %ebx
8010835a:	5e                   	pop    %esi
8010835b:	5f                   	pop    %edi
8010835c:	5d                   	pop    %ebp
8010835d:	c3                   	ret    

8010835e <inb>:
{
8010835e:	55                   	push   %ebp
8010835f:	89 e5                	mov    %esp,%ebp
80108361:	83 ec 14             	sub    $0x14,%esp
80108364:	8b 45 08             	mov    0x8(%ebp),%eax
80108367:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010836b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010836f:	89 c2                	mov    %eax,%edx
80108371:	ec                   	in     (%dx),%al
80108372:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80108375:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80108379:	c9                   	leave  
8010837a:	c3                   	ret    

8010837b <outb>:
{
8010837b:	55                   	push   %ebp
8010837c:	89 e5                	mov    %esp,%ebp
8010837e:	83 ec 08             	sub    $0x8,%esp
80108381:	8b 55 08             	mov    0x8(%ebp),%edx
80108384:	8b 45 0c             	mov    0xc(%ebp),%eax
80108387:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010838b:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010838e:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80108392:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80108396:	ee                   	out    %al,(%dx)
}
80108397:	90                   	nop
80108398:	c9                   	leave  
80108399:	c3                   	ret    

8010839a <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
8010839a:	55                   	push   %ebp
8010839b:	89 e5                	mov    %esp,%ebp
8010839d:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
801083a0:	6a 00                	push   $0x0
801083a2:	68 fa 03 00 00       	push   $0x3fa
801083a7:	e8 cf ff ff ff       	call   8010837b <outb>
801083ac:	83 c4 08             	add    $0x8,%esp

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
801083af:	68 80 00 00 00       	push   $0x80
801083b4:	68 fb 03 00 00       	push   $0x3fb
801083b9:	e8 bd ff ff ff       	call   8010837b <outb>
801083be:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
801083c1:	6a 0c                	push   $0xc
801083c3:	68 f8 03 00 00       	push   $0x3f8
801083c8:	e8 ae ff ff ff       	call   8010837b <outb>
801083cd:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
801083d0:	6a 00                	push   $0x0
801083d2:	68 f9 03 00 00       	push   $0x3f9
801083d7:	e8 9f ff ff ff       	call   8010837b <outb>
801083dc:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
801083df:	6a 03                	push   $0x3
801083e1:	68 fb 03 00 00       	push   $0x3fb
801083e6:	e8 90 ff ff ff       	call   8010837b <outb>
801083eb:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
801083ee:	6a 00                	push   $0x0
801083f0:	68 fc 03 00 00       	push   $0x3fc
801083f5:	e8 81 ff ff ff       	call   8010837b <outb>
801083fa:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
801083fd:	6a 01                	push   $0x1
801083ff:	68 f9 03 00 00       	push   $0x3f9
80108404:	e8 72 ff ff ff       	call   8010837b <outb>
80108409:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
8010840c:	68 fd 03 00 00       	push   $0x3fd
80108411:	e8 48 ff ff ff       	call   8010835e <inb>
80108416:	83 c4 04             	add    $0x4,%esp
80108419:	3c ff                	cmp    $0xff,%al
8010841b:	74 6e                	je     8010848b <uartinit+0xf1>
    return;
  uart = 1;
8010841d:	c7 05 d0 96 12 80 01 	movl   $0x1,0x801296d0
80108424:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80108427:	68 fa 03 00 00       	push   $0x3fa
8010842c:	e8 2d ff ff ff       	call   8010835e <inb>
80108431:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80108434:	68 f8 03 00 00       	push   $0x3f8
80108439:	e8 20 ff ff ff       	call   8010835e <inb>
8010843e:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80108441:	83 ec 0c             	sub    $0xc,%esp
80108444:	6a 04                	push   $0x4
80108446:	e8 f8 cf ff ff       	call   80105443 <picenable>
8010844b:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
8010844e:	83 ec 08             	sub    $0x8,%esp
80108451:	6a 00                	push   $0x0
80108453:	6a 04                	push   $0x4
80108455:	e8 a3 b4 ff ff       	call   801038fd <ioapicenable>
8010845a:	83 c4 10             	add    $0x10,%esp

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
8010845d:	c7 45 f4 20 bb 10 80 	movl   $0x8010bb20,-0xc(%ebp)
80108464:	eb 19                	jmp    8010847f <uartinit+0xe5>
    uartputc(*p);
80108466:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108469:	0f b6 00             	movzbl (%eax),%eax
8010846c:	0f be c0             	movsbl %al,%eax
8010846f:	83 ec 0c             	sub    $0xc,%esp
80108472:	50                   	push   %eax
80108473:	e8 44 00 00 00       	call   801084bc <uartputc>
80108478:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
8010847b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010847f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108482:	0f b6 00             	movzbl (%eax),%eax
80108485:	84 c0                	test   %al,%al
80108487:	75 dd                	jne    80108466 <uartinit+0xcc>
80108489:	eb 01                	jmp    8010848c <uartinit+0xf2>
    return;
8010848b:	90                   	nop
}
8010848c:	c9                   	leave  
8010848d:	c3                   	ret    

8010848e <uartprintcstr>:

void
uartprintcstr(char * p)
{
8010848e:	55                   	push   %ebp
8010848f:	89 e5                	mov    %esp,%ebp
80108491:	83 ec 08             	sub    $0x8,%esp
	for(; *p; p++)
80108494:	eb 19                	jmp    801084af <uartprintcstr+0x21>
		uartputc(*p);
80108496:	8b 45 08             	mov    0x8(%ebp),%eax
80108499:	0f b6 00             	movzbl (%eax),%eax
8010849c:	0f be c0             	movsbl %al,%eax
8010849f:	83 ec 0c             	sub    $0xc,%esp
801084a2:	50                   	push   %eax
801084a3:	e8 14 00 00 00       	call   801084bc <uartputc>
801084a8:	83 c4 10             	add    $0x10,%esp
	for(; *p; p++)
801084ab:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801084af:	8b 45 08             	mov    0x8(%ebp),%eax
801084b2:	0f b6 00             	movzbl (%eax),%eax
801084b5:	84 c0                	test   %al,%al
801084b7:	75 dd                	jne    80108496 <uartprintcstr+0x8>
}
801084b9:	90                   	nop
801084ba:	c9                   	leave  
801084bb:	c3                   	ret    

801084bc <uartputc>:

void
uartputc(int c)
{
801084bc:	55                   	push   %ebp
801084bd:	89 e5                	mov    %esp,%ebp
801084bf:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
801084c2:	a1 d0 96 12 80       	mov    0x801296d0,%eax
801084c7:	85 c0                	test   %eax,%eax
801084c9:	74 53                	je     8010851e <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801084cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801084d2:	eb 11                	jmp    801084e5 <uartputc+0x29>
    microdelay(10);
801084d4:	83 ec 0c             	sub    $0xc,%esp
801084d7:	6a 0a                	push   $0xa
801084d9:	e8 bf b9 ff ff       	call   80103e9d <microdelay>
801084de:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801084e1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801084e5:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
801084e9:	7f 1a                	jg     80108505 <uartputc+0x49>
801084eb:	83 ec 0c             	sub    $0xc,%esp
801084ee:	68 fd 03 00 00       	push   $0x3fd
801084f3:	e8 66 fe ff ff       	call   8010835e <inb>
801084f8:	83 c4 10             	add    $0x10,%esp
801084fb:	0f b6 c0             	movzbl %al,%eax
801084fe:	83 e0 20             	and    $0x20,%eax
80108501:	85 c0                	test   %eax,%eax
80108503:	74 cf                	je     801084d4 <uartputc+0x18>
  outb(COM1+0, c);
80108505:	8b 45 08             	mov    0x8(%ebp),%eax
80108508:	0f b6 c0             	movzbl %al,%eax
8010850b:	83 ec 08             	sub    $0x8,%esp
8010850e:	50                   	push   %eax
8010850f:	68 f8 03 00 00       	push   $0x3f8
80108514:	e8 62 fe ff ff       	call   8010837b <outb>
80108519:	83 c4 10             	add    $0x10,%esp
8010851c:	eb 01                	jmp    8010851f <uartputc+0x63>
    return;
8010851e:	90                   	nop
}
8010851f:	c9                   	leave  
80108520:	c3                   	ret    

80108521 <uartgetc>:

int
uartgetc(void)
{
80108521:	55                   	push   %ebp
80108522:	89 e5                	mov    %esp,%ebp
  if(!uart)
80108524:	a1 d0 96 12 80       	mov    0x801296d0,%eax
80108529:	85 c0                	test   %eax,%eax
8010852b:	75 07                	jne    80108534 <uartgetc+0x13>
    return -1;
8010852d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108532:	eb 2e                	jmp    80108562 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80108534:	68 fd 03 00 00       	push   $0x3fd
80108539:	e8 20 fe ff ff       	call   8010835e <inb>
8010853e:	83 c4 04             	add    $0x4,%esp
80108541:	0f b6 c0             	movzbl %al,%eax
80108544:	83 e0 01             	and    $0x1,%eax
80108547:	85 c0                	test   %eax,%eax
80108549:	75 07                	jne    80108552 <uartgetc+0x31>
    return -1;
8010854b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108550:	eb 10                	jmp    80108562 <uartgetc+0x41>
  return inb(COM1+0);
80108552:	68 f8 03 00 00       	push   $0x3f8
80108557:	e8 02 fe ff ff       	call   8010835e <inb>
8010855c:	83 c4 04             	add    $0x4,%esp
8010855f:	0f b6 c0             	movzbl %al,%eax
}
80108562:	c9                   	leave  
80108563:	c3                   	ret    

80108564 <uartintr>:

void
uartintr(void)
{
80108564:	55                   	push   %ebp
80108565:	89 e5                	mov    %esp,%ebp
80108567:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
8010856a:	83 ec 0c             	sub    $0xc,%esp
8010856d:	68 21 85 10 80       	push   $0x80108521
80108572:	e8 04 8c ff ff       	call   8010117b <consoleintr>
80108577:	83 c4 10             	add    $0x10,%esp
}
8010857a:	90                   	nop
8010857b:	c9                   	leave  
8010857c:	c3                   	ret    

8010857d <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
8010857d:	6a 00                	push   $0x0
  pushl $0
8010857f:	6a 00                	push   $0x0
  jmp alltraps
80108581:	e9 8d f9 ff ff       	jmp    80107f13 <alltraps>

80108586 <vector1>:
.globl vector1
vector1:
  pushl $0
80108586:	6a 00                	push   $0x0
  pushl $1
80108588:	6a 01                	push   $0x1
  jmp alltraps
8010858a:	e9 84 f9 ff ff       	jmp    80107f13 <alltraps>

8010858f <vector2>:
.globl vector2
vector2:
  pushl $0
8010858f:	6a 00                	push   $0x0
  pushl $2
80108591:	6a 02                	push   $0x2
  jmp alltraps
80108593:	e9 7b f9 ff ff       	jmp    80107f13 <alltraps>

80108598 <vector3>:
.globl vector3
vector3:
  pushl $0
80108598:	6a 00                	push   $0x0
  pushl $3
8010859a:	6a 03                	push   $0x3
  jmp alltraps
8010859c:	e9 72 f9 ff ff       	jmp    80107f13 <alltraps>

801085a1 <vector4>:
.globl vector4
vector4:
  pushl $0
801085a1:	6a 00                	push   $0x0
  pushl $4
801085a3:	6a 04                	push   $0x4
  jmp alltraps
801085a5:	e9 69 f9 ff ff       	jmp    80107f13 <alltraps>

801085aa <vector5>:
.globl vector5
vector5:
  pushl $0
801085aa:	6a 00                	push   $0x0
  pushl $5
801085ac:	6a 05                	push   $0x5
  jmp alltraps
801085ae:	e9 60 f9 ff ff       	jmp    80107f13 <alltraps>

801085b3 <vector6>:
.globl vector6
vector6:
  pushl $0
801085b3:	6a 00                	push   $0x0
  pushl $6
801085b5:	6a 06                	push   $0x6
  jmp alltraps
801085b7:	e9 57 f9 ff ff       	jmp    80107f13 <alltraps>

801085bc <vector7>:
.globl vector7
vector7:
  pushl $0
801085bc:	6a 00                	push   $0x0
  pushl $7
801085be:	6a 07                	push   $0x7
  jmp alltraps
801085c0:	e9 4e f9 ff ff       	jmp    80107f13 <alltraps>

801085c5 <vector8>:
.globl vector8
vector8:
  pushl $8
801085c5:	6a 08                	push   $0x8
  jmp alltraps
801085c7:	e9 47 f9 ff ff       	jmp    80107f13 <alltraps>

801085cc <vector9>:
.globl vector9
vector9:
  pushl $0
801085cc:	6a 00                	push   $0x0
  pushl $9
801085ce:	6a 09                	push   $0x9
  jmp alltraps
801085d0:	e9 3e f9 ff ff       	jmp    80107f13 <alltraps>

801085d5 <vector10>:
.globl vector10
vector10:
  pushl $10
801085d5:	6a 0a                	push   $0xa
  jmp alltraps
801085d7:	e9 37 f9 ff ff       	jmp    80107f13 <alltraps>

801085dc <vector11>:
.globl vector11
vector11:
  pushl $11
801085dc:	6a 0b                	push   $0xb
  jmp alltraps
801085de:	e9 30 f9 ff ff       	jmp    80107f13 <alltraps>

801085e3 <vector12>:
.globl vector12
vector12:
  pushl $12
801085e3:	6a 0c                	push   $0xc
  jmp alltraps
801085e5:	e9 29 f9 ff ff       	jmp    80107f13 <alltraps>

801085ea <vector13>:
.globl vector13
vector13:
  pushl $13
801085ea:	6a 0d                	push   $0xd
  jmp alltraps
801085ec:	e9 22 f9 ff ff       	jmp    80107f13 <alltraps>

801085f1 <vector14>:
.globl vector14
vector14:
  pushl $14
801085f1:	6a 0e                	push   $0xe
  jmp alltraps
801085f3:	e9 1b f9 ff ff       	jmp    80107f13 <alltraps>

801085f8 <vector15>:
.globl vector15
vector15:
  pushl $0
801085f8:	6a 00                	push   $0x0
  pushl $15
801085fa:	6a 0f                	push   $0xf
  jmp alltraps
801085fc:	e9 12 f9 ff ff       	jmp    80107f13 <alltraps>

80108601 <vector16>:
.globl vector16
vector16:
  pushl $0
80108601:	6a 00                	push   $0x0
  pushl $16
80108603:	6a 10                	push   $0x10
  jmp alltraps
80108605:	e9 09 f9 ff ff       	jmp    80107f13 <alltraps>

8010860a <vector17>:
.globl vector17
vector17:
  pushl $17
8010860a:	6a 11                	push   $0x11
  jmp alltraps
8010860c:	e9 02 f9 ff ff       	jmp    80107f13 <alltraps>

80108611 <vector18>:
.globl vector18
vector18:
  pushl $0
80108611:	6a 00                	push   $0x0
  pushl $18
80108613:	6a 12                	push   $0x12
  jmp alltraps
80108615:	e9 f9 f8 ff ff       	jmp    80107f13 <alltraps>

8010861a <vector19>:
.globl vector19
vector19:
  pushl $0
8010861a:	6a 00                	push   $0x0
  pushl $19
8010861c:	6a 13                	push   $0x13
  jmp alltraps
8010861e:	e9 f0 f8 ff ff       	jmp    80107f13 <alltraps>

80108623 <vector20>:
.globl vector20
vector20:
  pushl $0
80108623:	6a 00                	push   $0x0
  pushl $20
80108625:	6a 14                	push   $0x14
  jmp alltraps
80108627:	e9 e7 f8 ff ff       	jmp    80107f13 <alltraps>

8010862c <vector21>:
.globl vector21
vector21:
  pushl $0
8010862c:	6a 00                	push   $0x0
  pushl $21
8010862e:	6a 15                	push   $0x15
  jmp alltraps
80108630:	e9 de f8 ff ff       	jmp    80107f13 <alltraps>

80108635 <vector22>:
.globl vector22
vector22:
  pushl $0
80108635:	6a 00                	push   $0x0
  pushl $22
80108637:	6a 16                	push   $0x16
  jmp alltraps
80108639:	e9 d5 f8 ff ff       	jmp    80107f13 <alltraps>

8010863e <vector23>:
.globl vector23
vector23:
  pushl $0
8010863e:	6a 00                	push   $0x0
  pushl $23
80108640:	6a 17                	push   $0x17
  jmp alltraps
80108642:	e9 cc f8 ff ff       	jmp    80107f13 <alltraps>

80108647 <vector24>:
.globl vector24
vector24:
  pushl $0
80108647:	6a 00                	push   $0x0
  pushl $24
80108649:	6a 18                	push   $0x18
  jmp alltraps
8010864b:	e9 c3 f8 ff ff       	jmp    80107f13 <alltraps>

80108650 <vector25>:
.globl vector25
vector25:
  pushl $0
80108650:	6a 00                	push   $0x0
  pushl $25
80108652:	6a 19                	push   $0x19
  jmp alltraps
80108654:	e9 ba f8 ff ff       	jmp    80107f13 <alltraps>

80108659 <vector26>:
.globl vector26
vector26:
  pushl $0
80108659:	6a 00                	push   $0x0
  pushl $26
8010865b:	6a 1a                	push   $0x1a
  jmp alltraps
8010865d:	e9 b1 f8 ff ff       	jmp    80107f13 <alltraps>

80108662 <vector27>:
.globl vector27
vector27:
  pushl $0
80108662:	6a 00                	push   $0x0
  pushl $27
80108664:	6a 1b                	push   $0x1b
  jmp alltraps
80108666:	e9 a8 f8 ff ff       	jmp    80107f13 <alltraps>

8010866b <vector28>:
.globl vector28
vector28:
  pushl $0
8010866b:	6a 00                	push   $0x0
  pushl $28
8010866d:	6a 1c                	push   $0x1c
  jmp alltraps
8010866f:	e9 9f f8 ff ff       	jmp    80107f13 <alltraps>

80108674 <vector29>:
.globl vector29
vector29:
  pushl $0
80108674:	6a 00                	push   $0x0
  pushl $29
80108676:	6a 1d                	push   $0x1d
  jmp alltraps
80108678:	e9 96 f8 ff ff       	jmp    80107f13 <alltraps>

8010867d <vector30>:
.globl vector30
vector30:
  pushl $0
8010867d:	6a 00                	push   $0x0
  pushl $30
8010867f:	6a 1e                	push   $0x1e
  jmp alltraps
80108681:	e9 8d f8 ff ff       	jmp    80107f13 <alltraps>

80108686 <vector31>:
.globl vector31
vector31:
  pushl $0
80108686:	6a 00                	push   $0x0
  pushl $31
80108688:	6a 1f                	push   $0x1f
  jmp alltraps
8010868a:	e9 84 f8 ff ff       	jmp    80107f13 <alltraps>

8010868f <vector32>:
.globl vector32
vector32:
  pushl $0
8010868f:	6a 00                	push   $0x0
  pushl $32
80108691:	6a 20                	push   $0x20
  jmp alltraps
80108693:	e9 7b f8 ff ff       	jmp    80107f13 <alltraps>

80108698 <vector33>:
.globl vector33
vector33:
  pushl $0
80108698:	6a 00                	push   $0x0
  pushl $33
8010869a:	6a 21                	push   $0x21
  jmp alltraps
8010869c:	e9 72 f8 ff ff       	jmp    80107f13 <alltraps>

801086a1 <vector34>:
.globl vector34
vector34:
  pushl $0
801086a1:	6a 00                	push   $0x0
  pushl $34
801086a3:	6a 22                	push   $0x22
  jmp alltraps
801086a5:	e9 69 f8 ff ff       	jmp    80107f13 <alltraps>

801086aa <vector35>:
.globl vector35
vector35:
  pushl $0
801086aa:	6a 00                	push   $0x0
  pushl $35
801086ac:	6a 23                	push   $0x23
  jmp alltraps
801086ae:	e9 60 f8 ff ff       	jmp    80107f13 <alltraps>

801086b3 <vector36>:
.globl vector36
vector36:
  pushl $0
801086b3:	6a 00                	push   $0x0
  pushl $36
801086b5:	6a 24                	push   $0x24
  jmp alltraps
801086b7:	e9 57 f8 ff ff       	jmp    80107f13 <alltraps>

801086bc <vector37>:
.globl vector37
vector37:
  pushl $0
801086bc:	6a 00                	push   $0x0
  pushl $37
801086be:	6a 25                	push   $0x25
  jmp alltraps
801086c0:	e9 4e f8 ff ff       	jmp    80107f13 <alltraps>

801086c5 <vector38>:
.globl vector38
vector38:
  pushl $0
801086c5:	6a 00                	push   $0x0
  pushl $38
801086c7:	6a 26                	push   $0x26
  jmp alltraps
801086c9:	e9 45 f8 ff ff       	jmp    80107f13 <alltraps>

801086ce <vector39>:
.globl vector39
vector39:
  pushl $0
801086ce:	6a 00                	push   $0x0
  pushl $39
801086d0:	6a 27                	push   $0x27
  jmp alltraps
801086d2:	e9 3c f8 ff ff       	jmp    80107f13 <alltraps>

801086d7 <vector40>:
.globl vector40
vector40:
  pushl $0
801086d7:	6a 00                	push   $0x0
  pushl $40
801086d9:	6a 28                	push   $0x28
  jmp alltraps
801086db:	e9 33 f8 ff ff       	jmp    80107f13 <alltraps>

801086e0 <vector41>:
.globl vector41
vector41:
  pushl $0
801086e0:	6a 00                	push   $0x0
  pushl $41
801086e2:	6a 29                	push   $0x29
  jmp alltraps
801086e4:	e9 2a f8 ff ff       	jmp    80107f13 <alltraps>

801086e9 <vector42>:
.globl vector42
vector42:
  pushl $0
801086e9:	6a 00                	push   $0x0
  pushl $42
801086eb:	6a 2a                	push   $0x2a
  jmp alltraps
801086ed:	e9 21 f8 ff ff       	jmp    80107f13 <alltraps>

801086f2 <vector43>:
.globl vector43
vector43:
  pushl $0
801086f2:	6a 00                	push   $0x0
  pushl $43
801086f4:	6a 2b                	push   $0x2b
  jmp alltraps
801086f6:	e9 18 f8 ff ff       	jmp    80107f13 <alltraps>

801086fb <vector44>:
.globl vector44
vector44:
  pushl $0
801086fb:	6a 00                	push   $0x0
  pushl $44
801086fd:	6a 2c                	push   $0x2c
  jmp alltraps
801086ff:	e9 0f f8 ff ff       	jmp    80107f13 <alltraps>

80108704 <vector45>:
.globl vector45
vector45:
  pushl $0
80108704:	6a 00                	push   $0x0
  pushl $45
80108706:	6a 2d                	push   $0x2d
  jmp alltraps
80108708:	e9 06 f8 ff ff       	jmp    80107f13 <alltraps>

8010870d <vector46>:
.globl vector46
vector46:
  pushl $0
8010870d:	6a 00                	push   $0x0
  pushl $46
8010870f:	6a 2e                	push   $0x2e
  jmp alltraps
80108711:	e9 fd f7 ff ff       	jmp    80107f13 <alltraps>

80108716 <vector47>:
.globl vector47
vector47:
  pushl $0
80108716:	6a 00                	push   $0x0
  pushl $47
80108718:	6a 2f                	push   $0x2f
  jmp alltraps
8010871a:	e9 f4 f7 ff ff       	jmp    80107f13 <alltraps>

8010871f <vector48>:
.globl vector48
vector48:
  pushl $0
8010871f:	6a 00                	push   $0x0
  pushl $48
80108721:	6a 30                	push   $0x30
  jmp alltraps
80108723:	e9 eb f7 ff ff       	jmp    80107f13 <alltraps>

80108728 <vector49>:
.globl vector49
vector49:
  pushl $0
80108728:	6a 00                	push   $0x0
  pushl $49
8010872a:	6a 31                	push   $0x31
  jmp alltraps
8010872c:	e9 e2 f7 ff ff       	jmp    80107f13 <alltraps>

80108731 <vector50>:
.globl vector50
vector50:
  pushl $0
80108731:	6a 00                	push   $0x0
  pushl $50
80108733:	6a 32                	push   $0x32
  jmp alltraps
80108735:	e9 d9 f7 ff ff       	jmp    80107f13 <alltraps>

8010873a <vector51>:
.globl vector51
vector51:
  pushl $0
8010873a:	6a 00                	push   $0x0
  pushl $51
8010873c:	6a 33                	push   $0x33
  jmp alltraps
8010873e:	e9 d0 f7 ff ff       	jmp    80107f13 <alltraps>

80108743 <vector52>:
.globl vector52
vector52:
  pushl $0
80108743:	6a 00                	push   $0x0
  pushl $52
80108745:	6a 34                	push   $0x34
  jmp alltraps
80108747:	e9 c7 f7 ff ff       	jmp    80107f13 <alltraps>

8010874c <vector53>:
.globl vector53
vector53:
  pushl $0
8010874c:	6a 00                	push   $0x0
  pushl $53
8010874e:	6a 35                	push   $0x35
  jmp alltraps
80108750:	e9 be f7 ff ff       	jmp    80107f13 <alltraps>

80108755 <vector54>:
.globl vector54
vector54:
  pushl $0
80108755:	6a 00                	push   $0x0
  pushl $54
80108757:	6a 36                	push   $0x36
  jmp alltraps
80108759:	e9 b5 f7 ff ff       	jmp    80107f13 <alltraps>

8010875e <vector55>:
.globl vector55
vector55:
  pushl $0
8010875e:	6a 00                	push   $0x0
  pushl $55
80108760:	6a 37                	push   $0x37
  jmp alltraps
80108762:	e9 ac f7 ff ff       	jmp    80107f13 <alltraps>

80108767 <vector56>:
.globl vector56
vector56:
  pushl $0
80108767:	6a 00                	push   $0x0
  pushl $56
80108769:	6a 38                	push   $0x38
  jmp alltraps
8010876b:	e9 a3 f7 ff ff       	jmp    80107f13 <alltraps>

80108770 <vector57>:
.globl vector57
vector57:
  pushl $0
80108770:	6a 00                	push   $0x0
  pushl $57
80108772:	6a 39                	push   $0x39
  jmp alltraps
80108774:	e9 9a f7 ff ff       	jmp    80107f13 <alltraps>

80108779 <vector58>:
.globl vector58
vector58:
  pushl $0
80108779:	6a 00                	push   $0x0
  pushl $58
8010877b:	6a 3a                	push   $0x3a
  jmp alltraps
8010877d:	e9 91 f7 ff ff       	jmp    80107f13 <alltraps>

80108782 <vector59>:
.globl vector59
vector59:
  pushl $0
80108782:	6a 00                	push   $0x0
  pushl $59
80108784:	6a 3b                	push   $0x3b
  jmp alltraps
80108786:	e9 88 f7 ff ff       	jmp    80107f13 <alltraps>

8010878b <vector60>:
.globl vector60
vector60:
  pushl $0
8010878b:	6a 00                	push   $0x0
  pushl $60
8010878d:	6a 3c                	push   $0x3c
  jmp alltraps
8010878f:	e9 7f f7 ff ff       	jmp    80107f13 <alltraps>

80108794 <vector61>:
.globl vector61
vector61:
  pushl $0
80108794:	6a 00                	push   $0x0
  pushl $61
80108796:	6a 3d                	push   $0x3d
  jmp alltraps
80108798:	e9 76 f7 ff ff       	jmp    80107f13 <alltraps>

8010879d <vector62>:
.globl vector62
vector62:
  pushl $0
8010879d:	6a 00                	push   $0x0
  pushl $62
8010879f:	6a 3e                	push   $0x3e
  jmp alltraps
801087a1:	e9 6d f7 ff ff       	jmp    80107f13 <alltraps>

801087a6 <vector63>:
.globl vector63
vector63:
  pushl $0
801087a6:	6a 00                	push   $0x0
  pushl $63
801087a8:	6a 3f                	push   $0x3f
  jmp alltraps
801087aa:	e9 64 f7 ff ff       	jmp    80107f13 <alltraps>

801087af <vector64>:
.globl vector64
vector64:
  pushl $0
801087af:	6a 00                	push   $0x0
  pushl $64
801087b1:	6a 40                	push   $0x40
  jmp alltraps
801087b3:	e9 5b f7 ff ff       	jmp    80107f13 <alltraps>

801087b8 <vector65>:
.globl vector65
vector65:
  pushl $0
801087b8:	6a 00                	push   $0x0
  pushl $65
801087ba:	6a 41                	push   $0x41
  jmp alltraps
801087bc:	e9 52 f7 ff ff       	jmp    80107f13 <alltraps>

801087c1 <vector66>:
.globl vector66
vector66:
  pushl $0
801087c1:	6a 00                	push   $0x0
  pushl $66
801087c3:	6a 42                	push   $0x42
  jmp alltraps
801087c5:	e9 49 f7 ff ff       	jmp    80107f13 <alltraps>

801087ca <vector67>:
.globl vector67
vector67:
  pushl $0
801087ca:	6a 00                	push   $0x0
  pushl $67
801087cc:	6a 43                	push   $0x43
  jmp alltraps
801087ce:	e9 40 f7 ff ff       	jmp    80107f13 <alltraps>

801087d3 <vector68>:
.globl vector68
vector68:
  pushl $0
801087d3:	6a 00                	push   $0x0
  pushl $68
801087d5:	6a 44                	push   $0x44
  jmp alltraps
801087d7:	e9 37 f7 ff ff       	jmp    80107f13 <alltraps>

801087dc <vector69>:
.globl vector69
vector69:
  pushl $0
801087dc:	6a 00                	push   $0x0
  pushl $69
801087de:	6a 45                	push   $0x45
  jmp alltraps
801087e0:	e9 2e f7 ff ff       	jmp    80107f13 <alltraps>

801087e5 <vector70>:
.globl vector70
vector70:
  pushl $0
801087e5:	6a 00                	push   $0x0
  pushl $70
801087e7:	6a 46                	push   $0x46
  jmp alltraps
801087e9:	e9 25 f7 ff ff       	jmp    80107f13 <alltraps>

801087ee <vector71>:
.globl vector71
vector71:
  pushl $0
801087ee:	6a 00                	push   $0x0
  pushl $71
801087f0:	6a 47                	push   $0x47
  jmp alltraps
801087f2:	e9 1c f7 ff ff       	jmp    80107f13 <alltraps>

801087f7 <vector72>:
.globl vector72
vector72:
  pushl $0
801087f7:	6a 00                	push   $0x0
  pushl $72
801087f9:	6a 48                	push   $0x48
  jmp alltraps
801087fb:	e9 13 f7 ff ff       	jmp    80107f13 <alltraps>

80108800 <vector73>:
.globl vector73
vector73:
  pushl $0
80108800:	6a 00                	push   $0x0
  pushl $73
80108802:	6a 49                	push   $0x49
  jmp alltraps
80108804:	e9 0a f7 ff ff       	jmp    80107f13 <alltraps>

80108809 <vector74>:
.globl vector74
vector74:
  pushl $0
80108809:	6a 00                	push   $0x0
  pushl $74
8010880b:	6a 4a                	push   $0x4a
  jmp alltraps
8010880d:	e9 01 f7 ff ff       	jmp    80107f13 <alltraps>

80108812 <vector75>:
.globl vector75
vector75:
  pushl $0
80108812:	6a 00                	push   $0x0
  pushl $75
80108814:	6a 4b                	push   $0x4b
  jmp alltraps
80108816:	e9 f8 f6 ff ff       	jmp    80107f13 <alltraps>

8010881b <vector76>:
.globl vector76
vector76:
  pushl $0
8010881b:	6a 00                	push   $0x0
  pushl $76
8010881d:	6a 4c                	push   $0x4c
  jmp alltraps
8010881f:	e9 ef f6 ff ff       	jmp    80107f13 <alltraps>

80108824 <vector77>:
.globl vector77
vector77:
  pushl $0
80108824:	6a 00                	push   $0x0
  pushl $77
80108826:	6a 4d                	push   $0x4d
  jmp alltraps
80108828:	e9 e6 f6 ff ff       	jmp    80107f13 <alltraps>

8010882d <vector78>:
.globl vector78
vector78:
  pushl $0
8010882d:	6a 00                	push   $0x0
  pushl $78
8010882f:	6a 4e                	push   $0x4e
  jmp alltraps
80108831:	e9 dd f6 ff ff       	jmp    80107f13 <alltraps>

80108836 <vector79>:
.globl vector79
vector79:
  pushl $0
80108836:	6a 00                	push   $0x0
  pushl $79
80108838:	6a 4f                	push   $0x4f
  jmp alltraps
8010883a:	e9 d4 f6 ff ff       	jmp    80107f13 <alltraps>

8010883f <vector80>:
.globl vector80
vector80:
  pushl $0
8010883f:	6a 00                	push   $0x0
  pushl $80
80108841:	6a 50                	push   $0x50
  jmp alltraps
80108843:	e9 cb f6 ff ff       	jmp    80107f13 <alltraps>

80108848 <vector81>:
.globl vector81
vector81:
  pushl $0
80108848:	6a 00                	push   $0x0
  pushl $81
8010884a:	6a 51                	push   $0x51
  jmp alltraps
8010884c:	e9 c2 f6 ff ff       	jmp    80107f13 <alltraps>

80108851 <vector82>:
.globl vector82
vector82:
  pushl $0
80108851:	6a 00                	push   $0x0
  pushl $82
80108853:	6a 52                	push   $0x52
  jmp alltraps
80108855:	e9 b9 f6 ff ff       	jmp    80107f13 <alltraps>

8010885a <vector83>:
.globl vector83
vector83:
  pushl $0
8010885a:	6a 00                	push   $0x0
  pushl $83
8010885c:	6a 53                	push   $0x53
  jmp alltraps
8010885e:	e9 b0 f6 ff ff       	jmp    80107f13 <alltraps>

80108863 <vector84>:
.globl vector84
vector84:
  pushl $0
80108863:	6a 00                	push   $0x0
  pushl $84
80108865:	6a 54                	push   $0x54
  jmp alltraps
80108867:	e9 a7 f6 ff ff       	jmp    80107f13 <alltraps>

8010886c <vector85>:
.globl vector85
vector85:
  pushl $0
8010886c:	6a 00                	push   $0x0
  pushl $85
8010886e:	6a 55                	push   $0x55
  jmp alltraps
80108870:	e9 9e f6 ff ff       	jmp    80107f13 <alltraps>

80108875 <vector86>:
.globl vector86
vector86:
  pushl $0
80108875:	6a 00                	push   $0x0
  pushl $86
80108877:	6a 56                	push   $0x56
  jmp alltraps
80108879:	e9 95 f6 ff ff       	jmp    80107f13 <alltraps>

8010887e <vector87>:
.globl vector87
vector87:
  pushl $0
8010887e:	6a 00                	push   $0x0
  pushl $87
80108880:	6a 57                	push   $0x57
  jmp alltraps
80108882:	e9 8c f6 ff ff       	jmp    80107f13 <alltraps>

80108887 <vector88>:
.globl vector88
vector88:
  pushl $0
80108887:	6a 00                	push   $0x0
  pushl $88
80108889:	6a 58                	push   $0x58
  jmp alltraps
8010888b:	e9 83 f6 ff ff       	jmp    80107f13 <alltraps>

80108890 <vector89>:
.globl vector89
vector89:
  pushl $0
80108890:	6a 00                	push   $0x0
  pushl $89
80108892:	6a 59                	push   $0x59
  jmp alltraps
80108894:	e9 7a f6 ff ff       	jmp    80107f13 <alltraps>

80108899 <vector90>:
.globl vector90
vector90:
  pushl $0
80108899:	6a 00                	push   $0x0
  pushl $90
8010889b:	6a 5a                	push   $0x5a
  jmp alltraps
8010889d:	e9 71 f6 ff ff       	jmp    80107f13 <alltraps>

801088a2 <vector91>:
.globl vector91
vector91:
  pushl $0
801088a2:	6a 00                	push   $0x0
  pushl $91
801088a4:	6a 5b                	push   $0x5b
  jmp alltraps
801088a6:	e9 68 f6 ff ff       	jmp    80107f13 <alltraps>

801088ab <vector92>:
.globl vector92
vector92:
  pushl $0
801088ab:	6a 00                	push   $0x0
  pushl $92
801088ad:	6a 5c                	push   $0x5c
  jmp alltraps
801088af:	e9 5f f6 ff ff       	jmp    80107f13 <alltraps>

801088b4 <vector93>:
.globl vector93
vector93:
  pushl $0
801088b4:	6a 00                	push   $0x0
  pushl $93
801088b6:	6a 5d                	push   $0x5d
  jmp alltraps
801088b8:	e9 56 f6 ff ff       	jmp    80107f13 <alltraps>

801088bd <vector94>:
.globl vector94
vector94:
  pushl $0
801088bd:	6a 00                	push   $0x0
  pushl $94
801088bf:	6a 5e                	push   $0x5e
  jmp alltraps
801088c1:	e9 4d f6 ff ff       	jmp    80107f13 <alltraps>

801088c6 <vector95>:
.globl vector95
vector95:
  pushl $0
801088c6:	6a 00                	push   $0x0
  pushl $95
801088c8:	6a 5f                	push   $0x5f
  jmp alltraps
801088ca:	e9 44 f6 ff ff       	jmp    80107f13 <alltraps>

801088cf <vector96>:
.globl vector96
vector96:
  pushl $0
801088cf:	6a 00                	push   $0x0
  pushl $96
801088d1:	6a 60                	push   $0x60
  jmp alltraps
801088d3:	e9 3b f6 ff ff       	jmp    80107f13 <alltraps>

801088d8 <vector97>:
.globl vector97
vector97:
  pushl $0
801088d8:	6a 00                	push   $0x0
  pushl $97
801088da:	6a 61                	push   $0x61
  jmp alltraps
801088dc:	e9 32 f6 ff ff       	jmp    80107f13 <alltraps>

801088e1 <vector98>:
.globl vector98
vector98:
  pushl $0
801088e1:	6a 00                	push   $0x0
  pushl $98
801088e3:	6a 62                	push   $0x62
  jmp alltraps
801088e5:	e9 29 f6 ff ff       	jmp    80107f13 <alltraps>

801088ea <vector99>:
.globl vector99
vector99:
  pushl $0
801088ea:	6a 00                	push   $0x0
  pushl $99
801088ec:	6a 63                	push   $0x63
  jmp alltraps
801088ee:	e9 20 f6 ff ff       	jmp    80107f13 <alltraps>

801088f3 <vector100>:
.globl vector100
vector100:
  pushl $0
801088f3:	6a 00                	push   $0x0
  pushl $100
801088f5:	6a 64                	push   $0x64
  jmp alltraps
801088f7:	e9 17 f6 ff ff       	jmp    80107f13 <alltraps>

801088fc <vector101>:
.globl vector101
vector101:
  pushl $0
801088fc:	6a 00                	push   $0x0
  pushl $101
801088fe:	6a 65                	push   $0x65
  jmp alltraps
80108900:	e9 0e f6 ff ff       	jmp    80107f13 <alltraps>

80108905 <vector102>:
.globl vector102
vector102:
  pushl $0
80108905:	6a 00                	push   $0x0
  pushl $102
80108907:	6a 66                	push   $0x66
  jmp alltraps
80108909:	e9 05 f6 ff ff       	jmp    80107f13 <alltraps>

8010890e <vector103>:
.globl vector103
vector103:
  pushl $0
8010890e:	6a 00                	push   $0x0
  pushl $103
80108910:	6a 67                	push   $0x67
  jmp alltraps
80108912:	e9 fc f5 ff ff       	jmp    80107f13 <alltraps>

80108917 <vector104>:
.globl vector104
vector104:
  pushl $0
80108917:	6a 00                	push   $0x0
  pushl $104
80108919:	6a 68                	push   $0x68
  jmp alltraps
8010891b:	e9 f3 f5 ff ff       	jmp    80107f13 <alltraps>

80108920 <vector105>:
.globl vector105
vector105:
  pushl $0
80108920:	6a 00                	push   $0x0
  pushl $105
80108922:	6a 69                	push   $0x69
  jmp alltraps
80108924:	e9 ea f5 ff ff       	jmp    80107f13 <alltraps>

80108929 <vector106>:
.globl vector106
vector106:
  pushl $0
80108929:	6a 00                	push   $0x0
  pushl $106
8010892b:	6a 6a                	push   $0x6a
  jmp alltraps
8010892d:	e9 e1 f5 ff ff       	jmp    80107f13 <alltraps>

80108932 <vector107>:
.globl vector107
vector107:
  pushl $0
80108932:	6a 00                	push   $0x0
  pushl $107
80108934:	6a 6b                	push   $0x6b
  jmp alltraps
80108936:	e9 d8 f5 ff ff       	jmp    80107f13 <alltraps>

8010893b <vector108>:
.globl vector108
vector108:
  pushl $0
8010893b:	6a 00                	push   $0x0
  pushl $108
8010893d:	6a 6c                	push   $0x6c
  jmp alltraps
8010893f:	e9 cf f5 ff ff       	jmp    80107f13 <alltraps>

80108944 <vector109>:
.globl vector109
vector109:
  pushl $0
80108944:	6a 00                	push   $0x0
  pushl $109
80108946:	6a 6d                	push   $0x6d
  jmp alltraps
80108948:	e9 c6 f5 ff ff       	jmp    80107f13 <alltraps>

8010894d <vector110>:
.globl vector110
vector110:
  pushl $0
8010894d:	6a 00                	push   $0x0
  pushl $110
8010894f:	6a 6e                	push   $0x6e
  jmp alltraps
80108951:	e9 bd f5 ff ff       	jmp    80107f13 <alltraps>

80108956 <vector111>:
.globl vector111
vector111:
  pushl $0
80108956:	6a 00                	push   $0x0
  pushl $111
80108958:	6a 6f                	push   $0x6f
  jmp alltraps
8010895a:	e9 b4 f5 ff ff       	jmp    80107f13 <alltraps>

8010895f <vector112>:
.globl vector112
vector112:
  pushl $0
8010895f:	6a 00                	push   $0x0
  pushl $112
80108961:	6a 70                	push   $0x70
  jmp alltraps
80108963:	e9 ab f5 ff ff       	jmp    80107f13 <alltraps>

80108968 <vector113>:
.globl vector113
vector113:
  pushl $0
80108968:	6a 00                	push   $0x0
  pushl $113
8010896a:	6a 71                	push   $0x71
  jmp alltraps
8010896c:	e9 a2 f5 ff ff       	jmp    80107f13 <alltraps>

80108971 <vector114>:
.globl vector114
vector114:
  pushl $0
80108971:	6a 00                	push   $0x0
  pushl $114
80108973:	6a 72                	push   $0x72
  jmp alltraps
80108975:	e9 99 f5 ff ff       	jmp    80107f13 <alltraps>

8010897a <vector115>:
.globl vector115
vector115:
  pushl $0
8010897a:	6a 00                	push   $0x0
  pushl $115
8010897c:	6a 73                	push   $0x73
  jmp alltraps
8010897e:	e9 90 f5 ff ff       	jmp    80107f13 <alltraps>

80108983 <vector116>:
.globl vector116
vector116:
  pushl $0
80108983:	6a 00                	push   $0x0
  pushl $116
80108985:	6a 74                	push   $0x74
  jmp alltraps
80108987:	e9 87 f5 ff ff       	jmp    80107f13 <alltraps>

8010898c <vector117>:
.globl vector117
vector117:
  pushl $0
8010898c:	6a 00                	push   $0x0
  pushl $117
8010898e:	6a 75                	push   $0x75
  jmp alltraps
80108990:	e9 7e f5 ff ff       	jmp    80107f13 <alltraps>

80108995 <vector118>:
.globl vector118
vector118:
  pushl $0
80108995:	6a 00                	push   $0x0
  pushl $118
80108997:	6a 76                	push   $0x76
  jmp alltraps
80108999:	e9 75 f5 ff ff       	jmp    80107f13 <alltraps>

8010899e <vector119>:
.globl vector119
vector119:
  pushl $0
8010899e:	6a 00                	push   $0x0
  pushl $119
801089a0:	6a 77                	push   $0x77
  jmp alltraps
801089a2:	e9 6c f5 ff ff       	jmp    80107f13 <alltraps>

801089a7 <vector120>:
.globl vector120
vector120:
  pushl $0
801089a7:	6a 00                	push   $0x0
  pushl $120
801089a9:	6a 78                	push   $0x78
  jmp alltraps
801089ab:	e9 63 f5 ff ff       	jmp    80107f13 <alltraps>

801089b0 <vector121>:
.globl vector121
vector121:
  pushl $0
801089b0:	6a 00                	push   $0x0
  pushl $121
801089b2:	6a 79                	push   $0x79
  jmp alltraps
801089b4:	e9 5a f5 ff ff       	jmp    80107f13 <alltraps>

801089b9 <vector122>:
.globl vector122
vector122:
  pushl $0
801089b9:	6a 00                	push   $0x0
  pushl $122
801089bb:	6a 7a                	push   $0x7a
  jmp alltraps
801089bd:	e9 51 f5 ff ff       	jmp    80107f13 <alltraps>

801089c2 <vector123>:
.globl vector123
vector123:
  pushl $0
801089c2:	6a 00                	push   $0x0
  pushl $123
801089c4:	6a 7b                	push   $0x7b
  jmp alltraps
801089c6:	e9 48 f5 ff ff       	jmp    80107f13 <alltraps>

801089cb <vector124>:
.globl vector124
vector124:
  pushl $0
801089cb:	6a 00                	push   $0x0
  pushl $124
801089cd:	6a 7c                	push   $0x7c
  jmp alltraps
801089cf:	e9 3f f5 ff ff       	jmp    80107f13 <alltraps>

801089d4 <vector125>:
.globl vector125
vector125:
  pushl $0
801089d4:	6a 00                	push   $0x0
  pushl $125
801089d6:	6a 7d                	push   $0x7d
  jmp alltraps
801089d8:	e9 36 f5 ff ff       	jmp    80107f13 <alltraps>

801089dd <vector126>:
.globl vector126
vector126:
  pushl $0
801089dd:	6a 00                	push   $0x0
  pushl $126
801089df:	6a 7e                	push   $0x7e
  jmp alltraps
801089e1:	e9 2d f5 ff ff       	jmp    80107f13 <alltraps>

801089e6 <vector127>:
.globl vector127
vector127:
  pushl $0
801089e6:	6a 00                	push   $0x0
  pushl $127
801089e8:	6a 7f                	push   $0x7f
  jmp alltraps
801089ea:	e9 24 f5 ff ff       	jmp    80107f13 <alltraps>

801089ef <vector128>:
.globl vector128
vector128:
  pushl $0
801089ef:	6a 00                	push   $0x0
  pushl $128
801089f1:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801089f6:	e9 18 f5 ff ff       	jmp    80107f13 <alltraps>

801089fb <vector129>:
.globl vector129
vector129:
  pushl $0
801089fb:	6a 00                	push   $0x0
  pushl $129
801089fd:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80108a02:	e9 0c f5 ff ff       	jmp    80107f13 <alltraps>

80108a07 <vector130>:
.globl vector130
vector130:
  pushl $0
80108a07:	6a 00                	push   $0x0
  pushl $130
80108a09:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80108a0e:	e9 00 f5 ff ff       	jmp    80107f13 <alltraps>

80108a13 <vector131>:
.globl vector131
vector131:
  pushl $0
80108a13:	6a 00                	push   $0x0
  pushl $131
80108a15:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80108a1a:	e9 f4 f4 ff ff       	jmp    80107f13 <alltraps>

80108a1f <vector132>:
.globl vector132
vector132:
  pushl $0
80108a1f:	6a 00                	push   $0x0
  pushl $132
80108a21:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80108a26:	e9 e8 f4 ff ff       	jmp    80107f13 <alltraps>

80108a2b <vector133>:
.globl vector133
vector133:
  pushl $0
80108a2b:	6a 00                	push   $0x0
  pushl $133
80108a2d:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80108a32:	e9 dc f4 ff ff       	jmp    80107f13 <alltraps>

80108a37 <vector134>:
.globl vector134
vector134:
  pushl $0
80108a37:	6a 00                	push   $0x0
  pushl $134
80108a39:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80108a3e:	e9 d0 f4 ff ff       	jmp    80107f13 <alltraps>

80108a43 <vector135>:
.globl vector135
vector135:
  pushl $0
80108a43:	6a 00                	push   $0x0
  pushl $135
80108a45:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80108a4a:	e9 c4 f4 ff ff       	jmp    80107f13 <alltraps>

80108a4f <vector136>:
.globl vector136
vector136:
  pushl $0
80108a4f:	6a 00                	push   $0x0
  pushl $136
80108a51:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80108a56:	e9 b8 f4 ff ff       	jmp    80107f13 <alltraps>

80108a5b <vector137>:
.globl vector137
vector137:
  pushl $0
80108a5b:	6a 00                	push   $0x0
  pushl $137
80108a5d:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80108a62:	e9 ac f4 ff ff       	jmp    80107f13 <alltraps>

80108a67 <vector138>:
.globl vector138
vector138:
  pushl $0
80108a67:	6a 00                	push   $0x0
  pushl $138
80108a69:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80108a6e:	e9 a0 f4 ff ff       	jmp    80107f13 <alltraps>

80108a73 <vector139>:
.globl vector139
vector139:
  pushl $0
80108a73:	6a 00                	push   $0x0
  pushl $139
80108a75:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80108a7a:	e9 94 f4 ff ff       	jmp    80107f13 <alltraps>

80108a7f <vector140>:
.globl vector140
vector140:
  pushl $0
80108a7f:	6a 00                	push   $0x0
  pushl $140
80108a81:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80108a86:	e9 88 f4 ff ff       	jmp    80107f13 <alltraps>

80108a8b <vector141>:
.globl vector141
vector141:
  pushl $0
80108a8b:	6a 00                	push   $0x0
  pushl $141
80108a8d:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80108a92:	e9 7c f4 ff ff       	jmp    80107f13 <alltraps>

80108a97 <vector142>:
.globl vector142
vector142:
  pushl $0
80108a97:	6a 00                	push   $0x0
  pushl $142
80108a99:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80108a9e:	e9 70 f4 ff ff       	jmp    80107f13 <alltraps>

80108aa3 <vector143>:
.globl vector143
vector143:
  pushl $0
80108aa3:	6a 00                	push   $0x0
  pushl $143
80108aa5:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80108aaa:	e9 64 f4 ff ff       	jmp    80107f13 <alltraps>

80108aaf <vector144>:
.globl vector144
vector144:
  pushl $0
80108aaf:	6a 00                	push   $0x0
  pushl $144
80108ab1:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80108ab6:	e9 58 f4 ff ff       	jmp    80107f13 <alltraps>

80108abb <vector145>:
.globl vector145
vector145:
  pushl $0
80108abb:	6a 00                	push   $0x0
  pushl $145
80108abd:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80108ac2:	e9 4c f4 ff ff       	jmp    80107f13 <alltraps>

80108ac7 <vector146>:
.globl vector146
vector146:
  pushl $0
80108ac7:	6a 00                	push   $0x0
  pushl $146
80108ac9:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80108ace:	e9 40 f4 ff ff       	jmp    80107f13 <alltraps>

80108ad3 <vector147>:
.globl vector147
vector147:
  pushl $0
80108ad3:	6a 00                	push   $0x0
  pushl $147
80108ad5:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80108ada:	e9 34 f4 ff ff       	jmp    80107f13 <alltraps>

80108adf <vector148>:
.globl vector148
vector148:
  pushl $0
80108adf:	6a 00                	push   $0x0
  pushl $148
80108ae1:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80108ae6:	e9 28 f4 ff ff       	jmp    80107f13 <alltraps>

80108aeb <vector149>:
.globl vector149
vector149:
  pushl $0
80108aeb:	6a 00                	push   $0x0
  pushl $149
80108aed:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80108af2:	e9 1c f4 ff ff       	jmp    80107f13 <alltraps>

80108af7 <vector150>:
.globl vector150
vector150:
  pushl $0
80108af7:	6a 00                	push   $0x0
  pushl $150
80108af9:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80108afe:	e9 10 f4 ff ff       	jmp    80107f13 <alltraps>

80108b03 <vector151>:
.globl vector151
vector151:
  pushl $0
80108b03:	6a 00                	push   $0x0
  pushl $151
80108b05:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80108b0a:	e9 04 f4 ff ff       	jmp    80107f13 <alltraps>

80108b0f <vector152>:
.globl vector152
vector152:
  pushl $0
80108b0f:	6a 00                	push   $0x0
  pushl $152
80108b11:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80108b16:	e9 f8 f3 ff ff       	jmp    80107f13 <alltraps>

80108b1b <vector153>:
.globl vector153
vector153:
  pushl $0
80108b1b:	6a 00                	push   $0x0
  pushl $153
80108b1d:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80108b22:	e9 ec f3 ff ff       	jmp    80107f13 <alltraps>

80108b27 <vector154>:
.globl vector154
vector154:
  pushl $0
80108b27:	6a 00                	push   $0x0
  pushl $154
80108b29:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80108b2e:	e9 e0 f3 ff ff       	jmp    80107f13 <alltraps>

80108b33 <vector155>:
.globl vector155
vector155:
  pushl $0
80108b33:	6a 00                	push   $0x0
  pushl $155
80108b35:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80108b3a:	e9 d4 f3 ff ff       	jmp    80107f13 <alltraps>

80108b3f <vector156>:
.globl vector156
vector156:
  pushl $0
80108b3f:	6a 00                	push   $0x0
  pushl $156
80108b41:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80108b46:	e9 c8 f3 ff ff       	jmp    80107f13 <alltraps>

80108b4b <vector157>:
.globl vector157
vector157:
  pushl $0
80108b4b:	6a 00                	push   $0x0
  pushl $157
80108b4d:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80108b52:	e9 bc f3 ff ff       	jmp    80107f13 <alltraps>

80108b57 <vector158>:
.globl vector158
vector158:
  pushl $0
80108b57:	6a 00                	push   $0x0
  pushl $158
80108b59:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80108b5e:	e9 b0 f3 ff ff       	jmp    80107f13 <alltraps>

80108b63 <vector159>:
.globl vector159
vector159:
  pushl $0
80108b63:	6a 00                	push   $0x0
  pushl $159
80108b65:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80108b6a:	e9 a4 f3 ff ff       	jmp    80107f13 <alltraps>

80108b6f <vector160>:
.globl vector160
vector160:
  pushl $0
80108b6f:	6a 00                	push   $0x0
  pushl $160
80108b71:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80108b76:	e9 98 f3 ff ff       	jmp    80107f13 <alltraps>

80108b7b <vector161>:
.globl vector161
vector161:
  pushl $0
80108b7b:	6a 00                	push   $0x0
  pushl $161
80108b7d:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80108b82:	e9 8c f3 ff ff       	jmp    80107f13 <alltraps>

80108b87 <vector162>:
.globl vector162
vector162:
  pushl $0
80108b87:	6a 00                	push   $0x0
  pushl $162
80108b89:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80108b8e:	e9 80 f3 ff ff       	jmp    80107f13 <alltraps>

80108b93 <vector163>:
.globl vector163
vector163:
  pushl $0
80108b93:	6a 00                	push   $0x0
  pushl $163
80108b95:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80108b9a:	e9 74 f3 ff ff       	jmp    80107f13 <alltraps>

80108b9f <vector164>:
.globl vector164
vector164:
  pushl $0
80108b9f:	6a 00                	push   $0x0
  pushl $164
80108ba1:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80108ba6:	e9 68 f3 ff ff       	jmp    80107f13 <alltraps>

80108bab <vector165>:
.globl vector165
vector165:
  pushl $0
80108bab:	6a 00                	push   $0x0
  pushl $165
80108bad:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80108bb2:	e9 5c f3 ff ff       	jmp    80107f13 <alltraps>

80108bb7 <vector166>:
.globl vector166
vector166:
  pushl $0
80108bb7:	6a 00                	push   $0x0
  pushl $166
80108bb9:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80108bbe:	e9 50 f3 ff ff       	jmp    80107f13 <alltraps>

80108bc3 <vector167>:
.globl vector167
vector167:
  pushl $0
80108bc3:	6a 00                	push   $0x0
  pushl $167
80108bc5:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80108bca:	e9 44 f3 ff ff       	jmp    80107f13 <alltraps>

80108bcf <vector168>:
.globl vector168
vector168:
  pushl $0
80108bcf:	6a 00                	push   $0x0
  pushl $168
80108bd1:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80108bd6:	e9 38 f3 ff ff       	jmp    80107f13 <alltraps>

80108bdb <vector169>:
.globl vector169
vector169:
  pushl $0
80108bdb:	6a 00                	push   $0x0
  pushl $169
80108bdd:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80108be2:	e9 2c f3 ff ff       	jmp    80107f13 <alltraps>

80108be7 <vector170>:
.globl vector170
vector170:
  pushl $0
80108be7:	6a 00                	push   $0x0
  pushl $170
80108be9:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80108bee:	e9 20 f3 ff ff       	jmp    80107f13 <alltraps>

80108bf3 <vector171>:
.globl vector171
vector171:
  pushl $0
80108bf3:	6a 00                	push   $0x0
  pushl $171
80108bf5:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80108bfa:	e9 14 f3 ff ff       	jmp    80107f13 <alltraps>

80108bff <vector172>:
.globl vector172
vector172:
  pushl $0
80108bff:	6a 00                	push   $0x0
  pushl $172
80108c01:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80108c06:	e9 08 f3 ff ff       	jmp    80107f13 <alltraps>

80108c0b <vector173>:
.globl vector173
vector173:
  pushl $0
80108c0b:	6a 00                	push   $0x0
  pushl $173
80108c0d:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80108c12:	e9 fc f2 ff ff       	jmp    80107f13 <alltraps>

80108c17 <vector174>:
.globl vector174
vector174:
  pushl $0
80108c17:	6a 00                	push   $0x0
  pushl $174
80108c19:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80108c1e:	e9 f0 f2 ff ff       	jmp    80107f13 <alltraps>

80108c23 <vector175>:
.globl vector175
vector175:
  pushl $0
80108c23:	6a 00                	push   $0x0
  pushl $175
80108c25:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80108c2a:	e9 e4 f2 ff ff       	jmp    80107f13 <alltraps>

80108c2f <vector176>:
.globl vector176
vector176:
  pushl $0
80108c2f:	6a 00                	push   $0x0
  pushl $176
80108c31:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80108c36:	e9 d8 f2 ff ff       	jmp    80107f13 <alltraps>

80108c3b <vector177>:
.globl vector177
vector177:
  pushl $0
80108c3b:	6a 00                	push   $0x0
  pushl $177
80108c3d:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80108c42:	e9 cc f2 ff ff       	jmp    80107f13 <alltraps>

80108c47 <vector178>:
.globl vector178
vector178:
  pushl $0
80108c47:	6a 00                	push   $0x0
  pushl $178
80108c49:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80108c4e:	e9 c0 f2 ff ff       	jmp    80107f13 <alltraps>

80108c53 <vector179>:
.globl vector179
vector179:
  pushl $0
80108c53:	6a 00                	push   $0x0
  pushl $179
80108c55:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80108c5a:	e9 b4 f2 ff ff       	jmp    80107f13 <alltraps>

80108c5f <vector180>:
.globl vector180
vector180:
  pushl $0
80108c5f:	6a 00                	push   $0x0
  pushl $180
80108c61:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80108c66:	e9 a8 f2 ff ff       	jmp    80107f13 <alltraps>

80108c6b <vector181>:
.globl vector181
vector181:
  pushl $0
80108c6b:	6a 00                	push   $0x0
  pushl $181
80108c6d:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80108c72:	e9 9c f2 ff ff       	jmp    80107f13 <alltraps>

80108c77 <vector182>:
.globl vector182
vector182:
  pushl $0
80108c77:	6a 00                	push   $0x0
  pushl $182
80108c79:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80108c7e:	e9 90 f2 ff ff       	jmp    80107f13 <alltraps>

80108c83 <vector183>:
.globl vector183
vector183:
  pushl $0
80108c83:	6a 00                	push   $0x0
  pushl $183
80108c85:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80108c8a:	e9 84 f2 ff ff       	jmp    80107f13 <alltraps>

80108c8f <vector184>:
.globl vector184
vector184:
  pushl $0
80108c8f:	6a 00                	push   $0x0
  pushl $184
80108c91:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80108c96:	e9 78 f2 ff ff       	jmp    80107f13 <alltraps>

80108c9b <vector185>:
.globl vector185
vector185:
  pushl $0
80108c9b:	6a 00                	push   $0x0
  pushl $185
80108c9d:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80108ca2:	e9 6c f2 ff ff       	jmp    80107f13 <alltraps>

80108ca7 <vector186>:
.globl vector186
vector186:
  pushl $0
80108ca7:	6a 00                	push   $0x0
  pushl $186
80108ca9:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80108cae:	e9 60 f2 ff ff       	jmp    80107f13 <alltraps>

80108cb3 <vector187>:
.globl vector187
vector187:
  pushl $0
80108cb3:	6a 00                	push   $0x0
  pushl $187
80108cb5:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80108cba:	e9 54 f2 ff ff       	jmp    80107f13 <alltraps>

80108cbf <vector188>:
.globl vector188
vector188:
  pushl $0
80108cbf:	6a 00                	push   $0x0
  pushl $188
80108cc1:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80108cc6:	e9 48 f2 ff ff       	jmp    80107f13 <alltraps>

80108ccb <vector189>:
.globl vector189
vector189:
  pushl $0
80108ccb:	6a 00                	push   $0x0
  pushl $189
80108ccd:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80108cd2:	e9 3c f2 ff ff       	jmp    80107f13 <alltraps>

80108cd7 <vector190>:
.globl vector190
vector190:
  pushl $0
80108cd7:	6a 00                	push   $0x0
  pushl $190
80108cd9:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80108cde:	e9 30 f2 ff ff       	jmp    80107f13 <alltraps>

80108ce3 <vector191>:
.globl vector191
vector191:
  pushl $0
80108ce3:	6a 00                	push   $0x0
  pushl $191
80108ce5:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80108cea:	e9 24 f2 ff ff       	jmp    80107f13 <alltraps>

80108cef <vector192>:
.globl vector192
vector192:
  pushl $0
80108cef:	6a 00                	push   $0x0
  pushl $192
80108cf1:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80108cf6:	e9 18 f2 ff ff       	jmp    80107f13 <alltraps>

80108cfb <vector193>:
.globl vector193
vector193:
  pushl $0
80108cfb:	6a 00                	push   $0x0
  pushl $193
80108cfd:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80108d02:	e9 0c f2 ff ff       	jmp    80107f13 <alltraps>

80108d07 <vector194>:
.globl vector194
vector194:
  pushl $0
80108d07:	6a 00                	push   $0x0
  pushl $194
80108d09:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80108d0e:	e9 00 f2 ff ff       	jmp    80107f13 <alltraps>

80108d13 <vector195>:
.globl vector195
vector195:
  pushl $0
80108d13:	6a 00                	push   $0x0
  pushl $195
80108d15:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80108d1a:	e9 f4 f1 ff ff       	jmp    80107f13 <alltraps>

80108d1f <vector196>:
.globl vector196
vector196:
  pushl $0
80108d1f:	6a 00                	push   $0x0
  pushl $196
80108d21:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80108d26:	e9 e8 f1 ff ff       	jmp    80107f13 <alltraps>

80108d2b <vector197>:
.globl vector197
vector197:
  pushl $0
80108d2b:	6a 00                	push   $0x0
  pushl $197
80108d2d:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80108d32:	e9 dc f1 ff ff       	jmp    80107f13 <alltraps>

80108d37 <vector198>:
.globl vector198
vector198:
  pushl $0
80108d37:	6a 00                	push   $0x0
  pushl $198
80108d39:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80108d3e:	e9 d0 f1 ff ff       	jmp    80107f13 <alltraps>

80108d43 <vector199>:
.globl vector199
vector199:
  pushl $0
80108d43:	6a 00                	push   $0x0
  pushl $199
80108d45:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80108d4a:	e9 c4 f1 ff ff       	jmp    80107f13 <alltraps>

80108d4f <vector200>:
.globl vector200
vector200:
  pushl $0
80108d4f:	6a 00                	push   $0x0
  pushl $200
80108d51:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80108d56:	e9 b8 f1 ff ff       	jmp    80107f13 <alltraps>

80108d5b <vector201>:
.globl vector201
vector201:
  pushl $0
80108d5b:	6a 00                	push   $0x0
  pushl $201
80108d5d:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80108d62:	e9 ac f1 ff ff       	jmp    80107f13 <alltraps>

80108d67 <vector202>:
.globl vector202
vector202:
  pushl $0
80108d67:	6a 00                	push   $0x0
  pushl $202
80108d69:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80108d6e:	e9 a0 f1 ff ff       	jmp    80107f13 <alltraps>

80108d73 <vector203>:
.globl vector203
vector203:
  pushl $0
80108d73:	6a 00                	push   $0x0
  pushl $203
80108d75:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80108d7a:	e9 94 f1 ff ff       	jmp    80107f13 <alltraps>

80108d7f <vector204>:
.globl vector204
vector204:
  pushl $0
80108d7f:	6a 00                	push   $0x0
  pushl $204
80108d81:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80108d86:	e9 88 f1 ff ff       	jmp    80107f13 <alltraps>

80108d8b <vector205>:
.globl vector205
vector205:
  pushl $0
80108d8b:	6a 00                	push   $0x0
  pushl $205
80108d8d:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80108d92:	e9 7c f1 ff ff       	jmp    80107f13 <alltraps>

80108d97 <vector206>:
.globl vector206
vector206:
  pushl $0
80108d97:	6a 00                	push   $0x0
  pushl $206
80108d99:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80108d9e:	e9 70 f1 ff ff       	jmp    80107f13 <alltraps>

80108da3 <vector207>:
.globl vector207
vector207:
  pushl $0
80108da3:	6a 00                	push   $0x0
  pushl $207
80108da5:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80108daa:	e9 64 f1 ff ff       	jmp    80107f13 <alltraps>

80108daf <vector208>:
.globl vector208
vector208:
  pushl $0
80108daf:	6a 00                	push   $0x0
  pushl $208
80108db1:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80108db6:	e9 58 f1 ff ff       	jmp    80107f13 <alltraps>

80108dbb <vector209>:
.globl vector209
vector209:
  pushl $0
80108dbb:	6a 00                	push   $0x0
  pushl $209
80108dbd:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80108dc2:	e9 4c f1 ff ff       	jmp    80107f13 <alltraps>

80108dc7 <vector210>:
.globl vector210
vector210:
  pushl $0
80108dc7:	6a 00                	push   $0x0
  pushl $210
80108dc9:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80108dce:	e9 40 f1 ff ff       	jmp    80107f13 <alltraps>

80108dd3 <vector211>:
.globl vector211
vector211:
  pushl $0
80108dd3:	6a 00                	push   $0x0
  pushl $211
80108dd5:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80108dda:	e9 34 f1 ff ff       	jmp    80107f13 <alltraps>

80108ddf <vector212>:
.globl vector212
vector212:
  pushl $0
80108ddf:	6a 00                	push   $0x0
  pushl $212
80108de1:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80108de6:	e9 28 f1 ff ff       	jmp    80107f13 <alltraps>

80108deb <vector213>:
.globl vector213
vector213:
  pushl $0
80108deb:	6a 00                	push   $0x0
  pushl $213
80108ded:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80108df2:	e9 1c f1 ff ff       	jmp    80107f13 <alltraps>

80108df7 <vector214>:
.globl vector214
vector214:
  pushl $0
80108df7:	6a 00                	push   $0x0
  pushl $214
80108df9:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80108dfe:	e9 10 f1 ff ff       	jmp    80107f13 <alltraps>

80108e03 <vector215>:
.globl vector215
vector215:
  pushl $0
80108e03:	6a 00                	push   $0x0
  pushl $215
80108e05:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80108e0a:	e9 04 f1 ff ff       	jmp    80107f13 <alltraps>

80108e0f <vector216>:
.globl vector216
vector216:
  pushl $0
80108e0f:	6a 00                	push   $0x0
  pushl $216
80108e11:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80108e16:	e9 f8 f0 ff ff       	jmp    80107f13 <alltraps>

80108e1b <vector217>:
.globl vector217
vector217:
  pushl $0
80108e1b:	6a 00                	push   $0x0
  pushl $217
80108e1d:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80108e22:	e9 ec f0 ff ff       	jmp    80107f13 <alltraps>

80108e27 <vector218>:
.globl vector218
vector218:
  pushl $0
80108e27:	6a 00                	push   $0x0
  pushl $218
80108e29:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80108e2e:	e9 e0 f0 ff ff       	jmp    80107f13 <alltraps>

80108e33 <vector219>:
.globl vector219
vector219:
  pushl $0
80108e33:	6a 00                	push   $0x0
  pushl $219
80108e35:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80108e3a:	e9 d4 f0 ff ff       	jmp    80107f13 <alltraps>

80108e3f <vector220>:
.globl vector220
vector220:
  pushl $0
80108e3f:	6a 00                	push   $0x0
  pushl $220
80108e41:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80108e46:	e9 c8 f0 ff ff       	jmp    80107f13 <alltraps>

80108e4b <vector221>:
.globl vector221
vector221:
  pushl $0
80108e4b:	6a 00                	push   $0x0
  pushl $221
80108e4d:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80108e52:	e9 bc f0 ff ff       	jmp    80107f13 <alltraps>

80108e57 <vector222>:
.globl vector222
vector222:
  pushl $0
80108e57:	6a 00                	push   $0x0
  pushl $222
80108e59:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80108e5e:	e9 b0 f0 ff ff       	jmp    80107f13 <alltraps>

80108e63 <vector223>:
.globl vector223
vector223:
  pushl $0
80108e63:	6a 00                	push   $0x0
  pushl $223
80108e65:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80108e6a:	e9 a4 f0 ff ff       	jmp    80107f13 <alltraps>

80108e6f <vector224>:
.globl vector224
vector224:
  pushl $0
80108e6f:	6a 00                	push   $0x0
  pushl $224
80108e71:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80108e76:	e9 98 f0 ff ff       	jmp    80107f13 <alltraps>

80108e7b <vector225>:
.globl vector225
vector225:
  pushl $0
80108e7b:	6a 00                	push   $0x0
  pushl $225
80108e7d:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80108e82:	e9 8c f0 ff ff       	jmp    80107f13 <alltraps>

80108e87 <vector226>:
.globl vector226
vector226:
  pushl $0
80108e87:	6a 00                	push   $0x0
  pushl $226
80108e89:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80108e8e:	e9 80 f0 ff ff       	jmp    80107f13 <alltraps>

80108e93 <vector227>:
.globl vector227
vector227:
  pushl $0
80108e93:	6a 00                	push   $0x0
  pushl $227
80108e95:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80108e9a:	e9 74 f0 ff ff       	jmp    80107f13 <alltraps>

80108e9f <vector228>:
.globl vector228
vector228:
  pushl $0
80108e9f:	6a 00                	push   $0x0
  pushl $228
80108ea1:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80108ea6:	e9 68 f0 ff ff       	jmp    80107f13 <alltraps>

80108eab <vector229>:
.globl vector229
vector229:
  pushl $0
80108eab:	6a 00                	push   $0x0
  pushl $229
80108ead:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80108eb2:	e9 5c f0 ff ff       	jmp    80107f13 <alltraps>

80108eb7 <vector230>:
.globl vector230
vector230:
  pushl $0
80108eb7:	6a 00                	push   $0x0
  pushl $230
80108eb9:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80108ebe:	e9 50 f0 ff ff       	jmp    80107f13 <alltraps>

80108ec3 <vector231>:
.globl vector231
vector231:
  pushl $0
80108ec3:	6a 00                	push   $0x0
  pushl $231
80108ec5:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80108eca:	e9 44 f0 ff ff       	jmp    80107f13 <alltraps>

80108ecf <vector232>:
.globl vector232
vector232:
  pushl $0
80108ecf:	6a 00                	push   $0x0
  pushl $232
80108ed1:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80108ed6:	e9 38 f0 ff ff       	jmp    80107f13 <alltraps>

80108edb <vector233>:
.globl vector233
vector233:
  pushl $0
80108edb:	6a 00                	push   $0x0
  pushl $233
80108edd:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80108ee2:	e9 2c f0 ff ff       	jmp    80107f13 <alltraps>

80108ee7 <vector234>:
.globl vector234
vector234:
  pushl $0
80108ee7:	6a 00                	push   $0x0
  pushl $234
80108ee9:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80108eee:	e9 20 f0 ff ff       	jmp    80107f13 <alltraps>

80108ef3 <vector235>:
.globl vector235
vector235:
  pushl $0
80108ef3:	6a 00                	push   $0x0
  pushl $235
80108ef5:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80108efa:	e9 14 f0 ff ff       	jmp    80107f13 <alltraps>

80108eff <vector236>:
.globl vector236
vector236:
  pushl $0
80108eff:	6a 00                	push   $0x0
  pushl $236
80108f01:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80108f06:	e9 08 f0 ff ff       	jmp    80107f13 <alltraps>

80108f0b <vector237>:
.globl vector237
vector237:
  pushl $0
80108f0b:	6a 00                	push   $0x0
  pushl $237
80108f0d:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80108f12:	e9 fc ef ff ff       	jmp    80107f13 <alltraps>

80108f17 <vector238>:
.globl vector238
vector238:
  pushl $0
80108f17:	6a 00                	push   $0x0
  pushl $238
80108f19:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80108f1e:	e9 f0 ef ff ff       	jmp    80107f13 <alltraps>

80108f23 <vector239>:
.globl vector239
vector239:
  pushl $0
80108f23:	6a 00                	push   $0x0
  pushl $239
80108f25:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80108f2a:	e9 e4 ef ff ff       	jmp    80107f13 <alltraps>

80108f2f <vector240>:
.globl vector240
vector240:
  pushl $0
80108f2f:	6a 00                	push   $0x0
  pushl $240
80108f31:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80108f36:	e9 d8 ef ff ff       	jmp    80107f13 <alltraps>

80108f3b <vector241>:
.globl vector241
vector241:
  pushl $0
80108f3b:	6a 00                	push   $0x0
  pushl $241
80108f3d:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80108f42:	e9 cc ef ff ff       	jmp    80107f13 <alltraps>

80108f47 <vector242>:
.globl vector242
vector242:
  pushl $0
80108f47:	6a 00                	push   $0x0
  pushl $242
80108f49:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80108f4e:	e9 c0 ef ff ff       	jmp    80107f13 <alltraps>

80108f53 <vector243>:
.globl vector243
vector243:
  pushl $0
80108f53:	6a 00                	push   $0x0
  pushl $243
80108f55:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80108f5a:	e9 b4 ef ff ff       	jmp    80107f13 <alltraps>

80108f5f <vector244>:
.globl vector244
vector244:
  pushl $0
80108f5f:	6a 00                	push   $0x0
  pushl $244
80108f61:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80108f66:	e9 a8 ef ff ff       	jmp    80107f13 <alltraps>

80108f6b <vector245>:
.globl vector245
vector245:
  pushl $0
80108f6b:	6a 00                	push   $0x0
  pushl $245
80108f6d:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80108f72:	e9 9c ef ff ff       	jmp    80107f13 <alltraps>

80108f77 <vector246>:
.globl vector246
vector246:
  pushl $0
80108f77:	6a 00                	push   $0x0
  pushl $246
80108f79:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80108f7e:	e9 90 ef ff ff       	jmp    80107f13 <alltraps>

80108f83 <vector247>:
.globl vector247
vector247:
  pushl $0
80108f83:	6a 00                	push   $0x0
  pushl $247
80108f85:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80108f8a:	e9 84 ef ff ff       	jmp    80107f13 <alltraps>

80108f8f <vector248>:
.globl vector248
vector248:
  pushl $0
80108f8f:	6a 00                	push   $0x0
  pushl $248
80108f91:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80108f96:	e9 78 ef ff ff       	jmp    80107f13 <alltraps>

80108f9b <vector249>:
.globl vector249
vector249:
  pushl $0
80108f9b:	6a 00                	push   $0x0
  pushl $249
80108f9d:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80108fa2:	e9 6c ef ff ff       	jmp    80107f13 <alltraps>

80108fa7 <vector250>:
.globl vector250
vector250:
  pushl $0
80108fa7:	6a 00                	push   $0x0
  pushl $250
80108fa9:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80108fae:	e9 60 ef ff ff       	jmp    80107f13 <alltraps>

80108fb3 <vector251>:
.globl vector251
vector251:
  pushl $0
80108fb3:	6a 00                	push   $0x0
  pushl $251
80108fb5:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80108fba:	e9 54 ef ff ff       	jmp    80107f13 <alltraps>

80108fbf <vector252>:
.globl vector252
vector252:
  pushl $0
80108fbf:	6a 00                	push   $0x0
  pushl $252
80108fc1:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80108fc6:	e9 48 ef ff ff       	jmp    80107f13 <alltraps>

80108fcb <vector253>:
.globl vector253
vector253:
  pushl $0
80108fcb:	6a 00                	push   $0x0
  pushl $253
80108fcd:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80108fd2:	e9 3c ef ff ff       	jmp    80107f13 <alltraps>

80108fd7 <vector254>:
.globl vector254
vector254:
  pushl $0
80108fd7:	6a 00                	push   $0x0
  pushl $254
80108fd9:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80108fde:	e9 30 ef ff ff       	jmp    80107f13 <alltraps>

80108fe3 <vector255>:
.globl vector255
vector255:
  pushl $0
80108fe3:	6a 00                	push   $0x0
  pushl $255
80108fe5:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80108fea:	e9 24 ef ff ff       	jmp    80107f13 <alltraps>

80108fef <atoi>:
#include "types.h"
#include "util.h"

int
atoi(const char *s)
{
80108fef:	55                   	push   %ebp
80108ff0:	89 e5                	mov    %esp,%ebp
80108ff2:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
80108ff5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
80108ffc:	eb 25                	jmp    80109023 <atoi+0x34>
    n = n*10 + *s++ - '0';
80108ffe:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109001:	89 d0                	mov    %edx,%eax
80109003:	c1 e0 02             	shl    $0x2,%eax
80109006:	01 d0                	add    %edx,%eax
80109008:	01 c0                	add    %eax,%eax
8010900a:	89 c1                	mov    %eax,%ecx
8010900c:	8b 45 08             	mov    0x8(%ebp),%eax
8010900f:	8d 50 01             	lea    0x1(%eax),%edx
80109012:	89 55 08             	mov    %edx,0x8(%ebp)
80109015:	0f b6 00             	movzbl (%eax),%eax
80109018:	0f be c0             	movsbl %al,%eax
8010901b:	01 c8                	add    %ecx,%eax
8010901d:	83 e8 30             	sub    $0x30,%eax
80109020:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
80109023:	8b 45 08             	mov    0x8(%ebp),%eax
80109026:	0f b6 00             	movzbl (%eax),%eax
80109029:	3c 2f                	cmp    $0x2f,%al
8010902b:	7e 0a                	jle    80109037 <atoi+0x48>
8010902d:	8b 45 08             	mov    0x8(%ebp),%eax
80109030:	0f b6 00             	movzbl (%eax),%eax
80109033:	3c 39                	cmp    $0x39,%al
80109035:	7e c7                	jle    80108ffe <atoi+0xf>
  return n;
80109037:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010903a:	c9                   	leave  
8010903b:	c3                   	ret    

8010903c <lgdt>:
{
8010903c:	55                   	push   %ebp
8010903d:	89 e5                	mov    %esp,%ebp
8010903f:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
80109042:	8b 45 0c             	mov    0xc(%ebp),%eax
80109045:	83 e8 01             	sub    $0x1,%eax
80109048:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010904c:	8b 45 08             	mov    0x8(%ebp),%eax
8010904f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80109053:	8b 45 08             	mov    0x8(%ebp),%eax
80109056:	c1 e8 10             	shr    $0x10,%eax
80109059:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010905d:	8d 45 fa             	lea    -0x6(%ebp),%eax
80109060:	0f 01 10             	lgdtl  (%eax)
}
80109063:	90                   	nop
80109064:	c9                   	leave  
80109065:	c3                   	ret    

80109066 <ltr>:
{
80109066:	55                   	push   %ebp
80109067:	89 e5                	mov    %esp,%ebp
80109069:	83 ec 04             	sub    $0x4,%esp
8010906c:	8b 45 08             	mov    0x8(%ebp),%eax
8010906f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80109073:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80109077:	0f 00 d8             	ltr    %ax
}
8010907a:	90                   	nop
8010907b:	c9                   	leave  
8010907c:	c3                   	ret    

8010907d <loadgs>:
{
8010907d:	55                   	push   %ebp
8010907e:	89 e5                	mov    %esp,%ebp
80109080:	83 ec 04             	sub    $0x4,%esp
80109083:	8b 45 08             	mov    0x8(%ebp),%eax
80109086:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
8010908a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010908e:	8e e8                	mov    %eax,%gs
}
80109090:	90                   	nop
80109091:	c9                   	leave  
80109092:	c3                   	ret    

80109093 <lcr3>:

static inline void
lcr3(uint val)
{
80109093:	55                   	push   %ebp
80109094:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80109096:	8b 45 08             	mov    0x8(%ebp),%eax
80109099:	0f 22 d8             	mov    %eax,%cr3
}
8010909c:	90                   	nop
8010909d:	5d                   	pop    %ebp
8010909e:	c3                   	ret    

8010909f <tlb_invalidate>:
extern char data[];  // defined by kernel.ld
pde_t *kpgdir;  // for use in scheduler()

void
tlb_invalidate(pde_t *pgdir, void *va)
{
8010909f:	55                   	push   %ebp
801090a0:	89 e5                	mov    %esp,%ebp


}
801090a2:	90                   	nop
801090a3:	5d                   	pop    %ebp
801090a4:	c3                   	ret    

801090a5 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801090a5:	55                   	push   %ebp
801090a6:	89 e5                	mov    %esp,%ebp
801090a8:	53                   	push   %ebx
801090a9:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801090ac:	e8 33 ad ff ff       	call   80103de4 <cpunum>
801090b1:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801090b7:	05 e0 12 13 80       	add    $0x801312e0,%eax
801090bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801090bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090c2:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801090c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090cb:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801090d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090d4:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801090d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090db:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801090df:	83 e2 f0             	and    $0xfffffff0,%edx
801090e2:	83 ca 0a             	or     $0xa,%edx
801090e5:	88 50 7d             	mov    %dl,0x7d(%eax)
801090e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090eb:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801090ef:	83 ca 10             	or     $0x10,%edx
801090f2:	88 50 7d             	mov    %dl,0x7d(%eax)
801090f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090f8:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801090fc:	83 e2 9f             	and    $0xffffff9f,%edx
801090ff:	88 50 7d             	mov    %dl,0x7d(%eax)
80109102:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109105:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80109109:	83 ca 80             	or     $0xffffff80,%edx
8010910c:	88 50 7d             	mov    %dl,0x7d(%eax)
8010910f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109112:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80109116:	83 ca 0f             	or     $0xf,%edx
80109119:	88 50 7e             	mov    %dl,0x7e(%eax)
8010911c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010911f:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80109123:	83 e2 ef             	and    $0xffffffef,%edx
80109126:	88 50 7e             	mov    %dl,0x7e(%eax)
80109129:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010912c:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80109130:	83 e2 df             	and    $0xffffffdf,%edx
80109133:	88 50 7e             	mov    %dl,0x7e(%eax)
80109136:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109139:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010913d:	83 ca 40             	or     $0x40,%edx
80109140:	88 50 7e             	mov    %dl,0x7e(%eax)
80109143:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109146:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010914a:	83 ca 80             	or     $0xffffff80,%edx
8010914d:	88 50 7e             	mov    %dl,0x7e(%eax)
80109150:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109153:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80109157:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010915a:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80109161:	ff ff 
80109163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109166:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
8010916d:	00 00 
8010916f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109172:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80109179:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010917c:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80109183:	83 e2 f0             	and    $0xfffffff0,%edx
80109186:	83 ca 02             	or     $0x2,%edx
80109189:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010918f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109192:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80109199:	83 ca 10             	or     $0x10,%edx
8010919c:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801091a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091a5:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801091ac:	83 e2 9f             	and    $0xffffff9f,%edx
801091af:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801091b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091b8:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801091bf:	83 ca 80             	or     $0xffffff80,%edx
801091c2:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801091c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091cb:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801091d2:	83 ca 0f             	or     $0xf,%edx
801091d5:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801091db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091de:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801091e5:	83 e2 ef             	and    $0xffffffef,%edx
801091e8:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801091ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091f1:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801091f8:	83 e2 df             	and    $0xffffffdf,%edx
801091fb:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80109201:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109204:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010920b:	83 ca 40             	or     $0x40,%edx
8010920e:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80109214:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109217:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010921e:	83 ca 80             	or     $0xffffff80,%edx
80109221:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80109227:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010922a:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80109231:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109234:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
8010923b:	ff ff 
8010923d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109240:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80109247:	00 00 
80109249:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010924c:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80109253:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109256:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
8010925d:	83 e2 f0             	and    $0xfffffff0,%edx
80109260:	83 ca 0a             	or     $0xa,%edx
80109263:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80109269:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010926c:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80109273:	83 ca 10             	or     $0x10,%edx
80109276:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010927c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010927f:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80109286:	83 ca 60             	or     $0x60,%edx
80109289:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010928f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109292:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80109299:	83 ca 80             	or     $0xffffff80,%edx
8010929c:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801092a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092a5:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801092ac:	83 ca 0f             	or     $0xf,%edx
801092af:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801092b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092b8:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801092bf:	83 e2 ef             	and    $0xffffffef,%edx
801092c2:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801092c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092cb:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801092d2:	83 e2 df             	and    $0xffffffdf,%edx
801092d5:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801092db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092de:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801092e5:	83 ca 40             	or     $0x40,%edx
801092e8:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801092ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801092f1:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801092f8:	83 ca 80             	or     $0xffffff80,%edx
801092fb:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80109301:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109304:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010930b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010930e:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80109315:	ff ff 
80109317:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010931a:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80109321:	00 00 
80109323:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109326:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
8010932d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109330:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80109337:	83 e2 f0             	and    $0xfffffff0,%edx
8010933a:	83 ca 02             	or     $0x2,%edx
8010933d:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80109343:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109346:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010934d:	83 ca 10             	or     $0x10,%edx
80109350:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80109356:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109359:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80109360:	83 ca 60             	or     $0x60,%edx
80109363:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80109369:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010936c:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80109373:	83 ca 80             	or     $0xffffff80,%edx
80109376:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010937c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010937f:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80109386:	83 ca 0f             	or     $0xf,%edx
80109389:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
8010938f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109392:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80109399:	83 e2 ef             	and    $0xffffffef,%edx
8010939c:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801093a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093a5:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801093ac:	83 e2 df             	and    $0xffffffdf,%edx
801093af:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801093b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093b8:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801093bf:	83 ca 40             	or     $0x40,%edx
801093c2:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801093c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093cb:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801093d2:	83 ca 80             	or     $0xffffff80,%edx
801093d5:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801093db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093de:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801093e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093e8:	05 b4 00 00 00       	add    $0xb4,%eax
801093ed:	89 c3                	mov    %eax,%ebx
801093ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093f2:	05 b4 00 00 00       	add    $0xb4,%eax
801093f7:	c1 e8 10             	shr    $0x10,%eax
801093fa:	89 c2                	mov    %eax,%edx
801093fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093ff:	05 b4 00 00 00       	add    $0xb4,%eax
80109404:	c1 e8 18             	shr    $0x18,%eax
80109407:	89 c1                	mov    %eax,%ecx
80109409:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010940c:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80109413:	00 00 
80109415:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109418:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
8010941f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109422:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80109428:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010942b:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80109432:	83 e2 f0             	and    $0xfffffff0,%edx
80109435:	83 ca 02             	or     $0x2,%edx
80109438:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010943e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109441:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80109448:	83 ca 10             	or     $0x10,%edx
8010944b:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80109451:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109454:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010945b:	83 e2 9f             	and    $0xffffff9f,%edx
8010945e:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80109464:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109467:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010946e:	83 ca 80             	or     $0xffffff80,%edx
80109471:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80109477:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010947a:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80109481:	83 e2 f0             	and    $0xfffffff0,%edx
80109484:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010948a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010948d:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80109494:	83 e2 ef             	and    $0xffffffef,%edx
80109497:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010949d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801094a0:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801094a7:	83 e2 df             	and    $0xffffffdf,%edx
801094aa:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801094b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801094b3:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801094ba:	83 ca 40             	or     $0x40,%edx
801094bd:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801094c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801094c6:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801094cd:	83 ca 80             	or     $0xffffff80,%edx
801094d0:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801094d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801094d9:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
801094df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801094e2:	83 c0 70             	add    $0x70,%eax
801094e5:	83 ec 08             	sub    $0x8,%esp
801094e8:	6a 38                	push   $0x38
801094ea:	50                   	push   %eax
801094eb:	e8 4c fb ff ff       	call   8010903c <lgdt>
801094f0:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
801094f3:	83 ec 0c             	sub    $0xc,%esp
801094f6:	6a 18                	push   $0x18
801094f8:	e8 80 fb ff ff       	call   8010907d <loadgs>
801094fd:	83 c4 10             	add    $0x10,%esp

  // Initialize cpu-local storage.
  cpu = c;
80109500:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109503:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80109509:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80109510:	00 00 00 00 
}
80109514:	90                   	nop
80109515:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109518:	c9                   	leave  
80109519:	c3                   	ret    

8010951a <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010951a:	55                   	push   %ebp
8010951b:	89 e5                	mov    %esp,%ebp
8010951d:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80109520:	8b 45 0c             	mov    0xc(%ebp),%eax
80109523:	c1 e8 16             	shr    $0x16,%eax
80109526:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010952d:	8b 45 08             	mov    0x8(%ebp),%eax
80109530:	01 d0                	add    %edx,%eax
80109532:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80109535:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109538:	8b 00                	mov    (%eax),%eax
8010953a:	83 e0 01             	and    $0x1,%eax
8010953d:	85 c0                	test   %eax,%eax
8010953f:	74 14                	je     80109555 <walkpgdir+0x3b>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80109541:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109544:	8b 00                	mov    (%eax),%eax
80109546:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010954b:	05 00 00 00 80       	add    $0x80000000,%eax
80109550:	89 45 f4             	mov    %eax,-0xc(%ebp)
80109553:	eb 42                	jmp    80109597 <walkpgdir+0x7d>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80109555:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80109559:	74 0e                	je     80109569 <walkpgdir+0x4f>
8010955b:	e8 1e a5 ff ff       	call   80103a7e <kalloc>
80109560:	89 45 f4             	mov    %eax,-0xc(%ebp)
80109563:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80109567:	75 07                	jne    80109570 <walkpgdir+0x56>
      return 0;
80109569:	b8 00 00 00 00       	mov    $0x0,%eax
8010956e:	eb 3e                	jmp    801095ae <walkpgdir+0x94>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80109570:	83 ec 04             	sub    $0x4,%esp
80109573:	68 00 10 00 00       	push   $0x1000
80109578:	6a 00                	push   $0x0
8010957a:	ff 75 f4             	pushl  -0xc(%ebp)
8010957d:	e8 b1 d2 ff ff       	call   80106833 <memset>
80109582:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80109585:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109588:	05 00 00 00 80       	add    $0x80000000,%eax
8010958d:	83 c8 07             	or     $0x7,%eax
80109590:	89 c2                	mov    %eax,%edx
80109592:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109595:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80109597:	8b 45 0c             	mov    0xc(%ebp),%eax
8010959a:	c1 e8 0c             	shr    $0xc,%eax
8010959d:	25 ff 03 00 00       	and    $0x3ff,%eax
801095a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801095a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801095ac:	01 d0                	add    %edx,%eax
}
801095ae:	c9                   	leave  
801095af:	c3                   	ret    

801095b0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801095b0:	55                   	push   %ebp
801095b1:	89 e5                	mov    %esp,%ebp
801095b3:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801095b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801095b9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801095be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801095c1:	8b 55 0c             	mov    0xc(%ebp),%edx
801095c4:	8b 45 10             	mov    0x10(%ebp),%eax
801095c7:	01 d0                	add    %edx,%eax
801095c9:	83 e8 01             	sub    $0x1,%eax
801095cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801095d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801095d4:	83 ec 04             	sub    $0x4,%esp
801095d7:	6a 01                	push   $0x1
801095d9:	ff 75 f4             	pushl  -0xc(%ebp)
801095dc:	ff 75 08             	pushl  0x8(%ebp)
801095df:	e8 36 ff ff ff       	call   8010951a <walkpgdir>
801095e4:	83 c4 10             	add    $0x10,%esp
801095e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
801095ea:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801095ee:	75 07                	jne    801095f7 <mappages+0x47>
      return -1;
801095f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801095f5:	eb 47                	jmp    8010963e <mappages+0x8e>
    if(*pte & PTE_P)
801095f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801095fa:	8b 00                	mov    (%eax),%eax
801095fc:	83 e0 01             	and    $0x1,%eax
801095ff:	85 c0                	test   %eax,%eax
80109601:	74 0d                	je     80109610 <mappages+0x60>
      panic("remap");
80109603:	83 ec 0c             	sub    $0xc,%esp
80109606:	68 28 bb 10 80       	push   $0x8010bb28
8010960b:	e8 2e 78 ff ff       	call   80100e3e <panic>
    *pte = pa | perm | PTE_P;
80109610:	8b 45 18             	mov    0x18(%ebp),%eax
80109613:	0b 45 14             	or     0x14(%ebp),%eax
80109616:	83 c8 01             	or     $0x1,%eax
80109619:	89 c2                	mov    %eax,%edx
8010961b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010961e:	89 10                	mov    %edx,(%eax)
    if(a == last)
80109620:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109623:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80109626:	74 10                	je     80109638 <mappages+0x88>
      break;
    a += PGSIZE;
80109628:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
8010962f:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80109636:	eb 9c                	jmp    801095d4 <mappages+0x24>
      break;
80109638:	90                   	nop
  }
  return 0;
80109639:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010963e:	c9                   	leave  
8010963f:	c3                   	ret    

80109640 <mmio_map_region>:
// have to be multiple of PGSIZE. This space is directly mapped, 
// so no allocation or freeing needs to be done.
//
void *
mmio_map_region(uint pa, uint size)
{
80109640:	55                   	push   %ebp
80109641:	89 e5                	mov    %esp,%ebp
  return NULL;
80109643:	b8 00 00 00 00       	mov    $0x0,%eax
}
80109648:	5d                   	pop    %ebp
80109649:	c3                   	ret    

8010964a <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
8010964a:	55                   	push   %ebp
8010964b:	89 e5                	mov    %esp,%ebp
8010964d:	53                   	push   %ebx
8010964e:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80109651:	e8 28 a4 ff ff       	call   80103a7e <kalloc>
80109656:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109659:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010965d:	75 07                	jne    80109666 <setupkvm+0x1c>
    return 0;
8010965f:	b8 00 00 00 00       	mov    $0x0,%eax
80109664:	eb 6a                	jmp    801096d0 <setupkvm+0x86>
  memset(pgdir, 0, PGSIZE);
80109666:	83 ec 04             	sub    $0x4,%esp
80109669:	68 00 10 00 00       	push   $0x1000
8010966e:	6a 00                	push   $0x0
80109670:	ff 75 f0             	pushl  -0x10(%ebp)
80109673:	e8 bb d1 ff ff       	call   80106833 <memset>
80109678:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010967b:	c7 45 f4 00 95 12 80 	movl   $0x80129500,-0xc(%ebp)
80109682:	eb 40                	jmp    801096c4 <setupkvm+0x7a>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80109684:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109687:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
8010968a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010968d:	8b 50 04             	mov    0x4(%eax),%edx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80109690:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109693:	8b 58 08             	mov    0x8(%eax),%ebx
80109696:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109699:	8b 40 04             	mov    0x4(%eax),%eax
8010969c:	29 c3                	sub    %eax,%ebx
8010969e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801096a1:	8b 00                	mov    (%eax),%eax
801096a3:	83 ec 0c             	sub    $0xc,%esp
801096a6:	51                   	push   %ecx
801096a7:	52                   	push   %edx
801096a8:	53                   	push   %ebx
801096a9:	50                   	push   %eax
801096aa:	ff 75 f0             	pushl  -0x10(%ebp)
801096ad:	e8 fe fe ff ff       	call   801095b0 <mappages>
801096b2:	83 c4 20             	add    $0x20,%esp
801096b5:	85 c0                	test   %eax,%eax
801096b7:	79 07                	jns    801096c0 <setupkvm+0x76>
      return 0;
801096b9:	b8 00 00 00 00       	mov    $0x0,%eax
801096be:	eb 10                	jmp    801096d0 <setupkvm+0x86>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801096c0:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801096c4:	81 7d f4 40 95 12 80 	cmpl   $0x80129540,-0xc(%ebp)
801096cb:	72 b7                	jb     80109684 <setupkvm+0x3a>
  return pgdir;
801096cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801096d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801096d3:	c9                   	leave  
801096d4:	c3                   	ret    

801096d5 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
801096d5:	55                   	push   %ebp
801096d6:	89 e5                	mov    %esp,%ebp
801096d8:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801096db:	e8 6a ff ff ff       	call   8010964a <setupkvm>
801096e0:	a3 64 4e 13 80       	mov    %eax,0x80134e64
  switchkvm();
801096e5:	e8 03 00 00 00       	call   801096ed <switchkvm>
}
801096ea:	90                   	nop
801096eb:	c9                   	leave  
801096ec:	c3                   	ret    

801096ed <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
801096ed:	55                   	push   %ebp
801096ee:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801096f0:	a1 64 4e 13 80       	mov    0x80134e64,%eax
801096f5:	05 00 00 00 80       	add    $0x80000000,%eax
801096fa:	50                   	push   %eax
801096fb:	e8 93 f9 ff ff       	call   80109093 <lcr3>
80109700:	83 c4 04             	add    $0x4,%esp
}
80109703:	90                   	nop
80109704:	c9                   	leave  
80109705:	c3                   	ret    

80109706 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80109706:	55                   	push   %ebp
80109707:	89 e5                	mov    %esp,%ebp
80109709:	56                   	push   %esi
8010970a:	53                   	push   %ebx
  pushcli();
8010970b:	e8 0c d0 ff ff       	call   8010671c <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80109710:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80109716:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010971d:	83 c2 08             	add    $0x8,%edx
80109720:	89 d6                	mov    %edx,%esi
80109722:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80109729:	83 c2 08             	add    $0x8,%edx
8010972c:	c1 ea 10             	shr    $0x10,%edx
8010972f:	89 d3                	mov    %edx,%ebx
80109731:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80109738:	83 c2 08             	add    $0x8,%edx
8010973b:	c1 ea 18             	shr    $0x18,%edx
8010973e:	89 d1                	mov    %edx,%ecx
80109740:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80109747:	67 00 
80109749:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80109750:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80109756:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010975d:	83 e2 f0             	and    $0xfffffff0,%edx
80109760:	83 ca 09             	or     $0x9,%edx
80109763:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80109769:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80109770:	83 ca 10             	or     $0x10,%edx
80109773:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80109779:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80109780:	83 e2 9f             	and    $0xffffff9f,%edx
80109783:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80109789:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80109790:	83 ca 80             	or     $0xffffff80,%edx
80109793:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80109799:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801097a0:	83 e2 f0             	and    $0xfffffff0,%edx
801097a3:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801097a9:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801097b0:	83 e2 ef             	and    $0xffffffef,%edx
801097b3:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801097b9:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801097c0:	83 e2 df             	and    $0xffffffdf,%edx
801097c3:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801097c9:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801097d0:	83 ca 40             	or     $0x40,%edx
801097d3:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801097d9:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801097e0:	83 e2 7f             	and    $0x7f,%edx
801097e3:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801097e9:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
801097ef:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801097f5:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801097fc:	83 e2 ef             	and    $0xffffffef,%edx
801097ff:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80109805:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010980b:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80109811:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80109817:	8b 40 08             	mov    0x8(%eax),%eax
8010981a:	89 c2                	mov    %eax,%edx
8010981c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80109822:	81 c2 00 10 00 00    	add    $0x1000,%edx
80109828:	89 50 0c             	mov    %edx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
8010982b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80109831:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  ltr(SEG_TSS << 3);
80109837:	83 ec 0c             	sub    $0xc,%esp
8010983a:	6a 30                	push   $0x30
8010983c:	e8 25 f8 ff ff       	call   80109066 <ltr>
80109841:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80109844:	8b 45 08             	mov    0x8(%ebp),%eax
80109847:	8b 40 04             	mov    0x4(%eax),%eax
8010984a:	85 c0                	test   %eax,%eax
8010984c:	75 0d                	jne    8010985b <switchuvm+0x155>
    panic("switchuvm: no pgdir");
8010984e:	83 ec 0c             	sub    $0xc,%esp
80109851:	68 2e bb 10 80       	push   $0x8010bb2e
80109856:	e8 e3 75 ff ff       	call   80100e3e <panic>
  lcr3(V2P(p->pgdir));  // switch to process's address space
8010985b:	8b 45 08             	mov    0x8(%ebp),%eax
8010985e:	8b 40 04             	mov    0x4(%eax),%eax
80109861:	05 00 00 00 80       	add    $0x80000000,%eax
80109866:	83 ec 0c             	sub    $0xc,%esp
80109869:	50                   	push   %eax
8010986a:	e8 24 f8 ff ff       	call   80109093 <lcr3>
8010986f:	83 c4 10             	add    $0x10,%esp
  popcli();
80109872:	e8 fb ce ff ff       	call   80106772 <popcli>
}
80109877:	90                   	nop
80109878:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010987b:	5b                   	pop    %ebx
8010987c:	5e                   	pop    %esi
8010987d:	5d                   	pop    %ebp
8010987e:	c3                   	ret    

8010987f <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010987f:	55                   	push   %ebp
80109880:	89 e5                	mov    %esp,%ebp
80109882:	83 ec 18             	sub    $0x18,%esp
  char *mem;

  if(sz >= PGSIZE)
80109885:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
8010988c:	76 0d                	jbe    8010989b <inituvm+0x1c>
    panic("inituvm: more than a page");
8010988e:	83 ec 0c             	sub    $0xc,%esp
80109891:	68 42 bb 10 80       	push   $0x8010bb42
80109896:	e8 a3 75 ff ff       	call   80100e3e <panic>
  mem = kalloc();
8010989b:	e8 de a1 ff ff       	call   80103a7e <kalloc>
801098a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
801098a3:	83 ec 04             	sub    $0x4,%esp
801098a6:	68 00 10 00 00       	push   $0x1000
801098ab:	6a 00                	push   $0x0
801098ad:	ff 75 f4             	pushl  -0xc(%ebp)
801098b0:	e8 7e cf ff ff       	call   80106833 <memset>
801098b5:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801098b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801098bb:	05 00 00 00 80       	add    $0x80000000,%eax
801098c0:	83 ec 0c             	sub    $0xc,%esp
801098c3:	6a 06                	push   $0x6
801098c5:	50                   	push   %eax
801098c6:	68 00 10 00 00       	push   $0x1000
801098cb:	6a 00                	push   $0x0
801098cd:	ff 75 08             	pushl  0x8(%ebp)
801098d0:	e8 db fc ff ff       	call   801095b0 <mappages>
801098d5:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
801098d8:	83 ec 04             	sub    $0x4,%esp
801098db:	ff 75 10             	pushl  0x10(%ebp)
801098de:	ff 75 0c             	pushl  0xc(%ebp)
801098e1:	ff 75 f4             	pushl  -0xc(%ebp)
801098e4:	e8 09 d0 ff ff       	call   801068f2 <memmove>
801098e9:	83 c4 10             	add    $0x10,%esp
}
801098ec:	90                   	nop
801098ed:	c9                   	leave  
801098ee:	c3                   	ret    

801098ef <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801098ef:	55                   	push   %ebp
801098f0:	89 e5                	mov    %esp,%ebp
801098f2:	83 ec 18             	sub    $0x18,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801098f5:	8b 45 0c             	mov    0xc(%ebp),%eax
801098f8:	25 ff 0f 00 00       	and    $0xfff,%eax
801098fd:	85 c0                	test   %eax,%eax
801098ff:	74 0d                	je     8010990e <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
80109901:	83 ec 0c             	sub    $0xc,%esp
80109904:	68 5c bb 10 80       	push   $0x8010bb5c
80109909:	e8 30 75 ff ff       	call   80100e3e <panic>
  for(i = 0; i < sz; i += PGSIZE){
8010990e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109915:	e9 8f 00 00 00       	jmp    801099a9 <loaduvm+0xba>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010991a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010991d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109920:	01 d0                	add    %edx,%eax
80109922:	83 ec 04             	sub    $0x4,%esp
80109925:	6a 00                	push   $0x0
80109927:	50                   	push   %eax
80109928:	ff 75 08             	pushl  0x8(%ebp)
8010992b:	e8 ea fb ff ff       	call   8010951a <walkpgdir>
80109930:	83 c4 10             	add    $0x10,%esp
80109933:	89 45 ec             	mov    %eax,-0x14(%ebp)
80109936:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010993a:	75 0d                	jne    80109949 <loaduvm+0x5a>
      panic("loaduvm: address should exist");
8010993c:	83 ec 0c             	sub    $0xc,%esp
8010993f:	68 7f bb 10 80       	push   $0x8010bb7f
80109944:	e8 f5 74 ff ff       	call   80100e3e <panic>
    pa = PTE_ADDR(*pte);
80109949:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010994c:	8b 00                	mov    (%eax),%eax
8010994e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109953:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80109956:	8b 45 18             	mov    0x18(%ebp),%eax
80109959:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010995c:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80109961:	77 0b                	ja     8010996e <loaduvm+0x7f>
      n = sz - i;
80109963:	8b 45 18             	mov    0x18(%ebp),%eax
80109966:	2b 45 f4             	sub    -0xc(%ebp),%eax
80109969:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010996c:	eb 07                	jmp    80109975 <loaduvm+0x86>
    else
      n = PGSIZE;
8010996e:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80109975:	8b 55 14             	mov    0x14(%ebp),%edx
80109978:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010997b:	01 d0                	add    %edx,%eax
8010997d:	8b 55 e8             	mov    -0x18(%ebp),%edx
80109980:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80109986:	ff 75 f0             	pushl  -0x10(%ebp)
80109989:	50                   	push   %eax
8010998a:	52                   	push   %edx
8010998b:	ff 75 10             	pushl  0x10(%ebp)
8010998e:	e8 f7 90 ff ff       	call   80102a8a <readi>
80109993:	83 c4 10             	add    $0x10,%esp
80109996:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80109999:	74 07                	je     801099a2 <loaduvm+0xb3>
      return -1;
8010999b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801099a0:	eb 18                	jmp    801099ba <loaduvm+0xcb>
  for(i = 0; i < sz; i += PGSIZE){
801099a2:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801099a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801099ac:	3b 45 18             	cmp    0x18(%ebp),%eax
801099af:	0f 82 65 ff ff ff    	jb     8010991a <loaduvm+0x2b>
  }
  return 0;
801099b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
801099ba:	c9                   	leave  
801099bb:	c3                   	ret    

801099bc <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801099bc:	55                   	push   %ebp
801099bd:	89 e5                	mov    %esp,%ebp
801099bf:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
801099c2:	8b 45 10             	mov    0x10(%ebp),%eax
801099c5:	85 c0                	test   %eax,%eax
801099c7:	79 0a                	jns    801099d3 <allocuvm+0x17>
    return 0;
801099c9:	b8 00 00 00 00       	mov    $0x0,%eax
801099ce:	e9 ec 00 00 00       	jmp    80109abf <allocuvm+0x103>
  if(newsz < oldsz)
801099d3:	8b 45 10             	mov    0x10(%ebp),%eax
801099d6:	3b 45 0c             	cmp    0xc(%ebp),%eax
801099d9:	73 08                	jae    801099e3 <allocuvm+0x27>
    return oldsz;
801099db:	8b 45 0c             	mov    0xc(%ebp),%eax
801099de:	e9 dc 00 00 00       	jmp    80109abf <allocuvm+0x103>

  a = PGROUNDUP(oldsz);
801099e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801099e6:	05 ff 0f 00 00       	add    $0xfff,%eax
801099eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801099f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
801099f3:	e9 b8 00 00 00       	jmp    80109ab0 <allocuvm+0xf4>
    mem = kalloc();
801099f8:	e8 81 a0 ff ff       	call   80103a7e <kalloc>
801099fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80109a00:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80109a04:	75 2e                	jne    80109a34 <allocuvm+0x78>
      cprintf("allocuvm out of memory\n");
80109a06:	83 ec 0c             	sub    $0xc,%esp
80109a09:	68 9d bb 10 80       	push   $0x8010bb9d
80109a0e:	e8 05 74 ff ff       	call   80100e18 <cprintf>
80109a13:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80109a16:	83 ec 04             	sub    $0x4,%esp
80109a19:	ff 75 0c             	pushl  0xc(%ebp)
80109a1c:	ff 75 10             	pushl  0x10(%ebp)
80109a1f:	ff 75 08             	pushl  0x8(%ebp)
80109a22:	e8 9a 00 00 00       	call   80109ac1 <deallocuvm>
80109a27:	83 c4 10             	add    $0x10,%esp
      return 0;
80109a2a:	b8 00 00 00 00       	mov    $0x0,%eax
80109a2f:	e9 8b 00 00 00       	jmp    80109abf <allocuvm+0x103>
    }
    memset(mem, 0, PGSIZE);
80109a34:	83 ec 04             	sub    $0x4,%esp
80109a37:	68 00 10 00 00       	push   $0x1000
80109a3c:	6a 00                	push   $0x0
80109a3e:	ff 75 f0             	pushl  -0x10(%ebp)
80109a41:	e8 ed cd ff ff       	call   80106833 <memset>
80109a46:	83 c4 10             	add    $0x10,%esp
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80109a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109a4c:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80109a52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a55:	83 ec 0c             	sub    $0xc,%esp
80109a58:	6a 06                	push   $0x6
80109a5a:	52                   	push   %edx
80109a5b:	68 00 10 00 00       	push   $0x1000
80109a60:	50                   	push   %eax
80109a61:	ff 75 08             	pushl  0x8(%ebp)
80109a64:	e8 47 fb ff ff       	call   801095b0 <mappages>
80109a69:	83 c4 20             	add    $0x20,%esp
80109a6c:	85 c0                	test   %eax,%eax
80109a6e:	79 39                	jns    80109aa9 <allocuvm+0xed>
      cprintf("allocuvm out of memory (2)\n");
80109a70:	83 ec 0c             	sub    $0xc,%esp
80109a73:	68 b5 bb 10 80       	push   $0x8010bbb5
80109a78:	e8 9b 73 ff ff       	call   80100e18 <cprintf>
80109a7d:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80109a80:	83 ec 04             	sub    $0x4,%esp
80109a83:	ff 75 0c             	pushl  0xc(%ebp)
80109a86:	ff 75 10             	pushl  0x10(%ebp)
80109a89:	ff 75 08             	pushl  0x8(%ebp)
80109a8c:	e8 30 00 00 00       	call   80109ac1 <deallocuvm>
80109a91:	83 c4 10             	add    $0x10,%esp
      kfree(mem);
80109a94:	83 ec 0c             	sub    $0xc,%esp
80109a97:	ff 75 f0             	pushl  -0x10(%ebp)
80109a9a:	e8 5a 9f ff ff       	call   801039f9 <kfree>
80109a9f:	83 c4 10             	add    $0x10,%esp
      return 0;
80109aa2:	b8 00 00 00 00       	mov    $0x0,%eax
80109aa7:	eb 16                	jmp    80109abf <allocuvm+0x103>
  for(; a < newsz; a += PGSIZE){
80109aa9:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80109ab0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109ab3:	3b 45 10             	cmp    0x10(%ebp),%eax
80109ab6:	0f 82 3c ff ff ff    	jb     801099f8 <allocuvm+0x3c>
    }
  }
  return newsz;
80109abc:	8b 45 10             	mov    0x10(%ebp),%eax
}
80109abf:	c9                   	leave  
80109ac0:	c3                   	ret    

80109ac1 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80109ac1:	55                   	push   %ebp
80109ac2:	89 e5                	mov    %esp,%ebp
80109ac4:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80109ac7:	8b 45 10             	mov    0x10(%ebp),%eax
80109aca:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109acd:	72 08                	jb     80109ad7 <deallocuvm+0x16>
    return oldsz;
80109acf:	8b 45 0c             	mov    0xc(%ebp),%eax
80109ad2:	e9 9c 00 00 00       	jmp    80109b73 <deallocuvm+0xb2>

  a = PGROUNDUP(newsz);
80109ad7:	8b 45 10             	mov    0x10(%ebp),%eax
80109ada:	05 ff 0f 00 00       	add    $0xfff,%eax
80109adf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109ae4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80109ae7:	eb 7b                	jmp    80109b64 <deallocuvm+0xa3>
    pte = walkpgdir(pgdir, (char*)a, 0);
80109ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109aec:	83 ec 04             	sub    $0x4,%esp
80109aef:	6a 00                	push   $0x0
80109af1:	50                   	push   %eax
80109af2:	ff 75 08             	pushl  0x8(%ebp)
80109af5:	e8 20 fa ff ff       	call   8010951a <walkpgdir>
80109afa:	83 c4 10             	add    $0x10,%esp
80109afd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80109b00:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80109b04:	75 09                	jne    80109b0f <deallocuvm+0x4e>
      a += (NPTENTRIES - 1) * PGSIZE;
80109b06:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80109b0d:	eb 4e                	jmp    80109b5d <deallocuvm+0x9c>
    else if((*pte & PTE_P) != 0){
80109b0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109b12:	8b 00                	mov    (%eax),%eax
80109b14:	83 e0 01             	and    $0x1,%eax
80109b17:	85 c0                	test   %eax,%eax
80109b19:	74 42                	je     80109b5d <deallocuvm+0x9c>
      pa = PTE_ADDR(*pte);
80109b1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109b1e:	8b 00                	mov    (%eax),%eax
80109b20:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109b25:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
80109b28:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80109b2c:	75 0d                	jne    80109b3b <deallocuvm+0x7a>
        panic("kfree");
80109b2e:	83 ec 0c             	sub    $0xc,%esp
80109b31:	68 d1 bb 10 80       	push   $0x8010bbd1
80109b36:	e8 03 73 ff ff       	call   80100e3e <panic>
      char *v = P2V(pa);
80109b3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109b3e:	05 00 00 00 80       	add    $0x80000000,%eax
80109b43:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80109b46:	83 ec 0c             	sub    $0xc,%esp
80109b49:	ff 75 e8             	pushl  -0x18(%ebp)
80109b4c:	e8 a8 9e ff ff       	call   801039f9 <kfree>
80109b51:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80109b54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109b57:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80109b5d:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80109b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109b67:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109b6a:	0f 82 79 ff ff ff    	jb     80109ae9 <deallocuvm+0x28>
    }
  }
  return newsz;
80109b70:	8b 45 10             	mov    0x10(%ebp),%eax
}
80109b73:	c9                   	leave  
80109b74:	c3                   	ret    

80109b75 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80109b75:	55                   	push   %ebp
80109b76:	89 e5                	mov    %esp,%ebp
80109b78:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80109b7b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80109b7f:	75 0d                	jne    80109b8e <freevm+0x19>
    panic("freevm: no pgdir");
80109b81:	83 ec 0c             	sub    $0xc,%esp
80109b84:	68 d7 bb 10 80       	push   $0x8010bbd7
80109b89:	e8 b0 72 ff ff       	call   80100e3e <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80109b8e:	83 ec 04             	sub    $0x4,%esp
80109b91:	6a 00                	push   $0x0
80109b93:	68 00 00 00 80       	push   $0x80000000
80109b98:	ff 75 08             	pushl  0x8(%ebp)
80109b9b:	e8 21 ff ff ff       	call   80109ac1 <deallocuvm>
80109ba0:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80109ba3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109baa:	eb 48                	jmp    80109bf4 <freevm+0x7f>
    if(pgdir[i] & PTE_P){
80109bac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109baf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80109bb6:	8b 45 08             	mov    0x8(%ebp),%eax
80109bb9:	01 d0                	add    %edx,%eax
80109bbb:	8b 00                	mov    (%eax),%eax
80109bbd:	83 e0 01             	and    $0x1,%eax
80109bc0:	85 c0                	test   %eax,%eax
80109bc2:	74 2c                	je     80109bf0 <freevm+0x7b>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80109bc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109bc7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80109bce:	8b 45 08             	mov    0x8(%ebp),%eax
80109bd1:	01 d0                	add    %edx,%eax
80109bd3:	8b 00                	mov    (%eax),%eax
80109bd5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109bda:	05 00 00 00 80       	add    $0x80000000,%eax
80109bdf:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80109be2:	83 ec 0c             	sub    $0xc,%esp
80109be5:	ff 75 f0             	pushl  -0x10(%ebp)
80109be8:	e8 0c 9e ff ff       	call   801039f9 <kfree>
80109bed:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80109bf0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80109bf4:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80109bfb:	76 af                	jbe    80109bac <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80109bfd:	83 ec 0c             	sub    $0xc,%esp
80109c00:	ff 75 08             	pushl  0x8(%ebp)
80109c03:	e8 f1 9d ff ff       	call   801039f9 <kfree>
80109c08:	83 c4 10             	add    $0x10,%esp
}
80109c0b:	90                   	nop
80109c0c:	c9                   	leave  
80109c0d:	c3                   	ret    

80109c0e <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80109c0e:	55                   	push   %ebp
80109c0f:	89 e5                	mov    %esp,%ebp
80109c11:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80109c14:	83 ec 04             	sub    $0x4,%esp
80109c17:	6a 00                	push   $0x0
80109c19:	ff 75 0c             	pushl  0xc(%ebp)
80109c1c:	ff 75 08             	pushl  0x8(%ebp)
80109c1f:	e8 f6 f8 ff ff       	call   8010951a <walkpgdir>
80109c24:	83 c4 10             	add    $0x10,%esp
80109c27:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80109c2a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80109c2e:	75 0d                	jne    80109c3d <clearpteu+0x2f>
    panic("clearpteu");
80109c30:	83 ec 0c             	sub    $0xc,%esp
80109c33:	68 e8 bb 10 80       	push   $0x8010bbe8
80109c38:	e8 01 72 ff ff       	call   80100e3e <panic>
  *pte &= ~PTE_U;
80109c3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109c40:	8b 00                	mov    (%eax),%eax
80109c42:	83 e0 fb             	and    $0xfffffffb,%eax
80109c45:	89 c2                	mov    %eax,%edx
80109c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109c4a:	89 10                	mov    %edx,(%eax)
}
80109c4c:	90                   	nop
80109c4d:	c9                   	leave  
80109c4e:	c3                   	ret    

80109c4f <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80109c4f:	55                   	push   %ebp
80109c50:	89 e5                	mov    %esp,%ebp
80109c52:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80109c55:	e8 f0 f9 ff ff       	call   8010964a <setupkvm>
80109c5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109c5d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80109c61:	75 0a                	jne    80109c6d <copyuvm+0x1e>
    return 0;
80109c63:	b8 00 00 00 00       	mov    $0x0,%eax
80109c68:	e9 eb 00 00 00       	jmp    80109d58 <copyuvm+0x109>
  for(i = 0; i < sz; i += PGSIZE){
80109c6d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109c74:	e9 b7 00 00 00       	jmp    80109d30 <copyuvm+0xe1>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80109c79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109c7c:	83 ec 04             	sub    $0x4,%esp
80109c7f:	6a 00                	push   $0x0
80109c81:	50                   	push   %eax
80109c82:	ff 75 08             	pushl  0x8(%ebp)
80109c85:	e8 90 f8 ff ff       	call   8010951a <walkpgdir>
80109c8a:	83 c4 10             	add    $0x10,%esp
80109c8d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80109c90:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80109c94:	75 0d                	jne    80109ca3 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
80109c96:	83 ec 0c             	sub    $0xc,%esp
80109c99:	68 f2 bb 10 80       	push   $0x8010bbf2
80109c9e:	e8 9b 71 ff ff       	call   80100e3e <panic>
    if(!(*pte & PTE_P))
80109ca3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109ca6:	8b 00                	mov    (%eax),%eax
80109ca8:	83 e0 01             	and    $0x1,%eax
80109cab:	85 c0                	test   %eax,%eax
80109cad:	75 0d                	jne    80109cbc <copyuvm+0x6d>
      panic("copyuvm: page not present");
80109caf:	83 ec 0c             	sub    $0xc,%esp
80109cb2:	68 0c bc 10 80       	push   $0x8010bc0c
80109cb7:	e8 82 71 ff ff       	call   80100e3e <panic>
    pa = PTE_ADDR(*pte);
80109cbc:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109cbf:	8b 00                	mov    (%eax),%eax
80109cc1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109cc6:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80109cc9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109ccc:	8b 00                	mov    (%eax),%eax
80109cce:	25 ff 0f 00 00       	and    $0xfff,%eax
80109cd3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80109cd6:	e8 a3 9d ff ff       	call   80103a7e <kalloc>
80109cdb:	89 45 e0             	mov    %eax,-0x20(%ebp)
80109cde:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80109ce2:	74 5d                	je     80109d41 <copyuvm+0xf2>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80109ce4:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109ce7:	05 00 00 00 80       	add    $0x80000000,%eax
80109cec:	83 ec 04             	sub    $0x4,%esp
80109cef:	68 00 10 00 00       	push   $0x1000
80109cf4:	50                   	push   %eax
80109cf5:	ff 75 e0             	pushl  -0x20(%ebp)
80109cf8:	e8 f5 cb ff ff       	call   801068f2 <memmove>
80109cfd:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80109d00:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80109d03:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109d06:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80109d0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d0f:	83 ec 0c             	sub    $0xc,%esp
80109d12:	52                   	push   %edx
80109d13:	51                   	push   %ecx
80109d14:	68 00 10 00 00       	push   $0x1000
80109d19:	50                   	push   %eax
80109d1a:	ff 75 f0             	pushl  -0x10(%ebp)
80109d1d:	e8 8e f8 ff ff       	call   801095b0 <mappages>
80109d22:	83 c4 20             	add    $0x20,%esp
80109d25:	85 c0                	test   %eax,%eax
80109d27:	78 1b                	js     80109d44 <copyuvm+0xf5>
  for(i = 0; i < sz; i += PGSIZE){
80109d29:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80109d30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d33:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109d36:	0f 82 3d ff ff ff    	jb     80109c79 <copyuvm+0x2a>
      goto bad;
  }
  return d;
80109d3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109d3f:	eb 17                	jmp    80109d58 <copyuvm+0x109>
      goto bad;
80109d41:	90                   	nop
80109d42:	eb 01                	jmp    80109d45 <copyuvm+0xf6>
      goto bad;
80109d44:	90                   	nop

bad:
  freevm(d);
80109d45:	83 ec 0c             	sub    $0xc,%esp
80109d48:	ff 75 f0             	pushl  -0x10(%ebp)
80109d4b:	e8 25 fe ff ff       	call   80109b75 <freevm>
80109d50:	83 c4 10             	add    $0x10,%esp
  return 0;
80109d53:	b8 00 00 00 00       	mov    $0x0,%eax
}
80109d58:	c9                   	leave  
80109d59:	c3                   	ret    

80109d5a <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80109d5a:	55                   	push   %ebp
80109d5b:	89 e5                	mov    %esp,%ebp
80109d5d:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80109d60:	83 ec 04             	sub    $0x4,%esp
80109d63:	6a 00                	push   $0x0
80109d65:	ff 75 0c             	pushl  0xc(%ebp)
80109d68:	ff 75 08             	pushl  0x8(%ebp)
80109d6b:	e8 aa f7 ff ff       	call   8010951a <walkpgdir>
80109d70:	83 c4 10             	add    $0x10,%esp
80109d73:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80109d76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d79:	8b 00                	mov    (%eax),%eax
80109d7b:	83 e0 01             	and    $0x1,%eax
80109d7e:	85 c0                	test   %eax,%eax
80109d80:	75 07                	jne    80109d89 <uva2ka+0x2f>
    return 0;
80109d82:	b8 00 00 00 00       	mov    $0x0,%eax
80109d87:	eb 22                	jmp    80109dab <uva2ka+0x51>
  if((*pte & PTE_U) == 0)
80109d89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d8c:	8b 00                	mov    (%eax),%eax
80109d8e:	83 e0 04             	and    $0x4,%eax
80109d91:	85 c0                	test   %eax,%eax
80109d93:	75 07                	jne    80109d9c <uva2ka+0x42>
    return 0;
80109d95:	b8 00 00 00 00       	mov    $0x0,%eax
80109d9a:	eb 0f                	jmp    80109dab <uva2ka+0x51>
  return (char*)P2V(PTE_ADDR(*pte));
80109d9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d9f:	8b 00                	mov    (%eax),%eax
80109da1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109da6:	05 00 00 00 80       	add    $0x80000000,%eax
}
80109dab:	c9                   	leave  
80109dac:	c3                   	ret    

80109dad <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80109dad:	55                   	push   %ebp
80109dae:	89 e5                	mov    %esp,%ebp
80109db0:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80109db3:	8b 45 10             	mov    0x10(%ebp),%eax
80109db6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80109db9:	eb 7f                	jmp    80109e3a <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
80109dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
80109dbe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109dc3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80109dc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109dc9:	83 ec 08             	sub    $0x8,%esp
80109dcc:	50                   	push   %eax
80109dcd:	ff 75 08             	pushl  0x8(%ebp)
80109dd0:	e8 85 ff ff ff       	call   80109d5a <uva2ka>
80109dd5:	83 c4 10             	add    $0x10,%esp
80109dd8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80109ddb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80109ddf:	75 07                	jne    80109de8 <copyout+0x3b>
      return -1;
80109de1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80109de6:	eb 61                	jmp    80109e49 <copyout+0x9c>
    n = PGSIZE - (va - va0);
80109de8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109deb:	2b 45 0c             	sub    0xc(%ebp),%eax
80109dee:	05 00 10 00 00       	add    $0x1000,%eax
80109df3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80109df6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109df9:	3b 45 14             	cmp    0x14(%ebp),%eax
80109dfc:	76 06                	jbe    80109e04 <copyout+0x57>
      n = len;
80109dfe:	8b 45 14             	mov    0x14(%ebp),%eax
80109e01:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
80109e04:	8b 45 0c             	mov    0xc(%ebp),%eax
80109e07:	2b 45 ec             	sub    -0x14(%ebp),%eax
80109e0a:	89 c2                	mov    %eax,%edx
80109e0c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109e0f:	01 d0                	add    %edx,%eax
80109e11:	83 ec 04             	sub    $0x4,%esp
80109e14:	ff 75 f0             	pushl  -0x10(%ebp)
80109e17:	ff 75 f4             	pushl  -0xc(%ebp)
80109e1a:	50                   	push   %eax
80109e1b:	e8 d2 ca ff ff       	call   801068f2 <memmove>
80109e20:	83 c4 10             	add    $0x10,%esp
    len -= n;
80109e23:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109e26:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
80109e29:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109e2c:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80109e2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109e32:	05 00 10 00 00       	add    $0x1000,%eax
80109e37:	89 45 0c             	mov    %eax,0xc(%ebp)
  while(len > 0){
80109e3a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80109e3e:	0f 85 77 ff ff ff    	jne    80109dbb <copyout+0xe>
  }
  return 0;
80109e44:	b8 00 00 00 00       	mov    $0x0,%eax
}
80109e49:	c9                   	leave  
80109e4a:	c3                   	ret    

80109e4b <initselproc>:

extern void wakeup(void *);


void initselproc(struct selproc * s)
{
80109e4b:	55                   	push   %ebp
80109e4c:	89 e5                	mov    %esp,%ebp
80109e4e:	83 ec 10             	sub    $0x10,%esp
  s->selcount = 0;
80109e51:	8b 45 08             	mov    0x8(%ebp),%eax
80109e54:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80109e5b:	00 00 00 
  for (int i=0; i<NSELPROC; i++)
80109e5e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80109e65:	eb 11                	jmp    80109e78 <initselproc+0x2d>
  {
      s->sel[i] = 0;
80109e67:	8b 45 08             	mov    0x8(%ebp),%eax
80109e6a:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109e6d:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
  for (int i=0; i<NSELPROC; i++)
80109e74:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80109e78:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80109e7c:	7e e9                	jle    80109e67 <initselproc+0x1c>
  }
}
80109e7e:	90                   	nop
80109e7f:	c9                   	leave  
80109e80:	c3                   	ret    

80109e81 <clearselid>:

void clearselid(struct selproc *s, int * selid)
{
80109e81:	55                   	push   %ebp
80109e82:	89 e5                	mov    %esp,%ebp
80109e84:	83 ec 10             	sub    $0x10,%esp
    for (int i=0; i<NSELPROC; i++)
80109e87:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80109e8e:	eb 34                	jmp    80109ec4 <clearselid+0x43>
    {
        if (s->sel[i] == selid)
80109e90:	8b 45 08             	mov    0x8(%ebp),%eax
80109e93:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109e96:	8b 04 90             	mov    (%eax,%edx,4),%eax
80109e99:	39 45 0c             	cmp    %eax,0xc(%ebp)
80109e9c:	75 22                	jne    80109ec0 <clearselid+0x3f>
        {
            s->sel[i] = 0;
80109e9e:	8b 45 08             	mov    0x8(%ebp),%eax
80109ea1:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109ea4:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
            s->selcount--;
80109eab:	8b 45 08             	mov    0x8(%ebp),%eax
80109eae:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80109eb4:	8d 50 ff             	lea    -0x1(%eax),%edx
80109eb7:	8b 45 08             	mov    0x8(%ebp),%eax
80109eba:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    for (int i=0; i<NSELPROC; i++)
80109ec0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80109ec4:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80109ec8:	7e c6                	jle    80109e90 <clearselid+0xf>
        }
    }
}
80109eca:	90                   	nop
80109ecb:	c9                   	leave  
80109ecc:	c3                   	ret    

80109ecd <addselid>:

void addselid(struct selproc *s, int * selid, struct spinlock * lk)
{
80109ecd:	55                   	push   %ebp
80109ece:	89 e5                	mov    %esp,%ebp
80109ed0:	83 ec 10             	sub    $0x10,%esp
    for (int i=0; i<NSELPROC; i++)
80109ed3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80109eda:	eb 43                	jmp    80109f1f <addselid+0x52>
    {
        if (s->sel[i] == 0)
80109edc:	8b 45 08             	mov    0x8(%ebp),%eax
80109edf:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109ee2:	8b 04 90             	mov    (%eax,%edx,4),%eax
80109ee5:	85 c0                	test   %eax,%eax
80109ee7:	75 32                	jne    80109f1b <addselid+0x4e>
        {
            s->sel[i] = selid;
80109ee9:	8b 45 08             	mov    0x8(%ebp),%eax
80109eec:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109eef:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80109ef2:	89 0c 90             	mov    %ecx,(%eax,%edx,4)
            s->lk[i] = lk;
80109ef5:	8b 45 08             	mov    0x8(%ebp),%eax
80109ef8:	8b 55 fc             	mov    -0x4(%ebp),%edx
80109efb:	8d 4a 10             	lea    0x10(%edx),%ecx
80109efe:	8b 55 10             	mov    0x10(%ebp),%edx
80109f01:	89 14 88             	mov    %edx,(%eax,%ecx,4)
            s->selcount++;
80109f04:	8b 45 08             	mov    0x8(%ebp),%eax
80109f07:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80109f0d:	8d 50 01             	lea    0x1(%eax),%edx
80109f10:	8b 45 08             	mov    0x8(%ebp),%eax
80109f13:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
            break;
80109f19:	eb 0a                	jmp    80109f25 <addselid+0x58>
    for (int i=0; i<NSELPROC; i++)
80109f1b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80109f1f:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80109f23:	7e b7                	jle    80109edc <addselid+0xf>
        }
    }
}
80109f25:	90                   	nop
80109f26:	c9                   	leave  
80109f27:	c3                   	ret    

80109f28 <wakeupselect>:

void wakeupselect(struct selproc * s)
{
80109f28:	55                   	push   %ebp
80109f29:	89 e5                	mov    %esp,%ebp
80109f2b:	83 ec 18             	sub    $0x18,%esp
    for (int i=0; i<NSELPROC; i++)
80109f2e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109f35:	eb 56                	jmp    80109f8d <wakeupselect+0x65>
    {
        if (s->sel[i])
80109f37:	8b 45 08             	mov    0x8(%ebp),%eax
80109f3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109f3d:	8b 04 90             	mov    (%eax,%edx,4),%eax
80109f40:	85 c0                	test   %eax,%eax
80109f42:	74 45                	je     80109f89 <wakeupselect+0x61>
        {
            acquire(s->lk[i]);
80109f44:	8b 45 08             	mov    0x8(%ebp),%eax
80109f47:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109f4a:	83 c2 10             	add    $0x10,%edx
80109f4d:	8b 04 90             	mov    (%eax,%edx,4),%eax
80109f50:	83 ec 0c             	sub    $0xc,%esp
80109f53:	50                   	push   %eax
80109f54:	e8 64 c6 ff ff       	call   801065bd <acquire>
80109f59:	83 c4 10             	add    $0x10,%esp
            wakeup((void*)s->sel[i]);
80109f5c:	8b 45 08             	mov    0x8(%ebp),%eax
80109f5f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109f62:	8b 04 90             	mov    (%eax,%edx,4),%eax
80109f65:	83 ec 0c             	sub    $0xc,%esp
80109f68:	50                   	push   %eax
80109f69:	e8 3b c4 ff ff       	call   801063a9 <wakeup>
80109f6e:	83 c4 10             	add    $0x10,%esp
            release(s->lk[i]);
80109f71:	8b 45 08             	mov    0x8(%ebp),%eax
80109f74:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109f77:	83 c2 10             	add    $0x10,%edx
80109f7a:	8b 04 90             	mov    (%eax,%edx,4),%eax
80109f7d:	83 ec 0c             	sub    $0xc,%esp
80109f80:	50                   	push   %eax
80109f81:	e8 a3 c6 ff ff       	call   80106629 <release>
80109f86:	83 c4 10             	add    $0x10,%esp
    for (int i=0; i<NSELPROC; i++)
80109f89:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80109f8d:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80109f91:	7e a4                	jle    80109f37 <wakeupselect+0xf>
        }
    }
}
80109f93:	90                   	nop
80109f94:	c9                   	leave  
80109f95:	c3                   	ret    

80109f96 <mon_help>:

/***** Implementations of basic kernel monitor commands *****/

int
mon_help(int argc, char **argv, struct Trapframe *tf)
{
80109f96:	55                   	push   %ebp
80109f97:	89 e5                	mov    %esp,%ebp
80109f99:	83 ec 18             	sub    $0x18,%esp
  int i;

  for (i = 0; i < NCOMMANDS; i++)
80109f9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109fa3:	eb 3c                	jmp    80109fe1 <mon_help+0x4b>
    cprintf("%s - %s\n", commands[i].name, commands[i].desc);
80109fa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109fa8:	89 d0                	mov    %edx,%eax
80109faa:	01 c0                	add    %eax,%eax
80109fac:	01 d0                	add    %edx,%eax
80109fae:	c1 e0 02             	shl    $0x2,%eax
80109fb1:	05 44 95 12 80       	add    $0x80129544,%eax
80109fb6:	8b 08                	mov    (%eax),%ecx
80109fb8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80109fbb:	89 d0                	mov    %edx,%eax
80109fbd:	01 c0                	add    %eax,%eax
80109fbf:	01 d0                	add    %edx,%eax
80109fc1:	c1 e0 02             	shl    $0x2,%eax
80109fc4:	05 40 95 12 80       	add    $0x80129540,%eax
80109fc9:	8b 00                	mov    (%eax),%eax
80109fcb:	83 ec 04             	sub    $0x4,%esp
80109fce:	51                   	push   %ecx
80109fcf:	50                   	push   %eax
80109fd0:	68 7d bc 10 80       	push   $0x8010bc7d
80109fd5:	e8 3e 6e ff ff       	call   80100e18 <cprintf>
80109fda:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < NCOMMANDS; i++)
80109fdd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80109fe1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109fe4:	83 f8 01             	cmp    $0x1,%eax
80109fe7:	76 bc                	jbe    80109fa5 <mon_help+0xf>
  return 0;
80109fe9:	b8 00 00 00 00       	mov    $0x0,%eax
}
80109fee:	c9                   	leave  
80109fef:	c3                   	ret    

80109ff0 <mon_infokern>:

int
mon_infokern(int argc, char **argv, struct Trapframe *tf)
{
80109ff0:	55                   	push   %ebp
80109ff1:	89 e5                	mov    %esp,%ebp
80109ff3:	83 ec 18             	sub    $0x18,%esp
  extern char _start[], entry[], etext[], edata[], end[];

  cprintf("Special kernel symbols:\n");
80109ff6:	83 ec 0c             	sub    $0xc,%esp
80109ff9:	68 86 bc 10 80       	push   $0x8010bc86
80109ffe:	e8 15 6e ff ff       	call   80100e18 <cprintf>
8010a003:	83 c4 10             	add    $0x10,%esp
  cprintf("  _start                  %08x (phys)\n", _start);
8010a006:	83 ec 08             	sub    $0x8,%esp
8010a009:	68 0c 00 10 00       	push   $0x10000c
8010a00e:	68 a0 bc 10 80       	push   $0x8010bca0
8010a013:	e8 00 6e ff ff       	call   80100e18 <cprintf>
8010a018:	83 c4 10             	add    $0x10,%esp
  cprintf("  entry  %08x (virt)  %08x (phys)\n", entry, entry - KERNBASE);
8010a01b:	b8 0c 00 10 00       	mov    $0x10000c,%eax
8010a020:	83 ec 04             	sub    $0x4,%esp
8010a023:	50                   	push   %eax
8010a024:	68 0c 00 10 80       	push   $0x8010000c
8010a029:	68 c8 bc 10 80       	push   $0x8010bcc8
8010a02e:	e8 e5 6d ff ff       	call   80100e18 <cprintf>
8010a033:	83 c4 10             	add    $0x10,%esp
  cprintf("  etext  %08x (virt)  %08x (phys)\n", etext, etext - KERNBASE);
8010a036:	b8 c9 af 10 00       	mov    $0x10afc9,%eax
8010a03b:	83 ec 04             	sub    $0x4,%esp
8010a03e:	50                   	push   %eax
8010a03f:	68 c9 af 10 80       	push   $0x8010afc9
8010a044:	68 ec bc 10 80       	push   $0x8010bcec
8010a049:	e8 ca 6d ff ff       	call   80100e18 <cprintf>
8010a04e:	83 c4 10             	add    $0x10,%esp
  cprintf("  edata  %08x (virt)  %08x (phys)\n", edata, edata - KERNBASE);
8010a051:	b8 0e 96 12 00       	mov    $0x12960e,%eax
8010a056:	83 ec 04             	sub    $0x4,%esp
8010a059:	50                   	push   %eax
8010a05a:	68 0e 96 12 80       	push   $0x8012960e
8010a05f:	68 10 bd 10 80       	push   $0x8010bd10
8010a064:	e8 af 6d ff ff       	call   80100e18 <cprintf>
8010a069:	83 c4 10             	add    $0x10,%esp
  cprintf("  end    %08x (virt)  %08x (phys)\n", end, end - KERNBASE);
8010a06c:	b8 68 4e 13 00       	mov    $0x134e68,%eax
8010a071:	83 ec 04             	sub    $0x4,%esp
8010a074:	50                   	push   %eax
8010a075:	68 68 4e 13 80       	push   $0x80134e68
8010a07a:	68 34 bd 10 80       	push   $0x8010bd34
8010a07f:	e8 94 6d ff ff       	call   80100e18 <cprintf>
8010a084:	83 c4 10             	add    $0x10,%esp
  cprintf("Kernel executable memory footprint: %dKB\n",
          ROUNDUP(end - entry, 1024) / 1024);
8010a087:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
8010a08e:	ba 0c 00 10 80       	mov    $0x8010000c,%edx
8010a093:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a096:	29 d0                	sub    %edx,%eax
8010a098:	89 c2                	mov    %eax,%edx
8010a09a:	b8 68 4e 13 80       	mov    $0x80134e68,%eax
8010a09f:	83 e8 01             	sub    $0x1,%eax
8010a0a2:	01 d0                	add    %edx,%eax
8010a0a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a0a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a0aa:	ba 00 00 00 00       	mov    $0x0,%edx
8010a0af:	f7 75 f4             	divl   -0xc(%ebp)
8010a0b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a0b5:	29 d0                	sub    %edx,%eax
  cprintf("Kernel executable memory footprint: %dKB\n",
8010a0b7:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
8010a0bd:	85 c0                	test   %eax,%eax
8010a0bf:	0f 48 c2             	cmovs  %edx,%eax
8010a0c2:	c1 f8 0a             	sar    $0xa,%eax
8010a0c5:	83 ec 08             	sub    $0x8,%esp
8010a0c8:	50                   	push   %eax
8010a0c9:	68 58 bd 10 80       	push   $0x8010bd58
8010a0ce:	e8 45 6d ff ff       	call   80100e18 <cprintf>
8010a0d3:	83 c4 10             	add    $0x10,%esp
  return 0;
8010a0d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a0db:	c9                   	leave  
8010a0dc:	c3                   	ret    

8010a0dd <mon_backtrace>:

int
mon_backtrace(int argc, char **argv, struct Trapframe *tf)
{
8010a0dd:	55                   	push   %ebp
8010a0de:	89 e5                	mov    %esp,%ebp

 // Your code here.
 return 0;
8010a0e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a0e5:	5d                   	pop    %ebp
8010a0e6:	c3                   	ret    

8010a0e7 <runcmd>:
#define WHITESPACE "\t\r\n "
#define MAXARGS 16

static int
runcmd(char *buf, struct Trapframe *tf)
{
8010a0e7:	55                   	push   %ebp
8010a0e8:	89 e5                	mov    %esp,%ebp
8010a0ea:	83 ec 58             	sub    $0x58,%esp
  int argc;
  char *argv[MAXARGS];
  int i;

  // Parse the command buffer into whitespace-separated arguments
  argc = 0;
8010a0ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  argv[argc] = 0;
8010a0f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a0f7:	c7 44 85 b0 00 00 00 	movl   $0x0,-0x50(%ebp,%eax,4)
8010a0fe:	00 
  while (1) {
    // gobble whitespace
    while (*buf && strchr(WHITESPACE, *buf))
8010a0ff:	eb 0c                	jmp    8010a10d <runcmd+0x26>
      *buf++ = 0;
8010a101:	8b 45 08             	mov    0x8(%ebp),%eax
8010a104:	8d 50 01             	lea    0x1(%eax),%edx
8010a107:	89 55 08             	mov    %edx,0x8(%ebp)
8010a10a:	c6 00 00             	movb   $0x0,(%eax)
    while (*buf && strchr(WHITESPACE, *buf))
8010a10d:	8b 45 08             	mov    0x8(%ebp),%eax
8010a110:	0f b6 00             	movzbl (%eax),%eax
8010a113:	84 c0                	test   %al,%al
8010a115:	74 1e                	je     8010a135 <runcmd+0x4e>
8010a117:	8b 45 08             	mov    0x8(%ebp),%eax
8010a11a:	0f b6 00             	movzbl (%eax),%eax
8010a11d:	0f be c0             	movsbl %al,%eax
8010a120:	83 ec 08             	sub    $0x8,%esp
8010a123:	50                   	push   %eax
8010a124:	68 82 bd 10 80       	push   $0x8010bd82
8010a129:	e8 e8 c9 ff ff       	call   80106b16 <strchr>
8010a12e:	83 c4 10             	add    $0x10,%esp
8010a131:	85 c0                	test   %eax,%eax
8010a133:	75 cc                	jne    8010a101 <runcmd+0x1a>
    if (*buf == 0)
8010a135:	8b 45 08             	mov    0x8(%ebp),%eax
8010a138:	0f b6 00             	movzbl (%eax),%eax
8010a13b:	84 c0                	test   %al,%al
8010a13d:	74 65                	je     8010a1a4 <runcmd+0xbd>
      break;

    // save and scan past next arg
    if (argc == MAXARGS-1) {
8010a13f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010a143:	75 1c                	jne    8010a161 <runcmd+0x7a>
      cprintf("Too many arguments (max %d)\n", MAXARGS);
8010a145:	83 ec 08             	sub    $0x8,%esp
8010a148:	6a 10                	push   $0x10
8010a14a:	68 87 bd 10 80       	push   $0x8010bd87
8010a14f:	e8 c4 6c ff ff       	call   80100e18 <cprintf>
8010a154:	83 c4 10             	add    $0x10,%esp
      return 0;
8010a157:	b8 00 00 00 00       	mov    $0x0,%eax
8010a15c:	e9 d8 00 00 00       	jmp    8010a239 <runcmd+0x152>
    }
    argv[argc++] = buf;
8010a161:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a164:	8d 50 01             	lea    0x1(%eax),%edx
8010a167:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010a16a:	8b 55 08             	mov    0x8(%ebp),%edx
8010a16d:	89 54 85 b0          	mov    %edx,-0x50(%ebp,%eax,4)
    while (*buf && !strchr(WHITESPACE, *buf))
8010a171:	eb 04                	jmp    8010a177 <runcmd+0x90>
      buf++;
8010a173:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*buf && !strchr(WHITESPACE, *buf))
8010a177:	8b 45 08             	mov    0x8(%ebp),%eax
8010a17a:	0f b6 00             	movzbl (%eax),%eax
8010a17d:	84 c0                	test   %al,%al
8010a17f:	74 8c                	je     8010a10d <runcmd+0x26>
8010a181:	8b 45 08             	mov    0x8(%ebp),%eax
8010a184:	0f b6 00             	movzbl (%eax),%eax
8010a187:	0f be c0             	movsbl %al,%eax
8010a18a:	83 ec 08             	sub    $0x8,%esp
8010a18d:	50                   	push   %eax
8010a18e:	68 82 bd 10 80       	push   $0x8010bd82
8010a193:	e8 7e c9 ff ff       	call   80106b16 <strchr>
8010a198:	83 c4 10             	add    $0x10,%esp
8010a19b:	85 c0                	test   %eax,%eax
8010a19d:	74 d4                	je     8010a173 <runcmd+0x8c>
    while (*buf && strchr(WHITESPACE, *buf))
8010a19f:	e9 69 ff ff ff       	jmp    8010a10d <runcmd+0x26>
      break;
8010a1a4:	90                   	nop
  }
  argv[argc] = 0;
8010a1a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a1a8:	c7 44 85 b0 00 00 00 	movl   $0x0,-0x50(%ebp,%eax,4)
8010a1af:	00 

  // Lookup and invoke the command
  if (argc == 0)
8010a1b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010a1b4:	75 07                	jne    8010a1bd <runcmd+0xd6>
    return 0;
8010a1b6:	b8 00 00 00 00       	mov    $0x0,%eax
8010a1bb:	eb 7c                	jmp    8010a239 <runcmd+0x152>
  for (i = 0; i < NCOMMANDS; i++)
8010a1bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010a1c4:	eb 52                	jmp    8010a218 <runcmd+0x131>
    if (strcmp(argv[0], commands[i].name) == 0)
8010a1c6:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010a1c9:	89 d0                	mov    %edx,%eax
8010a1cb:	01 c0                	add    %eax,%eax
8010a1cd:	01 d0                	add    %edx,%eax
8010a1cf:	c1 e0 02             	shl    $0x2,%eax
8010a1d2:	05 40 95 12 80       	add    $0x80129540,%eax
8010a1d7:	8b 10                	mov    (%eax),%edx
8010a1d9:	8b 45 b0             	mov    -0x50(%ebp),%eax
8010a1dc:	83 ec 08             	sub    $0x8,%esp
8010a1df:	52                   	push   %edx
8010a1e0:	50                   	push   %eax
8010a1e1:	e8 f1 c8 ff ff       	call   80106ad7 <strcmp>
8010a1e6:	83 c4 10             	add    $0x10,%esp
8010a1e9:	85 c0                	test   %eax,%eax
8010a1eb:	75 27                	jne    8010a214 <runcmd+0x12d>
      return commands[i].func(argc, argv, tf);
8010a1ed:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010a1f0:	89 d0                	mov    %edx,%eax
8010a1f2:	01 c0                	add    %eax,%eax
8010a1f4:	01 d0                	add    %edx,%eax
8010a1f6:	c1 e0 02             	shl    $0x2,%eax
8010a1f9:	05 48 95 12 80       	add    $0x80129548,%eax
8010a1fe:	8b 00                	mov    (%eax),%eax
8010a200:	83 ec 04             	sub    $0x4,%esp
8010a203:	ff 75 0c             	pushl  0xc(%ebp)
8010a206:	8d 55 b0             	lea    -0x50(%ebp),%edx
8010a209:	52                   	push   %edx
8010a20a:	ff 75 f4             	pushl  -0xc(%ebp)
8010a20d:	ff d0                	call   *%eax
8010a20f:	83 c4 10             	add    $0x10,%esp
8010a212:	eb 25                	jmp    8010a239 <runcmd+0x152>
  for (i = 0; i < NCOMMANDS; i++)
8010a214:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010a218:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a21b:	83 f8 01             	cmp    $0x1,%eax
8010a21e:	76 a6                	jbe    8010a1c6 <runcmd+0xdf>
  cprintf("Unknown command '%s'\n", argv[0]);
8010a220:	8b 45 b0             	mov    -0x50(%ebp),%eax
8010a223:	83 ec 08             	sub    $0x8,%esp
8010a226:	50                   	push   %eax
8010a227:	68 a4 bd 10 80       	push   $0x8010bda4
8010a22c:	e8 e7 6b ff ff       	call   80100e18 <cprintf>
8010a231:	83 c4 10             	add    $0x10,%esp
  return 0;
8010a234:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a239:	c9                   	leave  
8010a23a:	c3                   	ret    

8010a23b <monitor>:

void
monitor(struct Trapframe *tf)
{
8010a23b:	55                   	push   %ebp
8010a23c:	89 e5                	mov    %esp,%ebp
8010a23e:	83 ec 18             	sub    $0x18,%esp
  char *buf;

  cprintf("Welcome to the xv6 kernel monitor!\n");
8010a241:	83 ec 0c             	sub    $0xc,%esp
8010a244:	68 bc bd 10 80       	push   $0x8010bdbc
8010a249:	e8 ca 6b ff ff       	call   80100e18 <cprintf>
8010a24e:	83 c4 10             	add    $0x10,%esp
  cprintf("Type 'help' for a list of commands.\n");
8010a251:	83 ec 0c             	sub    $0xc,%esp
8010a254:	68 e0 bd 10 80       	push   $0x8010bde0
8010a259:	e8 ba 6b ff ff       	call   80100e18 <cprintf>
8010a25e:	83 c4 10             	add    $0x10,%esp

  while (1) {
    buf = readline("K> ");
8010a261:	83 ec 0c             	sub    $0xc,%esp
8010a264:	68 05 be 10 80       	push   $0x8010be05
8010a269:	e8 27 00 00 00       	call   8010a295 <readline>
8010a26e:	83 c4 10             	add    $0x10,%esp
8010a271:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (buf != NULL)
8010a274:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010a278:	74 e7                	je     8010a261 <monitor+0x26>
      if (runcmd(buf, tf) < 0)
8010a27a:	83 ec 08             	sub    $0x8,%esp
8010a27d:	ff 75 08             	pushl  0x8(%ebp)
8010a280:	ff 75 f4             	pushl  -0xc(%ebp)
8010a283:	e8 5f fe ff ff       	call   8010a0e7 <runcmd>
8010a288:	83 c4 10             	add    $0x10,%esp
8010a28b:	85 c0                	test   %eax,%eax
8010a28d:	78 02                	js     8010a291 <monitor+0x56>
    buf = readline("K> ");
8010a28f:	eb d0                	jmp    8010a261 <monitor+0x26>
        break;
8010a291:	90                   	nop
  }
}
8010a292:	90                   	nop
8010a293:	c9                   	leave  
8010a294:	c3                   	ret    

8010a295 <readline>:
#define BUFLEN 1024
static char buf[BUFLEN];

char *
readline(const char *prompt)
{
8010a295:	55                   	push   %ebp
8010a296:	89 e5                	mov    %esp,%ebp
8010a298:	83 ec 18             	sub    $0x18,%esp
  int i, c, echoing;

  if (prompt != NULL)
8010a29b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010a29f:	74 13                	je     8010a2b4 <readline+0x1f>
    cprintf("%s", prompt);
8010a2a1:	83 ec 08             	sub    $0x8,%esp
8010a2a4:	ff 75 08             	pushl  0x8(%ebp)
8010a2a7:	68 09 be 10 80       	push   $0x8010be09
8010a2ac:	e8 67 6b ff ff       	call   80100e18 <cprintf>
8010a2b1:	83 c4 10             	add    $0x10,%esp

  i = 0;
8010a2b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  echoing = iscons(0);
8010a2bb:	83 ec 0c             	sub    $0xc,%esp
8010a2be:	6a 00                	push   $0x0
8010a2c0:	e8 be 72 ff ff       	call   80101583 <iscons>
8010a2c5:	83 c4 10             	add    $0x10,%esp
8010a2c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while (1) {
    c = getchar();
8010a2cb:	e8 9a 72 ff ff       	call   8010156a <getchar>
8010a2d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (c < 0) {
8010a2d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010a2d7:	79 1d                	jns    8010a2f6 <readline+0x61>
      cprintf("read error: %e\n", c);
8010a2d9:	83 ec 08             	sub    $0x8,%esp
8010a2dc:	ff 75 ec             	pushl  -0x14(%ebp)
8010a2df:	68 0c be 10 80       	push   $0x8010be0c
8010a2e4:	e8 2f 6b ff ff       	call   80100e18 <cprintf>
8010a2e9:	83 c4 10             	add    $0x10,%esp
      return NULL;
8010a2ec:	b8 00 00 00 00       	mov    $0x0,%eax
8010a2f1:	e9 9c 00 00 00       	jmp    8010a392 <readline+0xfd>
    } else if ((c == '\b' || c == '\x7f') && i > 0) {
8010a2f6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
8010a2fa:	74 06                	je     8010a302 <readline+0x6d>
8010a2fc:	83 7d ec 7f          	cmpl   $0x7f,-0x14(%ebp)
8010a300:	75 1f                	jne    8010a321 <readline+0x8c>
8010a302:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010a306:	7e 19                	jle    8010a321 <readline+0x8c>
      if (echoing)
8010a308:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010a30c:	74 0d                	je     8010a31b <readline+0x86>
        cputchar('\b');
8010a30e:	83 ec 0c             	sub    $0xc,%esp
8010a311:	6a 08                	push   $0x8
8010a313:	e8 3b 72 ff ff       	call   80101553 <cputchar>
8010a318:	83 c4 10             	add    $0x10,%esp
      i--;
8010a31b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
8010a31f:	eb 6c                	jmp    8010a38d <readline+0xf8>
    } else if (c >= ' ' && i < BUFLEN-1) {
8010a321:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
8010a325:	7e 31                	jle    8010a358 <readline+0xc3>
8010a327:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
8010a32e:	7f 28                	jg     8010a358 <readline+0xc3>
      if (echoing)
8010a330:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010a334:	74 0e                	je     8010a344 <readline+0xaf>
        cputchar(c);
8010a336:	83 ec 0c             	sub    $0xc,%esp
8010a339:	ff 75 ec             	pushl  -0x14(%ebp)
8010a33c:	e8 12 72 ff ff       	call   80101553 <cputchar>
8010a341:	83 c4 10             	add    $0x10,%esp
      buf[i++] = c;
8010a344:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a347:	8d 50 01             	lea    0x1(%eax),%edx
8010a34a:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010a34d:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010a350:	88 90 e0 96 12 80    	mov    %dl,-0x7fed6920(%eax)
8010a356:	eb 35                	jmp    8010a38d <readline+0xf8>
    } else if (c == '\n' || c == '\r') {
8010a358:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
8010a35c:	74 0a                	je     8010a368 <readline+0xd3>
8010a35e:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
8010a362:	0f 85 63 ff ff ff    	jne    8010a2cb <readline+0x36>
      if (echoing)
8010a368:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010a36c:	74 0d                	je     8010a37b <readline+0xe6>
        cputchar('\n');
8010a36e:	83 ec 0c             	sub    $0xc,%esp
8010a371:	6a 0a                	push   $0xa
8010a373:	e8 db 71 ff ff       	call   80101553 <cputchar>
8010a378:	83 c4 10             	add    $0x10,%esp
      buf[i] = 0;
8010a37b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a37e:	05 e0 96 12 80       	add    $0x801296e0,%eax
8010a383:	c6 00 00             	movb   $0x0,(%eax)
      return buf;
8010a386:	b8 e0 96 12 80       	mov    $0x801296e0,%eax
8010a38b:	eb 05                	jmp    8010a392 <readline+0xfd>
    c = getchar();
8010a38d:	e9 39 ff ff ff       	jmp    8010a2cb <readline+0x36>
    }
  }
}
8010a392:	c9                   	leave  
8010a393:	c3                   	ret    

8010a394 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
8010a394:	55                   	push   %ebp
8010a395:	89 e5                	mov    %esp,%ebp
8010a397:	53                   	push   %ebx
8010a398:	83 ec 14             	sub    $0x14,%esp
8010a39b:	8b 45 10             	mov    0x10(%ebp),%eax
8010a39e:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a3a1:	8b 45 14             	mov    0x14(%ebp),%eax
8010a3a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
8010a3a7:	8b 45 18             	mov    0x18(%ebp),%eax
8010a3aa:	ba 00 00 00 00       	mov    $0x0,%edx
8010a3af:	39 55 f4             	cmp    %edx,-0xc(%ebp)
8010a3b2:	72 55                	jb     8010a409 <printnum+0x75>
8010a3b4:	39 55 f4             	cmp    %edx,-0xc(%ebp)
8010a3b7:	77 05                	ja     8010a3be <printnum+0x2a>
8010a3b9:	39 45 f0             	cmp    %eax,-0x10(%ebp)
8010a3bc:	72 4b                	jb     8010a409 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
8010a3be:	8b 45 1c             	mov    0x1c(%ebp),%eax
8010a3c1:	8d 58 ff             	lea    -0x1(%eax),%ebx
8010a3c4:	8b 45 18             	mov    0x18(%ebp),%eax
8010a3c7:	ba 00 00 00 00       	mov    $0x0,%edx
8010a3cc:	52                   	push   %edx
8010a3cd:	50                   	push   %eax
8010a3ce:	ff 75 f4             	pushl  -0xc(%ebp)
8010a3d1:	ff 75 f0             	pushl  -0x10(%ebp)
8010a3d4:	e8 b7 09 00 00       	call   8010ad90 <__udivdi3>
8010a3d9:	83 c4 10             	add    $0x10,%esp
8010a3dc:	83 ec 04             	sub    $0x4,%esp
8010a3df:	ff 75 20             	pushl  0x20(%ebp)
8010a3e2:	53                   	push   %ebx
8010a3e3:	ff 75 18             	pushl  0x18(%ebp)
8010a3e6:	52                   	push   %edx
8010a3e7:	50                   	push   %eax
8010a3e8:	ff 75 0c             	pushl  0xc(%ebp)
8010a3eb:	ff 75 08             	pushl  0x8(%ebp)
8010a3ee:	e8 a1 ff ff ff       	call   8010a394 <printnum>
8010a3f3:	83 c4 20             	add    $0x20,%esp
8010a3f6:	eb 1b                	jmp    8010a413 <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
8010a3f8:	83 ec 08             	sub    $0x8,%esp
8010a3fb:	ff 75 0c             	pushl  0xc(%ebp)
8010a3fe:	ff 75 20             	pushl  0x20(%ebp)
8010a401:	8b 45 08             	mov    0x8(%ebp),%eax
8010a404:	ff d0                	call   *%eax
8010a406:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
8010a409:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
8010a40d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
8010a411:	7f e5                	jg     8010a3f8 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
8010a413:	8b 4d 18             	mov    0x18(%ebp),%ecx
8010a416:	bb 00 00 00 00       	mov    $0x0,%ebx
8010a41b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a41e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a421:	53                   	push   %ebx
8010a422:	51                   	push   %ecx
8010a423:	52                   	push   %edx
8010a424:	50                   	push   %eax
8010a425:	e8 86 0a 00 00       	call   8010aeb0 <__umoddi3>
8010a42a:	83 c4 10             	add    $0x10,%esp
8010a42d:	05 e0 be 10 80       	add    $0x8010bee0,%eax
8010a432:	0f b6 00             	movzbl (%eax),%eax
8010a435:	0f be c0             	movsbl %al,%eax
8010a438:	83 ec 08             	sub    $0x8,%esp
8010a43b:	ff 75 0c             	pushl  0xc(%ebp)
8010a43e:	50                   	push   %eax
8010a43f:	8b 45 08             	mov    0x8(%ebp),%eax
8010a442:	ff d0                	call   *%eax
8010a444:	83 c4 10             	add    $0x10,%esp
}
8010a447:	90                   	nop
8010a448:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010a44b:	c9                   	leave  
8010a44c:	c3                   	ret    

8010a44d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
8010a44d:	55                   	push   %ebp
8010a44e:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
8010a450:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
8010a454:	7e 14                	jle    8010a46a <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
8010a456:	8b 45 08             	mov    0x8(%ebp),%eax
8010a459:	8b 00                	mov    (%eax),%eax
8010a45b:	8d 48 08             	lea    0x8(%eax),%ecx
8010a45e:	8b 55 08             	mov    0x8(%ebp),%edx
8010a461:	89 0a                	mov    %ecx,(%edx)
8010a463:	8b 50 04             	mov    0x4(%eax),%edx
8010a466:	8b 00                	mov    (%eax),%eax
8010a468:	eb 30                	jmp    8010a49a <getuint+0x4d>
  else if (lflag)
8010a46a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010a46e:	74 16                	je     8010a486 <getuint+0x39>
    return va_arg(*ap, unsigned long);
8010a470:	8b 45 08             	mov    0x8(%ebp),%eax
8010a473:	8b 00                	mov    (%eax),%eax
8010a475:	8d 48 04             	lea    0x4(%eax),%ecx
8010a478:	8b 55 08             	mov    0x8(%ebp),%edx
8010a47b:	89 0a                	mov    %ecx,(%edx)
8010a47d:	8b 00                	mov    (%eax),%eax
8010a47f:	ba 00 00 00 00       	mov    $0x0,%edx
8010a484:	eb 14                	jmp    8010a49a <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
8010a486:	8b 45 08             	mov    0x8(%ebp),%eax
8010a489:	8b 00                	mov    (%eax),%eax
8010a48b:	8d 48 04             	lea    0x4(%eax),%ecx
8010a48e:	8b 55 08             	mov    0x8(%ebp),%edx
8010a491:	89 0a                	mov    %ecx,(%edx)
8010a493:	8b 00                	mov    (%eax),%eax
8010a495:	ba 00 00 00 00       	mov    $0x0,%edx
}
8010a49a:	5d                   	pop    %ebp
8010a49b:	c3                   	ret    

8010a49c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
8010a49c:	55                   	push   %ebp
8010a49d:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
8010a49f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
8010a4a3:	7e 14                	jle    8010a4b9 <getint+0x1d>
    return va_arg(*ap, long long);
8010a4a5:	8b 45 08             	mov    0x8(%ebp),%eax
8010a4a8:	8b 00                	mov    (%eax),%eax
8010a4aa:	8d 48 08             	lea    0x8(%eax),%ecx
8010a4ad:	8b 55 08             	mov    0x8(%ebp),%edx
8010a4b0:	89 0a                	mov    %ecx,(%edx)
8010a4b2:	8b 50 04             	mov    0x4(%eax),%edx
8010a4b5:	8b 00                	mov    (%eax),%eax
8010a4b7:	eb 28                	jmp    8010a4e1 <getint+0x45>
  else if (lflag)
8010a4b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010a4bd:	74 12                	je     8010a4d1 <getint+0x35>
    return va_arg(*ap, long);
8010a4bf:	8b 45 08             	mov    0x8(%ebp),%eax
8010a4c2:	8b 00                	mov    (%eax),%eax
8010a4c4:	8d 48 04             	lea    0x4(%eax),%ecx
8010a4c7:	8b 55 08             	mov    0x8(%ebp),%edx
8010a4ca:	89 0a                	mov    %ecx,(%edx)
8010a4cc:	8b 00                	mov    (%eax),%eax
8010a4ce:	99                   	cltd   
8010a4cf:	eb 10                	jmp    8010a4e1 <getint+0x45>
  else
    return va_arg(*ap, int);
8010a4d1:	8b 45 08             	mov    0x8(%ebp),%eax
8010a4d4:	8b 00                	mov    (%eax),%eax
8010a4d6:	8d 48 04             	lea    0x4(%eax),%ecx
8010a4d9:	8b 55 08             	mov    0x8(%ebp),%edx
8010a4dc:	89 0a                	mov    %ecx,(%edx)
8010a4de:	8b 00                	mov    (%eax),%eax
8010a4e0:	99                   	cltd   
}
8010a4e1:	5d                   	pop    %ebp
8010a4e2:	c3                   	ret    

8010a4e3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
8010a4e3:	55                   	push   %ebp
8010a4e4:	89 e5                	mov    %esp,%ebp
8010a4e6:	56                   	push   %esi
8010a4e7:	53                   	push   %ebx
8010a4e8:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
8010a4eb:	eb 17                	jmp    8010a504 <vprintfmt+0x21>
      if (ch == '\0')
8010a4ed:	85 db                	test   %ebx,%ebx
8010a4ef:	0f 84 a0 03 00 00    	je     8010a895 <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
8010a4f5:	83 ec 08             	sub    $0x8,%esp
8010a4f8:	ff 75 0c             	pushl  0xc(%ebp)
8010a4fb:	53                   	push   %ebx
8010a4fc:	8b 45 08             	mov    0x8(%ebp),%eax
8010a4ff:	ff d0                	call   *%eax
8010a501:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
8010a504:	8b 45 10             	mov    0x10(%ebp),%eax
8010a507:	8d 50 01             	lea    0x1(%eax),%edx
8010a50a:	89 55 10             	mov    %edx,0x10(%ebp)
8010a50d:	0f b6 00             	movzbl (%eax),%eax
8010a510:	0f b6 d8             	movzbl %al,%ebx
8010a513:	83 fb 25             	cmp    $0x25,%ebx
8010a516:	75 d5                	jne    8010a4ed <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
8010a518:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
8010a51c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
8010a523:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
8010a52a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
8010a531:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
8010a538:	8b 45 10             	mov    0x10(%ebp),%eax
8010a53b:	8d 50 01             	lea    0x1(%eax),%edx
8010a53e:	89 55 10             	mov    %edx,0x10(%ebp)
8010a541:	0f b6 00             	movzbl (%eax),%eax
8010a544:	0f b6 d8             	movzbl %al,%ebx
8010a547:	8d 43 dd             	lea    -0x23(%ebx),%eax
8010a54a:	83 f8 55             	cmp    $0x55,%eax
8010a54d:	0f 87 15 03 00 00    	ja     8010a868 <vprintfmt+0x385>
8010a553:	8b 04 85 04 bf 10 80 	mov    -0x7fef40fc(,%eax,4),%eax
8010a55a:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
8010a55c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
8010a560:	eb d6                	jmp    8010a538 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
8010a562:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
8010a566:	eb d0                	jmp    8010a538 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
8010a568:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
8010a56f:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010a572:	89 d0                	mov    %edx,%eax
8010a574:	c1 e0 02             	shl    $0x2,%eax
8010a577:	01 d0                	add    %edx,%eax
8010a579:	01 c0                	add    %eax,%eax
8010a57b:	01 d8                	add    %ebx,%eax
8010a57d:	83 e8 30             	sub    $0x30,%eax
8010a580:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
8010a583:	8b 45 10             	mov    0x10(%ebp),%eax
8010a586:	0f b6 00             	movzbl (%eax),%eax
8010a589:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
8010a58c:	83 fb 2f             	cmp    $0x2f,%ebx
8010a58f:	7e 39                	jle    8010a5ca <vprintfmt+0xe7>
8010a591:	83 fb 39             	cmp    $0x39,%ebx
8010a594:	7f 34                	jg     8010a5ca <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
8010a596:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
8010a59a:	eb d3                	jmp    8010a56f <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
8010a59c:	8b 45 14             	mov    0x14(%ebp),%eax
8010a59f:	8d 50 04             	lea    0x4(%eax),%edx
8010a5a2:	89 55 14             	mov    %edx,0x14(%ebp)
8010a5a5:	8b 00                	mov    (%eax),%eax
8010a5a7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
8010a5aa:	eb 1f                	jmp    8010a5cb <vprintfmt+0xe8>

    case '.':
      if (width < 0)
8010a5ac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010a5b0:	79 86                	jns    8010a538 <vprintfmt+0x55>
        width = 0;
8010a5b2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
8010a5b9:	e9 7a ff ff ff       	jmp    8010a538 <vprintfmt+0x55>

    case '#':
      altflag = 1;
8010a5be:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
8010a5c5:	e9 6e ff ff ff       	jmp    8010a538 <vprintfmt+0x55>
      goto process_precision;
8010a5ca:	90                   	nop

process_precision:
      if (width < 0)
8010a5cb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010a5cf:	0f 89 63 ff ff ff    	jns    8010a538 <vprintfmt+0x55>
        width = precision, precision = -1;
8010a5d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010a5d8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010a5db:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
8010a5e2:	e9 51 ff ff ff       	jmp    8010a538 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
8010a5e7:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
8010a5eb:	e9 48 ff ff ff       	jmp    8010a538 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
8010a5f0:	8b 45 14             	mov    0x14(%ebp),%eax
8010a5f3:	8d 50 04             	lea    0x4(%eax),%edx
8010a5f6:	89 55 14             	mov    %edx,0x14(%ebp)
8010a5f9:	8b 00                	mov    (%eax),%eax
8010a5fb:	83 ec 08             	sub    $0x8,%esp
8010a5fe:	ff 75 0c             	pushl  0xc(%ebp)
8010a601:	50                   	push   %eax
8010a602:	8b 45 08             	mov    0x8(%ebp),%eax
8010a605:	ff d0                	call   *%eax
8010a607:	83 c4 10             	add    $0x10,%esp
      break;
8010a60a:	e9 81 02 00 00       	jmp    8010a890 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
8010a60f:	8b 45 14             	mov    0x14(%ebp),%eax
8010a612:	8d 50 04             	lea    0x4(%eax),%edx
8010a615:	89 55 14             	mov    %edx,0x14(%ebp)
8010a618:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
8010a61a:	85 db                	test   %ebx,%ebx
8010a61c:	79 02                	jns    8010a620 <vprintfmt+0x13d>
        err = -err;
8010a61e:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
8010a620:	83 fb 0f             	cmp    $0xf,%ebx
8010a623:	7f 0b                	jg     8010a630 <vprintfmt+0x14d>
8010a625:	8b 34 9d a0 be 10 80 	mov    -0x7fef4160(,%ebx,4),%esi
8010a62c:	85 f6                	test   %esi,%esi
8010a62e:	75 19                	jne    8010a649 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
8010a630:	53                   	push   %ebx
8010a631:	68 f1 be 10 80       	push   $0x8010bef1
8010a636:	ff 75 0c             	pushl  0xc(%ebp)
8010a639:	ff 75 08             	pushl  0x8(%ebp)
8010a63c:	e8 5c 02 00 00       	call   8010a89d <printfmt>
8010a641:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
8010a644:	e9 47 02 00 00       	jmp    8010a890 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
8010a649:	56                   	push   %esi
8010a64a:	68 fa be 10 80       	push   $0x8010befa
8010a64f:	ff 75 0c             	pushl  0xc(%ebp)
8010a652:	ff 75 08             	pushl  0x8(%ebp)
8010a655:	e8 43 02 00 00       	call   8010a89d <printfmt>
8010a65a:	83 c4 10             	add    $0x10,%esp
      break;
8010a65d:	e9 2e 02 00 00       	jmp    8010a890 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
8010a662:	8b 45 14             	mov    0x14(%ebp),%eax
8010a665:	8d 50 04             	lea    0x4(%eax),%edx
8010a668:	89 55 14             	mov    %edx,0x14(%ebp)
8010a66b:	8b 30                	mov    (%eax),%esi
8010a66d:	85 f6                	test   %esi,%esi
8010a66f:	75 05                	jne    8010a676 <vprintfmt+0x193>
        p = "(null)";
8010a671:	be fd be 10 80       	mov    $0x8010befd,%esi
      if (width > 0 && padc != '-')
8010a676:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010a67a:	7e 6f                	jle    8010a6eb <vprintfmt+0x208>
8010a67c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
8010a680:	74 69                	je     8010a6eb <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
8010a682:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010a685:	83 ec 08             	sub    $0x8,%esp
8010a688:	50                   	push   %eax
8010a689:	56                   	push   %esi
8010a68a:	e8 a7 c3 ff ff       	call   80106a36 <strnlen>
8010a68f:	83 c4 10             	add    $0x10,%esp
8010a692:	29 45 e4             	sub    %eax,-0x1c(%ebp)
8010a695:	eb 17                	jmp    8010a6ae <vprintfmt+0x1cb>
          putch(padc, putdat);
8010a697:	0f be 45 db          	movsbl -0x25(%ebp),%eax
8010a69b:	83 ec 08             	sub    $0x8,%esp
8010a69e:	ff 75 0c             	pushl  0xc(%ebp)
8010a6a1:	50                   	push   %eax
8010a6a2:	8b 45 08             	mov    0x8(%ebp),%eax
8010a6a5:	ff d0                	call   *%eax
8010a6a7:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
8010a6aa:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
8010a6ae:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010a6b2:	7f e3                	jg     8010a697 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
8010a6b4:	eb 35                	jmp    8010a6eb <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
8010a6b6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
8010a6ba:	74 1c                	je     8010a6d8 <vprintfmt+0x1f5>
8010a6bc:	83 fb 1f             	cmp    $0x1f,%ebx
8010a6bf:	7e 05                	jle    8010a6c6 <vprintfmt+0x1e3>
8010a6c1:	83 fb 7e             	cmp    $0x7e,%ebx
8010a6c4:	7e 12                	jle    8010a6d8 <vprintfmt+0x1f5>
          putch('?', putdat);
8010a6c6:	83 ec 08             	sub    $0x8,%esp
8010a6c9:	ff 75 0c             	pushl  0xc(%ebp)
8010a6cc:	6a 3f                	push   $0x3f
8010a6ce:	8b 45 08             	mov    0x8(%ebp),%eax
8010a6d1:	ff d0                	call   *%eax
8010a6d3:	83 c4 10             	add    $0x10,%esp
8010a6d6:	eb 0f                	jmp    8010a6e7 <vprintfmt+0x204>
        else
          putch(ch, putdat);
8010a6d8:	83 ec 08             	sub    $0x8,%esp
8010a6db:	ff 75 0c             	pushl  0xc(%ebp)
8010a6de:	53                   	push   %ebx
8010a6df:	8b 45 08             	mov    0x8(%ebp),%eax
8010a6e2:	ff d0                	call   *%eax
8010a6e4:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
8010a6e7:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
8010a6eb:	89 f0                	mov    %esi,%eax
8010a6ed:	8d 70 01             	lea    0x1(%eax),%esi
8010a6f0:	0f b6 00             	movzbl (%eax),%eax
8010a6f3:	0f be d8             	movsbl %al,%ebx
8010a6f6:	85 db                	test   %ebx,%ebx
8010a6f8:	74 26                	je     8010a720 <vprintfmt+0x23d>
8010a6fa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010a6fe:	78 b6                	js     8010a6b6 <vprintfmt+0x1d3>
8010a700:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
8010a704:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010a708:	79 ac                	jns    8010a6b6 <vprintfmt+0x1d3>
      for (; width > 0; width--)
8010a70a:	eb 14                	jmp    8010a720 <vprintfmt+0x23d>
        putch(' ', putdat);
8010a70c:	83 ec 08             	sub    $0x8,%esp
8010a70f:	ff 75 0c             	pushl  0xc(%ebp)
8010a712:	6a 20                	push   $0x20
8010a714:	8b 45 08             	mov    0x8(%ebp),%eax
8010a717:	ff d0                	call   *%eax
8010a719:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
8010a71c:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
8010a720:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010a724:	7f e6                	jg     8010a70c <vprintfmt+0x229>
      break;
8010a726:	e9 65 01 00 00       	jmp    8010a890 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
8010a72b:	83 ec 08             	sub    $0x8,%esp
8010a72e:	ff 75 e8             	pushl  -0x18(%ebp)
8010a731:	8d 45 14             	lea    0x14(%ebp),%eax
8010a734:	50                   	push   %eax
8010a735:	e8 62 fd ff ff       	call   8010a49c <getint>
8010a73a:	83 c4 10             	add    $0x10,%esp
8010a73d:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a740:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
8010a743:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a746:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a749:	85 d2                	test   %edx,%edx
8010a74b:	79 23                	jns    8010a770 <vprintfmt+0x28d>
        putch('-', putdat);
8010a74d:	83 ec 08             	sub    $0x8,%esp
8010a750:	ff 75 0c             	pushl  0xc(%ebp)
8010a753:	6a 2d                	push   $0x2d
8010a755:	8b 45 08             	mov    0x8(%ebp),%eax
8010a758:	ff d0                	call   *%eax
8010a75a:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
8010a75d:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a760:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a763:	f7 d8                	neg    %eax
8010a765:	83 d2 00             	adc    $0x0,%edx
8010a768:	f7 da                	neg    %edx
8010a76a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a76d:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
8010a770:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
8010a777:	e9 b6 00 00 00       	jmp    8010a832 <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
8010a77c:	83 ec 08             	sub    $0x8,%esp
8010a77f:	ff 75 e8             	pushl  -0x18(%ebp)
8010a782:	8d 45 14             	lea    0x14(%ebp),%eax
8010a785:	50                   	push   %eax
8010a786:	e8 c2 fc ff ff       	call   8010a44d <getuint>
8010a78b:	83 c4 10             	add    $0x10,%esp
8010a78e:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a791:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
8010a794:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
8010a79b:	e9 92 00 00 00       	jmp    8010a832 <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
8010a7a0:	83 ec 08             	sub    $0x8,%esp
8010a7a3:	ff 75 0c             	pushl  0xc(%ebp)
8010a7a6:	6a 58                	push   $0x58
8010a7a8:	8b 45 08             	mov    0x8(%ebp),%eax
8010a7ab:	ff d0                	call   *%eax
8010a7ad:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
8010a7b0:	83 ec 08             	sub    $0x8,%esp
8010a7b3:	ff 75 0c             	pushl  0xc(%ebp)
8010a7b6:	6a 58                	push   $0x58
8010a7b8:	8b 45 08             	mov    0x8(%ebp),%eax
8010a7bb:	ff d0                	call   *%eax
8010a7bd:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
8010a7c0:	83 ec 08             	sub    $0x8,%esp
8010a7c3:	ff 75 0c             	pushl  0xc(%ebp)
8010a7c6:	6a 58                	push   $0x58
8010a7c8:	8b 45 08             	mov    0x8(%ebp),%eax
8010a7cb:	ff d0                	call   *%eax
8010a7cd:	83 c4 10             	add    $0x10,%esp
      break;
8010a7d0:	e9 bb 00 00 00       	jmp    8010a890 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
8010a7d5:	83 ec 08             	sub    $0x8,%esp
8010a7d8:	ff 75 0c             	pushl  0xc(%ebp)
8010a7db:	6a 30                	push   $0x30
8010a7dd:	8b 45 08             	mov    0x8(%ebp),%eax
8010a7e0:	ff d0                	call   *%eax
8010a7e2:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
8010a7e5:	83 ec 08             	sub    $0x8,%esp
8010a7e8:	ff 75 0c             	pushl  0xc(%ebp)
8010a7eb:	6a 78                	push   $0x78
8010a7ed:	8b 45 08             	mov    0x8(%ebp),%eax
8010a7f0:	ff d0                	call   *%eax
8010a7f2:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
8010a7f5:	8b 45 14             	mov    0x14(%ebp),%eax
8010a7f8:	8d 50 04             	lea    0x4(%eax),%edx
8010a7fb:	89 55 14             	mov    %edx,0x14(%ebp)
8010a7fe:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
8010a800:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a803:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
8010a80a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
8010a811:	eb 1f                	jmp    8010a832 <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
8010a813:	83 ec 08             	sub    $0x8,%esp
8010a816:	ff 75 e8             	pushl  -0x18(%ebp)
8010a819:	8d 45 14             	lea    0x14(%ebp),%eax
8010a81c:	50                   	push   %eax
8010a81d:	e8 2b fc ff ff       	call   8010a44d <getuint>
8010a822:	83 c4 10             	add    $0x10,%esp
8010a825:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a828:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
8010a82b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
8010a832:	0f be 55 db          	movsbl -0x25(%ebp),%edx
8010a836:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a839:	83 ec 04             	sub    $0x4,%esp
8010a83c:	52                   	push   %edx
8010a83d:	ff 75 e4             	pushl  -0x1c(%ebp)
8010a840:	50                   	push   %eax
8010a841:	ff 75 f4             	pushl  -0xc(%ebp)
8010a844:	ff 75 f0             	pushl  -0x10(%ebp)
8010a847:	ff 75 0c             	pushl  0xc(%ebp)
8010a84a:	ff 75 08             	pushl  0x8(%ebp)
8010a84d:	e8 42 fb ff ff       	call   8010a394 <printnum>
8010a852:	83 c4 20             	add    $0x20,%esp
      break;
8010a855:	eb 39                	jmp    8010a890 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
8010a857:	83 ec 08             	sub    $0x8,%esp
8010a85a:	ff 75 0c             	pushl  0xc(%ebp)
8010a85d:	53                   	push   %ebx
8010a85e:	8b 45 08             	mov    0x8(%ebp),%eax
8010a861:	ff d0                	call   *%eax
8010a863:	83 c4 10             	add    $0x10,%esp
      break;
8010a866:	eb 28                	jmp    8010a890 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
8010a868:	83 ec 08             	sub    $0x8,%esp
8010a86b:	ff 75 0c             	pushl  0xc(%ebp)
8010a86e:	6a 25                	push   $0x25
8010a870:	8b 45 08             	mov    0x8(%ebp),%eax
8010a873:	ff d0                	call   *%eax
8010a875:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
8010a878:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010a87c:	eb 04                	jmp    8010a882 <vprintfmt+0x39f>
8010a87e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010a882:	8b 45 10             	mov    0x10(%ebp),%eax
8010a885:	83 e8 01             	sub    $0x1,%eax
8010a888:	0f b6 00             	movzbl (%eax),%eax
8010a88b:	3c 25                	cmp    $0x25,%al
8010a88d:	75 ef                	jne    8010a87e <vprintfmt+0x39b>
        /* do nothing */;
      break;
8010a88f:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
8010a890:	e9 6f fc ff ff       	jmp    8010a504 <vprintfmt+0x21>
        return;
8010a895:	90                   	nop
    }
  }
}
8010a896:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010a899:	5b                   	pop    %ebx
8010a89a:	5e                   	pop    %esi
8010a89b:	5d                   	pop    %ebp
8010a89c:	c3                   	ret    

8010a89d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
8010a89d:	55                   	push   %ebp
8010a89e:	89 e5                	mov    %esp,%ebp
8010a8a0:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
8010a8a3:	8d 45 14             	lea    0x14(%ebp),%eax
8010a8a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
8010a8a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a8ac:	50                   	push   %eax
8010a8ad:	ff 75 10             	pushl  0x10(%ebp)
8010a8b0:	ff 75 0c             	pushl  0xc(%ebp)
8010a8b3:	ff 75 08             	pushl  0x8(%ebp)
8010a8b6:	e8 28 fc ff ff       	call   8010a4e3 <vprintfmt>
8010a8bb:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
8010a8be:	90                   	nop
8010a8bf:	c9                   	leave  
8010a8c0:	c3                   	ret    

8010a8c1 <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
8010a8c1:	55                   	push   %ebp
8010a8c2:	89 e5                	mov    %esp,%ebp
  b->cnt++;
8010a8c4:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a8c7:	8b 40 08             	mov    0x8(%eax),%eax
8010a8ca:	8d 50 01             	lea    0x1(%eax),%edx
8010a8cd:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a8d0:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
8010a8d3:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a8d6:	8b 10                	mov    (%eax),%edx
8010a8d8:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a8db:	8b 40 04             	mov    0x4(%eax),%eax
8010a8de:	39 c2                	cmp    %eax,%edx
8010a8e0:	73 12                	jae    8010a8f4 <sprintputch+0x33>
    *b->buf++ = ch;
8010a8e2:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a8e5:	8b 00                	mov    (%eax),%eax
8010a8e7:	8d 48 01             	lea    0x1(%eax),%ecx
8010a8ea:	8b 55 0c             	mov    0xc(%ebp),%edx
8010a8ed:	89 0a                	mov    %ecx,(%edx)
8010a8ef:	8b 55 08             	mov    0x8(%ebp),%edx
8010a8f2:	88 10                	mov    %dl,(%eax)
}
8010a8f4:	90                   	nop
8010a8f5:	5d                   	pop    %ebp
8010a8f6:	c3                   	ret    

8010a8f7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
8010a8f7:	55                   	push   %ebp
8010a8f8:	89 e5                	mov    %esp,%ebp
8010a8fa:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
8010a8fd:	8b 45 08             	mov    0x8(%ebp),%eax
8010a900:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010a903:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a906:	8d 50 ff             	lea    -0x1(%eax),%edx
8010a909:	8b 45 08             	mov    0x8(%ebp),%eax
8010a90c:	01 d0                	add    %edx,%eax
8010a90e:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a911:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
8010a918:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010a91c:	74 06                	je     8010a924 <vsnprintf+0x2d>
8010a91e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010a922:	7f 07                	jg     8010a92b <vsnprintf+0x34>
    return -E_INVAL;
8010a924:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
8010a929:	eb 20                	jmp    8010a94b <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
8010a92b:	ff 75 14             	pushl  0x14(%ebp)
8010a92e:	ff 75 10             	pushl  0x10(%ebp)
8010a931:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010a934:	50                   	push   %eax
8010a935:	68 c1 a8 10 80       	push   $0x8010a8c1
8010a93a:	e8 a4 fb ff ff       	call   8010a4e3 <vprintfmt>
8010a93f:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
8010a942:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a945:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
8010a948:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010a94b:	c9                   	leave  
8010a94c:	c3                   	ret    

8010a94d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
8010a94d:	55                   	push   %ebp
8010a94e:	89 e5                	mov    %esp,%ebp
8010a950:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
8010a953:	8d 45 14             	lea    0x14(%ebp),%eax
8010a956:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
8010a959:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a95c:	50                   	push   %eax
8010a95d:	ff 75 10             	pushl  0x10(%ebp)
8010a960:	ff 75 0c             	pushl  0xc(%ebp)
8010a963:	ff 75 08             	pushl  0x8(%ebp)
8010a966:	e8 8c ff ff ff       	call   8010a8f7 <vsnprintf>
8010a96b:	83 c4 10             	add    $0x10,%esp
8010a96e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
8010a971:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010a974:	c9                   	leave  
8010a975:	c3                   	ret    

8010a976 <stab_binsearch>:
//	will exit setting left = 118, right = 554.
//
static void
stab_binsearch(const struct Stab *stabs, int *region_left, int *region_right,
               int type, uint addr)
{
8010a976:	55                   	push   %ebp
8010a977:	89 e5                	mov    %esp,%ebp
8010a979:	83 ec 20             	sub    $0x20,%esp
  int l = *region_left, r = *region_right, any_matches = 0;
8010a97c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a97f:	8b 00                	mov    (%eax),%eax
8010a981:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010a984:	8b 45 10             	mov    0x10(%ebp),%eax
8010a987:	8b 00                	mov    (%eax),%eax
8010a989:	89 45 f8             	mov    %eax,-0x8(%ebp)
8010a98c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  while (l <= r) {
8010a993:	e9 d2 00 00 00       	jmp    8010aa6a <stab_binsearch+0xf4>
    int true_m = (l + r) / 2, m = true_m;
8010a998:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010a99b:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010a99e:	01 d0                	add    %edx,%eax
8010a9a0:	89 c2                	mov    %eax,%edx
8010a9a2:	c1 ea 1f             	shr    $0x1f,%edx
8010a9a5:	01 d0                	add    %edx,%eax
8010a9a7:	d1 f8                	sar    %eax
8010a9a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010a9ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a9af:	89 45 f0             	mov    %eax,-0x10(%ebp)

    // search for earliest stab with right type
    while (m >= l && stabs[m].n_type != type)
8010a9b2:	eb 04                	jmp    8010a9b8 <stab_binsearch+0x42>
      m--;
8010a9b4:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
    while (m >= l && stabs[m].n_type != type)
8010a9b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a9bb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
8010a9be:	7c 1f                	jl     8010a9df <stab_binsearch+0x69>
8010a9c0:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010a9c3:	89 d0                	mov    %edx,%eax
8010a9c5:	01 c0                	add    %eax,%eax
8010a9c7:	01 d0                	add    %edx,%eax
8010a9c9:	c1 e0 02             	shl    $0x2,%eax
8010a9cc:	89 c2                	mov    %eax,%edx
8010a9ce:	8b 45 08             	mov    0x8(%ebp),%eax
8010a9d1:	01 d0                	add    %edx,%eax
8010a9d3:	0f b6 40 04          	movzbl 0x4(%eax),%eax
8010a9d7:	0f b6 c0             	movzbl %al,%eax
8010a9da:	39 45 14             	cmp    %eax,0x14(%ebp)
8010a9dd:	75 d5                	jne    8010a9b4 <stab_binsearch+0x3e>
    if (m < l) {                // no match in [l, m]
8010a9df:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a9e2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
8010a9e5:	7d 0b                	jge    8010a9f2 <stab_binsearch+0x7c>
      l = true_m + 1;
8010a9e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a9ea:	83 c0 01             	add    $0x1,%eax
8010a9ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
      continue;
8010a9f0:	eb 78                	jmp    8010aa6a <stab_binsearch+0xf4>
    }

    // actual binary search
    any_matches = 1;
8010a9f2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    if (stabs[m].n_value < addr) {
8010a9f9:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010a9fc:	89 d0                	mov    %edx,%eax
8010a9fe:	01 c0                	add    %eax,%eax
8010aa00:	01 d0                	add    %edx,%eax
8010aa02:	c1 e0 02             	shl    $0x2,%eax
8010aa05:	89 c2                	mov    %eax,%edx
8010aa07:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa0a:	01 d0                	add    %edx,%eax
8010aa0c:	8b 40 08             	mov    0x8(%eax),%eax
8010aa0f:	39 45 18             	cmp    %eax,0x18(%ebp)
8010aa12:	76 13                	jbe    8010aa27 <stab_binsearch+0xb1>
      *region_left = m;
8010aa14:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa17:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010aa1a:	89 10                	mov    %edx,(%eax)
      l = true_m + 1;
8010aa1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010aa1f:	83 c0 01             	add    $0x1,%eax
8010aa22:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010aa25:	eb 43                	jmp    8010aa6a <stab_binsearch+0xf4>
    } else if (stabs[m].n_value > addr) {
8010aa27:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010aa2a:	89 d0                	mov    %edx,%eax
8010aa2c:	01 c0                	add    %eax,%eax
8010aa2e:	01 d0                	add    %edx,%eax
8010aa30:	c1 e0 02             	shl    $0x2,%eax
8010aa33:	89 c2                	mov    %eax,%edx
8010aa35:	8b 45 08             	mov    0x8(%ebp),%eax
8010aa38:	01 d0                	add    %edx,%eax
8010aa3a:	8b 40 08             	mov    0x8(%eax),%eax
8010aa3d:	39 45 18             	cmp    %eax,0x18(%ebp)
8010aa40:	73 16                	jae    8010aa58 <stab_binsearch+0xe2>
      *region_right = m - 1;
8010aa42:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010aa45:	8d 50 ff             	lea    -0x1(%eax),%edx
8010aa48:	8b 45 10             	mov    0x10(%ebp),%eax
8010aa4b:	89 10                	mov    %edx,(%eax)
      r = m - 1;
8010aa4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010aa50:	83 e8 01             	sub    $0x1,%eax
8010aa53:	89 45 f8             	mov    %eax,-0x8(%ebp)
8010aa56:	eb 12                	jmp    8010aa6a <stab_binsearch+0xf4>
    } else {
      // exact match for 'addr', but continue loop to find
      // *region_right
      *region_left = m;
8010aa58:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa5b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010aa5e:	89 10                	mov    %edx,(%eax)
      l = m;
8010aa60:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010aa63:	89 45 fc             	mov    %eax,-0x4(%ebp)
      addr++;
8010aa66:	83 45 18 01          	addl   $0x1,0x18(%ebp)
  while (l <= r) {
8010aa6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010aa6d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010aa70:	0f 8e 22 ff ff ff    	jle    8010a998 <stab_binsearch+0x22>
    }
  }

  if (!any_matches)
8010aa76:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010aa7a:	75 0f                	jne    8010aa8b <stab_binsearch+0x115>
    *region_right = *region_left - 1;
8010aa7c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa7f:	8b 00                	mov    (%eax),%eax
8010aa81:	8d 50 ff             	lea    -0x1(%eax),%edx
8010aa84:	8b 45 10             	mov    0x10(%ebp),%eax
8010aa87:	89 10                	mov    %edx,(%eax)
         l > *region_left && stabs[l].n_type != type;
         l--)
      /* do nothing */;
    *region_left = l;
  }
}
8010aa89:	eb 3f                	jmp    8010aaca <stab_binsearch+0x154>
    for (l = *region_right;
8010aa8b:	8b 45 10             	mov    0x10(%ebp),%eax
8010aa8e:	8b 00                	mov    (%eax),%eax
8010aa90:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010aa93:	eb 04                	jmp    8010aa99 <stab_binsearch+0x123>
         l--)
8010aa95:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
         l > *region_left && stabs[l].n_type != type;
8010aa99:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aa9c:	8b 00                	mov    (%eax),%eax
    for (l = *region_right;
8010aa9e:	39 45 fc             	cmp    %eax,-0x4(%ebp)
8010aaa1:	7e 1f                	jle    8010aac2 <stab_binsearch+0x14c>
         l > *region_left && stabs[l].n_type != type;
8010aaa3:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010aaa6:	89 d0                	mov    %edx,%eax
8010aaa8:	01 c0                	add    %eax,%eax
8010aaaa:	01 d0                	add    %edx,%eax
8010aaac:	c1 e0 02             	shl    $0x2,%eax
8010aaaf:	89 c2                	mov    %eax,%edx
8010aab1:	8b 45 08             	mov    0x8(%ebp),%eax
8010aab4:	01 d0                	add    %edx,%eax
8010aab6:	0f b6 40 04          	movzbl 0x4(%eax),%eax
8010aaba:	0f b6 c0             	movzbl %al,%eax
8010aabd:	39 45 14             	cmp    %eax,0x14(%ebp)
8010aac0:	75 d3                	jne    8010aa95 <stab_binsearch+0x11f>
    *region_left = l;
8010aac2:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aac5:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010aac8:	89 10                	mov    %edx,(%eax)
}
8010aaca:	90                   	nop
8010aacb:	c9                   	leave  
8010aacc:	c3                   	ret    

8010aacd <debuginfo_eip>:
//	negative if not.  But even if it returns negative it has stored some
//	information into '*info'.
//
int
debuginfo_eip(uint addr, struct Eipdebuginfo *info)
{
8010aacd:	55                   	push   %ebp
8010aace:	89 e5                	mov    %esp,%ebp
8010aad0:	83 ec 38             	sub    $0x38,%esp
  const struct Stab *stabs, *stab_end;
  const char *stabstr, *stabstr_end;
  int lfile, rfile, lfun, rfun, lline, rline;

  // Initialize *info
  info->eip_file = "<unknown>";
8010aad3:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aad6:	c7 00 5c c0 10 80    	movl   $0x8010c05c,(%eax)
  info->eip_line = 0;
8010aadc:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aadf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  info->eip_fn_name = "<unknown>";
8010aae6:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aae9:	c7 40 08 5c c0 10 80 	movl   $0x8010c05c,0x8(%eax)
  info->eip_fn_namelen = 9;
8010aaf0:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aaf3:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
  info->eip_fn_addr = addr;
8010aafa:	8b 45 0c             	mov    0xc(%ebp),%eax
8010aafd:	8b 55 08             	mov    0x8(%ebp),%edx
8010ab00:	89 50 10             	mov    %edx,0x10(%eax)
  info->eip_fn_narg = 0;
8010ab03:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ab06:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

  // Find the relevant set of stabs
  if (addr >= KERNBASE) {
8010ab0d:	8b 45 08             	mov    0x8(%ebp),%eax
8010ab10:	85 c0                	test   %eax,%eax
8010ab12:	79 26                	jns    8010ab3a <debuginfo_eip+0x6d>
    stabs = __STAB_BEGIN__;
8010ab14:	c7 45 f0 74 c0 10 80 	movl   $0x8010c074,-0x10(%ebp)
    stab_end = __STAB_END__;
8010ab1b:	c7 45 ec 4c f3 11 80 	movl   $0x8011f34c,-0x14(%ebp)
    stabstr = __STABSTR_BEGIN__;
8010ab22:	c7 45 e8 4d f3 11 80 	movl   $0x8011f34d,-0x18(%ebp)
    stabstr_end = __STABSTR_END__;
8010ab29:	c7 45 e4 89 6c 12 80 	movl   $0x80126c89,-0x1c(%ebp)
    // Can't search for user-level addresses yet!
    panic("User address");
  }

  // String table validity checks
  if (stabstr_end <= stabstr || stabstr_end[-1] != 0)
8010ab30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010ab33:	3b 45 e8             	cmp    -0x18(%ebp),%eax
8010ab36:	76 1c                	jbe    8010ab54 <debuginfo_eip+0x87>
8010ab38:	eb 0d                	jmp    8010ab47 <debuginfo_eip+0x7a>
    panic("User address");
8010ab3a:	83 ec 0c             	sub    $0xc,%esp
8010ab3d:	68 66 c0 10 80       	push   $0x8010c066
8010ab42:	e8 f7 62 ff ff       	call   80100e3e <panic>
  if (stabstr_end <= stabstr || stabstr_end[-1] != 0)
8010ab47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010ab4a:	83 e8 01             	sub    $0x1,%eax
8010ab4d:	0f b6 00             	movzbl (%eax),%eax
8010ab50:	84 c0                	test   %al,%al
8010ab52:	74 0a                	je     8010ab5e <debuginfo_eip+0x91>
    return -1;
8010ab54:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010ab59:	e9 2a 02 00 00       	jmp    8010ad88 <debuginfo_eip+0x2bb>
  // 'eip'.  First, we find the basic source file containing 'eip'.
  // Then, we look in that source file for the function.  Then we look
  // for the line number.

  // Search the entire set of stabs for the source file (type N_SO).
  lfile = 0;
8010ab5e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  rfile = (stab_end - stabs) - 1;
8010ab65:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010ab68:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010ab6b:	29 c2                	sub    %eax,%edx
8010ab6d:	89 d0                	mov    %edx,%eax
8010ab6f:	c1 f8 02             	sar    $0x2,%eax
8010ab72:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
8010ab78:	83 e8 01             	sub    $0x1,%eax
8010ab7b:	89 45 d8             	mov    %eax,-0x28(%ebp)
  stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
8010ab7e:	83 ec 0c             	sub    $0xc,%esp
8010ab81:	ff 75 08             	pushl  0x8(%ebp)
8010ab84:	6a 64                	push   $0x64
8010ab86:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010ab89:	50                   	push   %eax
8010ab8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010ab8d:	50                   	push   %eax
8010ab8e:	ff 75 f0             	pushl  -0x10(%ebp)
8010ab91:	e8 e0 fd ff ff       	call   8010a976 <stab_binsearch>
8010ab96:	83 c4 20             	add    $0x20,%esp
  if (lfile == 0)
8010ab99:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010ab9c:	85 c0                	test   %eax,%eax
8010ab9e:	75 0a                	jne    8010abaa <debuginfo_eip+0xdd>
    return -1;
8010aba0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010aba5:	e9 de 01 00 00       	jmp    8010ad88 <debuginfo_eip+0x2bb>

  // Search within that file's stabs for the function definition
  // (N_FUN).
  lfun = lfile;
8010abaa:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010abad:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  rfun = rfile;
8010abb0:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010abb3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
8010abb6:	83 ec 0c             	sub    $0xc,%esp
8010abb9:	ff 75 08             	pushl  0x8(%ebp)
8010abbc:	6a 24                	push   $0x24
8010abbe:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010abc1:	50                   	push   %eax
8010abc2:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010abc5:	50                   	push   %eax
8010abc6:	ff 75 f0             	pushl  -0x10(%ebp)
8010abc9:	e8 a8 fd ff ff       	call   8010a976 <stab_binsearch>
8010abce:	83 c4 20             	add    $0x20,%esp

  if (lfun <= rfun) {
8010abd1:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010abd4:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010abd7:	39 c2                	cmp    %eax,%edx
8010abd9:	7f 7c                	jg     8010ac57 <debuginfo_eip+0x18a>
    // stabs[lfun] points to the function name
    // in the string table, but check bounds just in case.
    if (stabs[lfun].n_strx < stabstr_end - stabstr)
8010abdb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010abde:	89 c2                	mov    %eax,%edx
8010abe0:	89 d0                	mov    %edx,%eax
8010abe2:	01 c0                	add    %eax,%eax
8010abe4:	01 d0                	add    %edx,%eax
8010abe6:	c1 e0 02             	shl    $0x2,%eax
8010abe9:	89 c2                	mov    %eax,%edx
8010abeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010abee:	01 d0                	add    %edx,%eax
8010abf0:	8b 00                	mov    (%eax),%eax
8010abf2:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010abf5:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010abf8:	29 d1                	sub    %edx,%ecx
8010abfa:	89 ca                	mov    %ecx,%edx
8010abfc:	39 d0                	cmp    %edx,%eax
8010abfe:	73 22                	jae    8010ac22 <debuginfo_eip+0x155>
      info->eip_fn_name = stabstr + stabs[lfun].n_strx;
8010ac00:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010ac03:	89 c2                	mov    %eax,%edx
8010ac05:	89 d0                	mov    %edx,%eax
8010ac07:	01 c0                	add    %eax,%eax
8010ac09:	01 d0                	add    %edx,%eax
8010ac0b:	c1 e0 02             	shl    $0x2,%eax
8010ac0e:	89 c2                	mov    %eax,%edx
8010ac10:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010ac13:	01 d0                	add    %edx,%eax
8010ac15:	8b 10                	mov    (%eax),%edx
8010ac17:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010ac1a:	01 c2                	add    %eax,%edx
8010ac1c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac1f:	89 50 08             	mov    %edx,0x8(%eax)
    info->eip_fn_addr = stabs[lfun].n_value;
8010ac22:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010ac25:	89 c2                	mov    %eax,%edx
8010ac27:	89 d0                	mov    %edx,%eax
8010ac29:	01 c0                	add    %eax,%eax
8010ac2b:	01 d0                	add    %edx,%eax
8010ac2d:	c1 e0 02             	shl    $0x2,%eax
8010ac30:	89 c2                	mov    %eax,%edx
8010ac32:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010ac35:	01 d0                	add    %edx,%eax
8010ac37:	8b 50 08             	mov    0x8(%eax),%edx
8010ac3a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac3d:	89 50 10             	mov    %edx,0x10(%eax)
    addr -= info->eip_fn_addr;
8010ac40:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac43:	8b 40 10             	mov    0x10(%eax),%eax
8010ac46:	29 45 08             	sub    %eax,0x8(%ebp)
    // Search within the function definition for the line number.
    lline = lfun;
8010ac49:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010ac4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    rline = rfun;
8010ac4f:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010ac52:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010ac55:	eb 15                	jmp    8010ac6c <debuginfo_eip+0x19f>
  } else {
    // Couldn't find function stab!  Maybe we're in an assembly
    // file.  Search the whole file for the line number.
    info->eip_fn_addr = addr;
8010ac57:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac5a:	8b 55 08             	mov    0x8(%ebp),%edx
8010ac5d:	89 50 10             	mov    %edx,0x10(%eax)
    lline = lfile;
8010ac60:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010ac63:	89 45 f4             	mov    %eax,-0xc(%ebp)
    rline = rfile;
8010ac66:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010ac69:	89 45 e0             	mov    %eax,-0x20(%ebp)
  }
  // Ignore stuff after the colon.
  info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
8010ac6c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac6f:	8b 40 08             	mov    0x8(%eax),%eax
8010ac72:	83 ec 08             	sub    $0x8,%esp
8010ac75:	6a 3a                	push   $0x3a
8010ac77:	50                   	push   %eax
8010ac78:	e8 cc be ff ff       	call   80106b49 <strfind>
8010ac7d:	83 c4 10             	add    $0x10,%esp
8010ac80:	89 c2                	mov    %eax,%edx
8010ac82:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac85:	8b 40 08             	mov    0x8(%eax),%eax
8010ac88:	29 c2                	sub    %eax,%edx
8010ac8a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ac8d:	89 50 0c             	mov    %edx,0xc(%eax)
  // Search backwards from the line number for the relevant filename
  // stab.
  // We can't just use the "lfile" stab because inlined functions
  // can interpolate code from a different file!
  // Such included source files use the N_SOL stab type.
  while (lline >= lfile
8010ac90:	eb 04                	jmp    8010ac96 <debuginfo_eip+0x1c9>
         && stabs[lline].n_type != N_SOL
         && (stabs[lline].n_type != N_SO || !stabs[lline].n_value))
    lline--;
8010ac92:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  while (lline >= lfile
8010ac96:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010ac99:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010ac9c:	7c 50                	jl     8010acee <debuginfo_eip+0x221>
         && stabs[lline].n_type != N_SOL
8010ac9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010aca1:	89 d0                	mov    %edx,%eax
8010aca3:	01 c0                	add    %eax,%eax
8010aca5:	01 d0                	add    %edx,%eax
8010aca7:	c1 e0 02             	shl    $0x2,%eax
8010acaa:	89 c2                	mov    %eax,%edx
8010acac:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010acaf:	01 d0                	add    %edx,%eax
8010acb1:	0f b6 40 04          	movzbl 0x4(%eax),%eax
8010acb5:	3c 84                	cmp    $0x84,%al
8010acb7:	74 35                	je     8010acee <debuginfo_eip+0x221>
         && (stabs[lline].n_type != N_SO || !stabs[lline].n_value))
8010acb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010acbc:	89 d0                	mov    %edx,%eax
8010acbe:	01 c0                	add    %eax,%eax
8010acc0:	01 d0                	add    %edx,%eax
8010acc2:	c1 e0 02             	shl    $0x2,%eax
8010acc5:	89 c2                	mov    %eax,%edx
8010acc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010acca:	01 d0                	add    %edx,%eax
8010accc:	0f b6 40 04          	movzbl 0x4(%eax),%eax
8010acd0:	3c 64                	cmp    $0x64,%al
8010acd2:	75 be                	jne    8010ac92 <debuginfo_eip+0x1c5>
8010acd4:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010acd7:	89 d0                	mov    %edx,%eax
8010acd9:	01 c0                	add    %eax,%eax
8010acdb:	01 d0                	add    %edx,%eax
8010acdd:	c1 e0 02             	shl    $0x2,%eax
8010ace0:	89 c2                	mov    %eax,%edx
8010ace2:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010ace5:	01 d0                	add    %edx,%eax
8010ace7:	8b 40 08             	mov    0x8(%eax),%eax
8010acea:	85 c0                	test   %eax,%eax
8010acec:	74 a4                	je     8010ac92 <debuginfo_eip+0x1c5>
  if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr)
8010acee:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010acf1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010acf4:	7c 42                	jl     8010ad38 <debuginfo_eip+0x26b>
8010acf6:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010acf9:	89 d0                	mov    %edx,%eax
8010acfb:	01 c0                	add    %eax,%eax
8010acfd:	01 d0                	add    %edx,%eax
8010acff:	c1 e0 02             	shl    $0x2,%eax
8010ad02:	89 c2                	mov    %eax,%edx
8010ad04:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010ad07:	01 d0                	add    %edx,%eax
8010ad09:	8b 00                	mov    (%eax),%eax
8010ad0b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010ad0e:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010ad11:	29 d1                	sub    %edx,%ecx
8010ad13:	89 ca                	mov    %ecx,%edx
8010ad15:	39 d0                	cmp    %edx,%eax
8010ad17:	73 1f                	jae    8010ad38 <debuginfo_eip+0x26b>
    info->eip_file = stabstr + stabs[lline].n_strx;
8010ad19:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ad1c:	89 d0                	mov    %edx,%eax
8010ad1e:	01 c0                	add    %eax,%eax
8010ad20:	01 d0                	add    %edx,%eax
8010ad22:	c1 e0 02             	shl    $0x2,%eax
8010ad25:	89 c2                	mov    %eax,%edx
8010ad27:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010ad2a:	01 d0                	add    %edx,%eax
8010ad2c:	8b 10                	mov    (%eax),%edx
8010ad2e:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010ad31:	01 c2                	add    %eax,%edx
8010ad33:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad36:	89 10                	mov    %edx,(%eax)


  // Set eip_fn_narg to the number of arguments taken by the function,
  // or 0 if there was no containing function.
  if (lfun < rfun)
8010ad38:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010ad3b:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010ad3e:	39 c2                	cmp    %eax,%edx
8010ad40:	7d 41                	jge    8010ad83 <debuginfo_eip+0x2b6>
    for (lline = lfun + 1;
8010ad42:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010ad45:	83 c0 01             	add    $0x1,%eax
8010ad48:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010ad4b:	eb 13                	jmp    8010ad60 <debuginfo_eip+0x293>
         lline < rfun && stabs[lline].n_type == N_PSYM;
         lline++)
      info->eip_fn_narg++;
8010ad4d:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad50:	8b 40 14             	mov    0x14(%eax),%eax
8010ad53:	8d 50 01             	lea    0x1(%eax),%edx
8010ad56:	8b 45 0c             	mov    0xc(%ebp),%eax
8010ad59:	89 50 14             	mov    %edx,0x14(%eax)
         lline++)
8010ad5c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
         lline < rfun && stabs[lline].n_type == N_PSYM;
8010ad60:	8b 45 d0             	mov    -0x30(%ebp),%eax
    for (lline = lfun + 1;
8010ad63:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010ad66:	7d 1b                	jge    8010ad83 <debuginfo_eip+0x2b6>
         lline < rfun && stabs[lline].n_type == N_PSYM;
8010ad68:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010ad6b:	89 d0                	mov    %edx,%eax
8010ad6d:	01 c0                	add    %eax,%eax
8010ad6f:	01 d0                	add    %edx,%eax
8010ad71:	c1 e0 02             	shl    $0x2,%eax
8010ad74:	89 c2                	mov    %eax,%edx
8010ad76:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010ad79:	01 d0                	add    %edx,%eax
8010ad7b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
8010ad7f:	3c a0                	cmp    $0xa0,%al
8010ad81:	74 ca                	je     8010ad4d <debuginfo_eip+0x280>

  return 0;
8010ad83:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010ad88:	c9                   	leave  
8010ad89:	c3                   	ret    
8010ad8a:	66 90                	xchg   %ax,%ax
8010ad8c:	66 90                	xchg   %ax,%ax
8010ad8e:	66 90                	xchg   %ax,%ax

8010ad90 <__udivdi3>:
8010ad90:	55                   	push   %ebp
8010ad91:	57                   	push   %edi
8010ad92:	56                   	push   %esi
8010ad93:	53                   	push   %ebx
8010ad94:	83 ec 1c             	sub    $0x1c,%esp
8010ad97:	8b 54 24 3c          	mov    0x3c(%esp),%edx
8010ad9b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
8010ad9f:	8b 74 24 34          	mov    0x34(%esp),%esi
8010ada3:	8b 5c 24 38          	mov    0x38(%esp),%ebx
8010ada7:	85 d2                	test   %edx,%edx
8010ada9:	75 35                	jne    8010ade0 <__udivdi3+0x50>
8010adab:	39 f3                	cmp    %esi,%ebx
8010adad:	0f 87 bd 00 00 00    	ja     8010ae70 <__udivdi3+0xe0>
8010adb3:	85 db                	test   %ebx,%ebx
8010adb5:	89 d9                	mov    %ebx,%ecx
8010adb7:	75 0b                	jne    8010adc4 <__udivdi3+0x34>
8010adb9:	b8 01 00 00 00       	mov    $0x1,%eax
8010adbe:	31 d2                	xor    %edx,%edx
8010adc0:	f7 f3                	div    %ebx
8010adc2:	89 c1                	mov    %eax,%ecx
8010adc4:	31 d2                	xor    %edx,%edx
8010adc6:	89 f0                	mov    %esi,%eax
8010adc8:	f7 f1                	div    %ecx
8010adca:	89 c6                	mov    %eax,%esi
8010adcc:	89 e8                	mov    %ebp,%eax
8010adce:	89 f7                	mov    %esi,%edi
8010add0:	f7 f1                	div    %ecx
8010add2:	89 fa                	mov    %edi,%edx
8010add4:	83 c4 1c             	add    $0x1c,%esp
8010add7:	5b                   	pop    %ebx
8010add8:	5e                   	pop    %esi
8010add9:	5f                   	pop    %edi
8010adda:	5d                   	pop    %ebp
8010addb:	c3                   	ret    
8010addc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010ade0:	39 f2                	cmp    %esi,%edx
8010ade2:	77 7c                	ja     8010ae60 <__udivdi3+0xd0>
8010ade4:	0f bd fa             	bsr    %edx,%edi
8010ade7:	83 f7 1f             	xor    $0x1f,%edi
8010adea:	0f 84 98 00 00 00    	je     8010ae88 <__udivdi3+0xf8>
8010adf0:	89 f9                	mov    %edi,%ecx
8010adf2:	b8 20 00 00 00       	mov    $0x20,%eax
8010adf7:	29 f8                	sub    %edi,%eax
8010adf9:	d3 e2                	shl    %cl,%edx
8010adfb:	89 54 24 08          	mov    %edx,0x8(%esp)
8010adff:	89 c1                	mov    %eax,%ecx
8010ae01:	89 da                	mov    %ebx,%edx
8010ae03:	d3 ea                	shr    %cl,%edx
8010ae05:	8b 4c 24 08          	mov    0x8(%esp),%ecx
8010ae09:	09 d1                	or     %edx,%ecx
8010ae0b:	89 f2                	mov    %esi,%edx
8010ae0d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010ae11:	89 f9                	mov    %edi,%ecx
8010ae13:	d3 e3                	shl    %cl,%ebx
8010ae15:	89 c1                	mov    %eax,%ecx
8010ae17:	d3 ea                	shr    %cl,%edx
8010ae19:	89 f9                	mov    %edi,%ecx
8010ae1b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010ae1f:	d3 e6                	shl    %cl,%esi
8010ae21:	89 eb                	mov    %ebp,%ebx
8010ae23:	89 c1                	mov    %eax,%ecx
8010ae25:	d3 eb                	shr    %cl,%ebx
8010ae27:	09 de                	or     %ebx,%esi
8010ae29:	89 f0                	mov    %esi,%eax
8010ae2b:	f7 74 24 08          	divl   0x8(%esp)
8010ae2f:	89 d6                	mov    %edx,%esi
8010ae31:	89 c3                	mov    %eax,%ebx
8010ae33:	f7 64 24 0c          	mull   0xc(%esp)
8010ae37:	39 d6                	cmp    %edx,%esi
8010ae39:	72 0c                	jb     8010ae47 <__udivdi3+0xb7>
8010ae3b:	89 f9                	mov    %edi,%ecx
8010ae3d:	d3 e5                	shl    %cl,%ebp
8010ae3f:	39 c5                	cmp    %eax,%ebp
8010ae41:	73 5d                	jae    8010aea0 <__udivdi3+0x110>
8010ae43:	39 d6                	cmp    %edx,%esi
8010ae45:	75 59                	jne    8010aea0 <__udivdi3+0x110>
8010ae47:	8d 43 ff             	lea    -0x1(%ebx),%eax
8010ae4a:	31 ff                	xor    %edi,%edi
8010ae4c:	89 fa                	mov    %edi,%edx
8010ae4e:	83 c4 1c             	add    $0x1c,%esp
8010ae51:	5b                   	pop    %ebx
8010ae52:	5e                   	pop    %esi
8010ae53:	5f                   	pop    %edi
8010ae54:	5d                   	pop    %ebp
8010ae55:	c3                   	ret    
8010ae56:	8d 76 00             	lea    0x0(%esi),%esi
8010ae59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
8010ae60:	31 ff                	xor    %edi,%edi
8010ae62:	31 c0                	xor    %eax,%eax
8010ae64:	89 fa                	mov    %edi,%edx
8010ae66:	83 c4 1c             	add    $0x1c,%esp
8010ae69:	5b                   	pop    %ebx
8010ae6a:	5e                   	pop    %esi
8010ae6b:	5f                   	pop    %edi
8010ae6c:	5d                   	pop    %ebp
8010ae6d:	c3                   	ret    
8010ae6e:	66 90                	xchg   %ax,%ax
8010ae70:	31 ff                	xor    %edi,%edi
8010ae72:	89 e8                	mov    %ebp,%eax
8010ae74:	89 f2                	mov    %esi,%edx
8010ae76:	f7 f3                	div    %ebx
8010ae78:	89 fa                	mov    %edi,%edx
8010ae7a:	83 c4 1c             	add    $0x1c,%esp
8010ae7d:	5b                   	pop    %ebx
8010ae7e:	5e                   	pop    %esi
8010ae7f:	5f                   	pop    %edi
8010ae80:	5d                   	pop    %ebp
8010ae81:	c3                   	ret    
8010ae82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010ae88:	39 f2                	cmp    %esi,%edx
8010ae8a:	72 06                	jb     8010ae92 <__udivdi3+0x102>
8010ae8c:	31 c0                	xor    %eax,%eax
8010ae8e:	39 eb                	cmp    %ebp,%ebx
8010ae90:	77 d2                	ja     8010ae64 <__udivdi3+0xd4>
8010ae92:	b8 01 00 00 00       	mov    $0x1,%eax
8010ae97:	eb cb                	jmp    8010ae64 <__udivdi3+0xd4>
8010ae99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010aea0:	89 d8                	mov    %ebx,%eax
8010aea2:	31 ff                	xor    %edi,%edi
8010aea4:	eb be                	jmp    8010ae64 <__udivdi3+0xd4>
8010aea6:	66 90                	xchg   %ax,%ax
8010aea8:	66 90                	xchg   %ax,%ax
8010aeaa:	66 90                	xchg   %ax,%ax
8010aeac:	66 90                	xchg   %ax,%ax
8010aeae:	66 90                	xchg   %ax,%ax

8010aeb0 <__umoddi3>:
8010aeb0:	55                   	push   %ebp
8010aeb1:	57                   	push   %edi
8010aeb2:	56                   	push   %esi
8010aeb3:	53                   	push   %ebx
8010aeb4:	83 ec 1c             	sub    $0x1c,%esp
8010aeb7:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
8010aebb:	8b 74 24 30          	mov    0x30(%esp),%esi
8010aebf:	8b 5c 24 34          	mov    0x34(%esp),%ebx
8010aec3:	8b 7c 24 38          	mov    0x38(%esp),%edi
8010aec7:	85 ed                	test   %ebp,%ebp
8010aec9:	89 f0                	mov    %esi,%eax
8010aecb:	89 da                	mov    %ebx,%edx
8010aecd:	75 19                	jne    8010aee8 <__umoddi3+0x38>
8010aecf:	39 df                	cmp    %ebx,%edi
8010aed1:	0f 86 b1 00 00 00    	jbe    8010af88 <__umoddi3+0xd8>
8010aed7:	f7 f7                	div    %edi
8010aed9:	89 d0                	mov    %edx,%eax
8010aedb:	31 d2                	xor    %edx,%edx
8010aedd:	83 c4 1c             	add    $0x1c,%esp
8010aee0:	5b                   	pop    %ebx
8010aee1:	5e                   	pop    %esi
8010aee2:	5f                   	pop    %edi
8010aee3:	5d                   	pop    %ebp
8010aee4:	c3                   	ret    
8010aee5:	8d 76 00             	lea    0x0(%esi),%esi
8010aee8:	39 dd                	cmp    %ebx,%ebp
8010aeea:	77 f1                	ja     8010aedd <__umoddi3+0x2d>
8010aeec:	0f bd cd             	bsr    %ebp,%ecx
8010aeef:	83 f1 1f             	xor    $0x1f,%ecx
8010aef2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
8010aef6:	0f 84 b4 00 00 00    	je     8010afb0 <__umoddi3+0x100>
8010aefc:	b8 20 00 00 00       	mov    $0x20,%eax
8010af01:	89 c2                	mov    %eax,%edx
8010af03:	8b 44 24 04          	mov    0x4(%esp),%eax
8010af07:	29 c2                	sub    %eax,%edx
8010af09:	89 c1                	mov    %eax,%ecx
8010af0b:	89 f8                	mov    %edi,%eax
8010af0d:	d3 e5                	shl    %cl,%ebp
8010af0f:	89 d1                	mov    %edx,%ecx
8010af11:	89 54 24 0c          	mov    %edx,0xc(%esp)
8010af15:	d3 e8                	shr    %cl,%eax
8010af17:	09 c5                	or     %eax,%ebp
8010af19:	8b 44 24 04          	mov    0x4(%esp),%eax
8010af1d:	89 c1                	mov    %eax,%ecx
8010af1f:	d3 e7                	shl    %cl,%edi
8010af21:	89 d1                	mov    %edx,%ecx
8010af23:	89 7c 24 08          	mov    %edi,0x8(%esp)
8010af27:	89 df                	mov    %ebx,%edi
8010af29:	d3 ef                	shr    %cl,%edi
8010af2b:	89 c1                	mov    %eax,%ecx
8010af2d:	89 f0                	mov    %esi,%eax
8010af2f:	d3 e3                	shl    %cl,%ebx
8010af31:	89 d1                	mov    %edx,%ecx
8010af33:	89 fa                	mov    %edi,%edx
8010af35:	d3 e8                	shr    %cl,%eax
8010af37:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
8010af3c:	09 d8                	or     %ebx,%eax
8010af3e:	f7 f5                	div    %ebp
8010af40:	d3 e6                	shl    %cl,%esi
8010af42:	89 d1                	mov    %edx,%ecx
8010af44:	f7 64 24 08          	mull   0x8(%esp)
8010af48:	39 d1                	cmp    %edx,%ecx
8010af4a:	89 c3                	mov    %eax,%ebx
8010af4c:	89 d7                	mov    %edx,%edi
8010af4e:	72 06                	jb     8010af56 <__umoddi3+0xa6>
8010af50:	75 0e                	jne    8010af60 <__umoddi3+0xb0>
8010af52:	39 c6                	cmp    %eax,%esi
8010af54:	73 0a                	jae    8010af60 <__umoddi3+0xb0>
8010af56:	2b 44 24 08          	sub    0x8(%esp),%eax
8010af5a:	19 ea                	sbb    %ebp,%edx
8010af5c:	89 d7                	mov    %edx,%edi
8010af5e:	89 c3                	mov    %eax,%ebx
8010af60:	89 ca                	mov    %ecx,%edx
8010af62:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
8010af67:	29 de                	sub    %ebx,%esi
8010af69:	19 fa                	sbb    %edi,%edx
8010af6b:	8b 5c 24 04          	mov    0x4(%esp),%ebx
8010af6f:	89 d0                	mov    %edx,%eax
8010af71:	d3 e0                	shl    %cl,%eax
8010af73:	89 d9                	mov    %ebx,%ecx
8010af75:	d3 ee                	shr    %cl,%esi
8010af77:	d3 ea                	shr    %cl,%edx
8010af79:	09 f0                	or     %esi,%eax
8010af7b:	83 c4 1c             	add    $0x1c,%esp
8010af7e:	5b                   	pop    %ebx
8010af7f:	5e                   	pop    %esi
8010af80:	5f                   	pop    %edi
8010af81:	5d                   	pop    %ebp
8010af82:	c3                   	ret    
8010af83:	90                   	nop
8010af84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010af88:	85 ff                	test   %edi,%edi
8010af8a:	89 f9                	mov    %edi,%ecx
8010af8c:	75 0b                	jne    8010af99 <__umoddi3+0xe9>
8010af8e:	b8 01 00 00 00       	mov    $0x1,%eax
8010af93:	31 d2                	xor    %edx,%edx
8010af95:	f7 f7                	div    %edi
8010af97:	89 c1                	mov    %eax,%ecx
8010af99:	89 d8                	mov    %ebx,%eax
8010af9b:	31 d2                	xor    %edx,%edx
8010af9d:	f7 f1                	div    %ecx
8010af9f:	89 f0                	mov    %esi,%eax
8010afa1:	f7 f1                	div    %ecx
8010afa3:	e9 31 ff ff ff       	jmp    8010aed9 <__umoddi3+0x29>
8010afa8:	90                   	nop
8010afa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010afb0:	39 dd                	cmp    %ebx,%ebp
8010afb2:	72 08                	jb     8010afbc <__umoddi3+0x10c>
8010afb4:	39 f7                	cmp    %esi,%edi
8010afb6:	0f 87 21 ff ff ff    	ja     8010aedd <__umoddi3+0x2d>
8010afbc:	89 da                	mov    %ebx,%edx
8010afbe:	89 f0                	mov    %esi,%eax
8010afc0:	29 f8                	sub    %edi,%eax
8010afc2:	19 ea                	sbb    %ebp,%edx
8010afc4:	e9 14 ff ff ff       	jmp    8010aedd <__umoddi3+0x2d>
