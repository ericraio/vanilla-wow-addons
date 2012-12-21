function ArcHUD:SplitString(s,p,n)
	local l,sp,ep = {},0
	while(sp) do
		sp,ep=strfind(s,p)
		if(sp) then
			tinsert(l,strsub(s,1,sp-1))
			s=strsub(s,ep+1)
		else
			tinsert(l,s)
			break
		end
		if(n) then n=n-1 end
		if(n and (n==0)) then tinsert(l,s) break end
	end
	return unpack(l)
end

function ArcHUD:strcap(str)
   return strupper(strsub(str, 1, 1)) .. strlower(strsub(str, 2))
end
