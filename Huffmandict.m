function dict = Huffmandict(C,p)
%{
    node = cell(1,length(p));
    [p,d] = sort(p);
    C = C(d);
    while(length(p)>2)
       p(2) = p(1) + p(2) ;  %��s����v
       p(1) = [];
       node{1} = {}; %��̤p����Ӧ�m
    end
    HD = node;
%}
tree = cell(length(p),1); %���ͻP�}�Cp�ۦP���ת�cell
dict = cell(2,length(p));
dict(1,:) = C;
for i=1:length(p)
    tree{i}=i;            %�C�Ӹ`�I����l�Ȩ̧Ǭ�1,2,3...
end
while numel(tree)>2
    [p, pos] = sort(p,'ascend');   %�q�p�ƨ�j
    p(2)=p(1)+p(2);                %�N�̤p�Φ��p���Ȭۥ[,�s�즸�p��m
    p(1)=[];                       %�R���̤p����,�]���}�Cp�ӼƤ֤@��
    tree = tree(pos);              %�`�I�̷�p�Ȥj�p�Ƨ�
    tree{2}={tree{1},tree{2}};     %�̤p�Φ��p���`�I�X�֡A�s�ܦ��p�`�I��
    tree(1)=[];                    %�R���̤p���`�I
end
HD = tree;
%[i,c]=prhcode(tree,[]);
%dict(2,i) = c;
dict = prhcode(tree,[],dict);

function dict = prhcode(tree,code,dict)
if isa(tree,'cell')
    dict=prhcode(tree{1},[code '0'],dict);
    dict=prhcode(tree{2},[code '1'],dict);
else
%     mystr = strcat(num2str(tree) , '=' , code);
%     disp(mystr);
    dict{2,tree} = code;
end