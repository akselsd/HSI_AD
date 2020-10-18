function DBN = SetLinearMapping_new( DBN, V, OUT )
    nrbm = numel(DBN.rbm);
    
    Hall            = v2hall_new( DBN, V );
    DBN.rbm{nrbm}.W = pinv(Hall{nrbm-1}) * OUT;
    DBN.rbm{nrbm}.b = -0.5 * ones(size(DBN.rbm{nrbm}.b));
end