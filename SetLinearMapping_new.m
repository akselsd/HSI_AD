function DBN = SetLinearMapping_new( DBN, IN, OUT )
    nrbm = numel(DBN.rbm);
    
    Hall            = v2hall_new( DBN, IN );
    DBN.rbm{nrbm}.W = pinv(Hall{nrbm-1}) * OUT;
    DBN.rbm{nrbm}.b = -0.5 * ones(size(DBN.rbm{nrbm}.b));
end