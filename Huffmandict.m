function dict = Huffmandict(C,p)
%{
    node = cell(1,length(p));
    [p,d] = sort(p);
    C = C(d);
    while(length(p)>2)
       p(2) = p(1) + p(2) ;  %更新後機率
       p(1) = [];
       node{1} = {}; %放最小的兩個位置
    end
    HD = node;
%}
tree = cell(length(p),1); %產生與陣列p相同長度的cell
dict = cell(2,length(p));
dict(1,:) = C;
for i=1:length(p)
    tree{i}=i;            %每個節點的初始值依序為1,2,3...
end
while numel(tree)>2
    [p, pos] = sort(p,'ascend');   %從小排到大
    p(2)=p(1)+p(2);                %將最小及次小的值相加,存到次小位置
    p(1)=[];                       %刪除最小的值,因此陣列p個數少一個
    tree = tree(pos);              %節點依照p值大小排序
    tree{2}={tree{1},tree{2}};     %最小及次小的節點合併，存至次小節點內
    tree(1)=[];                    %刪除最小的節點
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