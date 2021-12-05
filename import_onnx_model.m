% This file is used to save onnx file to a matlab function
modelfile = 'uncer_model.onnx';
% net = importONNXNetwork(modelfile,'OutputLayerType','regression')
params = importONNXFunction(modelfile,'uncer_func')

save('params.mat','params')
