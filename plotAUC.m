% created by: Dordije Boskovic

% used to compare detection statistic map created target detection algorithm
% with ground truth, and calculate MCC score for given th

% ds_vector= input vector from TD algorithm
% th = threshold value
% gt = ground truth matrix
% value = chosen ground truth component

function auc = plotAUC (an_score, an_map)


	[m, n]   = size(an_map);
	an_score = reshape( an_score, m, n);
    
    thres = linspace(min(an_score(:)), max(an_score(:)), 10);

    tpr = zeros(numel(thres), 1); 
    fpr = zeros(numel(thres), 1); 

	positives = sum(an_map(:) == 1);
    negatives = m*n - positives;

    for i= 1:numel(thres)
        tp=0;
        fp=0;
        fn=0;
        tn=0;
        for j = 1:m
            for k = 1:n            
                if and(an_map(j,k) == 1, an_score(j,k) >= thres(i))
                    tp = tp + 1;
                elseif and(an_map(j,k) == 1, an_score(j,k) < thres(i))
                    fn = fn + 1;
                elseif an_score(j,k) >= thres(i)
                    fp = fp + 1;
                else
                    tn = tn + 1;
                end      

            end
        end
        
        tpr(i) = tp;
        fpr(i) = fp;    
        
    end	
            
    %ROC 
    tpr= tpr./positives;
    fpr= fpr./negatives;
    
    tpr = tpr(end:-1:1);
    fpr = fpr(end:-1:1);
    
    figure()
    plot(fpr , tpr, '-' , 'Linewidth' , 2);
    auc = trapz(fpr,tpr);  
    set(gca, 'XScale', 'log');

end