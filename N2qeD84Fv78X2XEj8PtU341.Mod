MODULE N2qeD84Fv78X2XEj8PtU341;(*anonymous module created by saboteur*)
  
IMPORT Objects, Base, Out:=KernelLog, Random;

TYPE Ray = Base.Ray;
	Voxel = Base.Voxel;  
	PT =Base.PT;
VAR 	
	cage: OutlineVox;

TYPE TransparaVox*=OBJECT(Base.Voxel);
VAR
	r, g, b, black: REAL;	
PROCEDURE setcolor* (red, green, blue,bl , a : REAL); 
BEGIN
	r := red;
	g := green;
	b := blue;
	black:=bl;
	passable := TRUE;
END setcolor;

PROCEDURE Shade (VAR ray: Ray);
VAR 
	depth: REAL;
	exit:PT;
	dr,dg,db,dbl: REAL;
BEGIN
	exit:=Base.Exit(ray);
	depth:=Base.dist(ray.lxyz,exit);
	dr := r*depth;
	dg := g*depth;
	db := b*depth;
	dbl:=black*depth;
	ray.r := ray.r + dr;
	ray.g := ray.g + dg;
	ray.b := ray.b + db; 
	ray.ra := (ray.ra - dr)-dbl;
	ray.ga := (ray.ga - dg)-dbl;
	ray.ba := (ray.ba - db)-dbl; 
	IF (ray.ra<0.1)&(ray.ga<0.1)&(ray.ba<0.1) THEN ray.terminate:=TRUE 
	ELSE ray.lxyz:=exit;
	END
END Shade;

END TransparaVox;  

TYPE OutlineVox*=OBJECT(Voxel);
VAR
	or, og, ob,oa: REAL;
	nx, ny, nz: INTEGER;
	dot: REAL;
	inside: BOOLEAN;
	X:REAL;
	blue: TransparaVox;
	innard: Voxel;
	
PROCEDURE&init*;
BEGIN
	setoutline(0,0,0,1/2);
	NEW(blue);
	blue.setcolor(0,0,1/11,1/11,0);
	innard:=Base.VoxelFromName("NM3");	
	innard.setcolor(0,0,1,1,0);
	passable:=TRUE;
	copyonstroke:=TRUE;
	complex:=FALSE;	
END init;	
PROCEDURE setoutline* (red, green, blue,alpha: REAL);
BEGIN
	or := red ;
	og := green ;
	ob := blue;
	oa:=alpha;
END setoutline;
PROCEDURE Shade (VAR ray: Ray);
VAR
	nx, ny, nz: INTEGER;
	e: REAL;
	inside: BOOLEAN;
	ecount:INTEGER;
	a: REAL;
	exit:PT;
BEGIN
	IF (ray.lxyz.x< 0.011) OR (ray.lxyz.x > 0.989) THEN INC(ecount) END;
	IF (ray.lxyz.y <0.011) OR (ray.lxyz.y > 0.989) THEN INC(ecount) END;
	IF (ray.lxyz.z < 0.011) OR (ray.lxyz.z > 0.989) THEN INC(ecount) END;
	IF (ecount > 1) THEN
		ray.r := ray.r + or * ray.ra*oa;
		ray.g := ray.g + og * ray.ga*oa;
		ray.b := ray.b + ob * ray.ba*oa;
			ray.ra:= ray.ra - oa;
		ray.ga:=ray.ga-oa;
		ray.ba:=ray.ba-oa;
	END;
	exit:= Base.Exit(ray);
	ecount:=0;
	IF (exit.x< 0.011) OR (exit.x > 0.989) THEN INC(ecount) END;
	IF (exit.y <0.011) OR (exit.y > 0.989) THEN INC(ecount) END;
	IF (exit.z < 0.011) OR (exit.z > 0.989) THEN INC(ecount) END;
	IF (ecount > 1) THEN
		a:=1/2;
		ray.r := ray.r + or * ray.ra*a;
		ray.g := ray.g + og * ray.ga*a;
		ray.b := ray.b + ob * ray.ba*a;
		a:=1-a;
		ray.ra:= ray.ra - a;
		ray.ga:=ray.ga-a;
		ray.ba:=ray.ba-a;
	END;	
END Shade;

PROCEDURE strokerec*(p:PT; resolution,scale: LONGINT; voxel,vu:Voxel);
BEGIN
	innard.strokerec(p,resolution,scale,voxel,vu);
END strokerec;
	
END OutlineVox;

PROCEDURE thisvox*():Base.Voxel;
BEGIN
	NEW(cage);
	cage.setoutline(0,0,0,1);
	RETURN cage
END thisvox;

	
END N2qeD84Fv78X2XEj8PtU341. 
 
XNXLMarsh.Rez N2qeD84Fv78X2XEj8PtUZOQ ~
 
