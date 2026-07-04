package com.example.nhatkyduonghuyet.ui.navigation

import androidx.compose.runtime.Composable
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.nhatkyduonghuyet.viewmodel.MainViewModel
import com.example.nhatkyduonghuyet.ui.dashboard.DashboardScreen

@Composable
fun AppNav() {
    val vm: MainViewModel = viewModel()
    DashboardScreen(vm)
}
