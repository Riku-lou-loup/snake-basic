10 rem snake64
20 poke 53280,0:poke 53281,0:sr=rnd(-ti)
30 gosub 1000
40 gosub 2000
50 gosub 3000
60 goto 500
500 tt=ti+sp
510 get a$:if a$<>"" then gosub 7000
520 if ti<tt then 510
530 ox=sx(1):oy=sy(1):nx=ox+dx:ny=oy+dy
540 if nx<x1 or nx>x2 or ny<y1 or ny>y2 then gosub 8000:goto 40
550 g=0:if nx=fx and ny=fy then g=1
560 lim=l-1+g:hc=0
570 for i=2 to lim
580 if sx(i)=nx then if sy(i)=ny then hc=1
590 next
600 if hc=1 then gosub 8000:goto 40
610 if g=0 then tx=sx(l):ty=sy(l)
620 for i=l+g to 2 step -1:sx(i)=sx(i-1):sy(i)=sy(i-1):next
630 if g=1 then l=l+1
640 sx(1)=nx:sy(1)=ny
650 if g=0 then r=ty:c=tx:cl=0:t$=" ":gosub 9000
660 r=oy:c=ox:cl=13:t$="o":gosub 9000
670 r=ny:c=nx:cl=5:t$="q":gosub 9000
680 if g=0 then 500
690 sc=sc+10
700 sp=5-int(sc/80):if sp<2 then sp=2
710 gosub 3600
720 gosub 4000
730 goto 500
1000 print chr$(147);
1010 poke 646,1
1020 print tab(12)"s n a k e  6 4"
1030 print
1040 print "w a s d to move"
1050 print "eat * to grow"
1060 print "don't hit walls or yourself"
1070 print
1080 print "press space to start"
1090 get a$:if a$<>" " then 1090
1095 return
2000 x1=6:y1=5:x2=33:y2=21:sp=5:sc=0
2010 if z=0 then dim sx(255),sy(255):z=1
2020 l=4:dx=1:dy=0
2030 sx(1)=16:sy(1)=13
2040 sx(2)=15:sy(2)=13
2050 sx(3)=14:sy(3)=13
2060 sx(4)=13:sy(4)=13
2070 return
3000 print chr$(147);
3010 gosub 3500
3020 gosub 3600
3030 gosub 4000
3040 return
3500 cl=14
3510 for c=x1-1 to x2+1:r=y1-1:t$="#":gosub 9000:r=y2+1:gosub 9000:next
3520 for r=y1 to y2:c=x1-1:t$="#":gosub 9000:c=x2+1:gosub 9000:next
3530 for i=l to 2 step -1:r=sy(i):c=sx(i):cl=13:t$="o":gosub 9000:next
3540 r=sy(1):c=sx(1):cl=5:t$="q":gosub 9000
3550 return
3600 r=1:c=1:cl=1:t$="score"+str$(sc)+"   ":gosub 9000
3610 return
4000 fx=int(rnd(1)*(x2-x1+1))+x1
4010 fy=int(rnd(1)*(y2-y1+1))+y1
4020 for i=1 to l:if sx(i)=fx and sy(i)=fy then 4000
4030 r=fy:c=fx:cl=2:t$="*":gosub 9000
4040 return
7000 if a$="w" then if dy<>1 then dx=0:dy=-1
7010 if a$="s" then if dy<>-1 then dx=0:dy=1
7020 if a$="a" then if dx<>1 then dx=-1:dy=0
7030 if a$="d" then if dx<>-1 then dx=1:dy=0
7040 return
8000 r=23:c=6:cl=10:t$="game over - press r to restart or q to quit":gosub 9000
8010 get a$:if a$<>"r" and a$<>"q" then 8010
8020 if a$="q" then print chr$(147);:end
8030 return
9000 poke 646,cl:poke 211,c:poke 214,r:sys 58732:print t$;:return
