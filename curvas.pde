void curva( float x1, float y1, boolean p1, boolean p2 , float x2, float y2 ) {
  noFill();
  beginShape();
  curveVertex( x1, y1 );
  curveVertex( x1, y1 );
  
  float dx = x2 - x1;
  float dy = y2 - y1;
  
  float d = sqrt( dx*dx + dy *dy);

  int fact1 = (p1 ? +1 : -1 );
  
  float ax = x1 + dx/(p2?5:2) + fact1 * (d/3* -dy/ d)  + fact1 * random( d / 10);
  float ay = y1 + dy/(p2?5:2) + fact1 * (d/3* dx / d)  + fact1 * random( d / 10);
  
  curveVertex( ax,ay );

  if (p2 ) {
    int fact2 = (p1 ? -1 : +1 );

    float bx = x1 + 4*dx/5 + fact2 * (d/3*-dy/d) + fact2 * random(d / 10);
    float by = y1 + 4*dy/5 + fact2 * (d/3*dx/d) + fact2 * random(d / 10);
  
    curveVertex( bx,by );
  }
  curveVertex( x2, y2 );  
  curveVertex( x2, y2 );  
  endShape();   
}