n = freq;
n1 = n'; 
n1( size(n,1) + 1 ,size(n,2) + 1 ) = 0; 

% Generate grid for 2-D projected view of intensities
xb = linspace(min(tmp(:,1)),max(tmp(:,1)),size(n,1)+1);
yb = linspace(min(tmp(:,2)),max(tmp(:,2)),size(n,1)+1);

% Make a pseudocolor plot on this grid 
h = pcolor(xb,yb,(n1).^.3); 

% Set the z-level and colormap of the displayed grid
set(h, 'zdata', ones(size(n1)) * -max(max(n))) 
colormap(jet) % heat map 