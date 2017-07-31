function z = asysm(y, lambda, p, d);
% Baseline estimation with asymmetric least squares
% y:      signal
% lambda: smoothing parameter (generally 1e5 to 1e8)
% p:      asymmetry parameter (generally 0.001)
% d:      order of differences in penalty (generally 2)


[m,n]=size(y);
if n==1
    m = length(y);
    w = ones(m, 1);
    repeat = 1;
    iter=1;
    while repeat && iter<=50
       z = difsmw(y, lambda, w, d);
       w0 = w;
       w = p * (y > z) + (1 - p) * (y <= z);
       repeat = sum(abs(w - w0)) > 0;
       iter=iter+1;
    end
    if iter>50
        warning('Maximum iteration number reached!')
    end
else
    z=zeros(m,n);
    for i=1:n
        disp(i)
        y2=y(:,i);
        w = ones(m, 1);
        repeat = 1;
        iter=1;
        while repeat && iter<=50
           z2 = difsmw(y2, lambda, w, d);
           w0 = w;
           w = p * (y2 > z2) + (1 - p) * (y2 <= z2);
           repeat = sum(abs(w - w0)) > 0;
           iter=iter+1;
        end
        if iter>50
            warning('Maximum iteration number reached!')
        end
        z(:,i)=z2;
    end
end