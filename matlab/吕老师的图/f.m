function z = f(x,y,mux,muy,sgmx,sgmy,r)
    z = 1/(2*pi*sgmx*sgmy*sqrt(1-r*r))*exp(-1/(2*(1-r*r)).*((x-mux).*(x-mux)./(sgmx*sgmx)-(2*r).*(x-mux).*(y-muy)./(sgmx*sgmy)+(y-muy).*(y-muy)./(sgmy*sgmy)));
end